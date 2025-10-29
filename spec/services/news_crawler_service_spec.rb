require 'rails_helper'

RSpec.describe NewsCrawlerService, type: :service do
  let(:service) { NewsCrawlerService.new }
  
  let(:sample_rss_feed) do
    <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <rss version="2.0">
        <channel>
          <title>Test News Feed</title>
          <item>
            <title>Bitcoin Price Surges</title>
            <description><![CDATA[<p>Bitcoin reaches new highs today.</p>]]></description>
            <link>https://example.com/news/1</link>
            <pubDate>#{Time.current.rfc822}</pubDate>
          </item>
          <item>
            <title>Ethereum Update</title>
            <description><![CDATA[<p>Ethereum &amp; blockchain news.</p>]]></description>
            <link>https://example.com/news/2</link>
            <pubDate>#{(Time.current - 1.hour).rfc822}</pubDate>
          </item>
        </channel>
      </rss>
    XML
  end

  describe '#initialize' do
    it 'loads RSS sources from config file' do
      expect(service.instance_variable_get(:@rss_sources)).to be_an(Array)
      expect(service.instance_variable_get(:@rss_sources).length).to be > 0
    end
  end

  describe '#crawl_all_sources' do
    context 'in test environment' do
      it 'returns empty array without making HTTP requests' do
        allow(Rails.env).to receive(:test?).and_return(true)
        result = NewsCrawlerService.new.crawl_all_sources
        expect(result).to eq([])
      end
    end
  end

  describe '#save_articles' do
    let(:article_data) do
      {
        title: "Test Article",
        subtitle: "Test subtitle",
        original_url: "https://example.com/news",
        published_at: Time.current,
        source: "Test Source"
      }
    end

    it 'saves new articles to database' do
      expect {
        service.send(:save_articles, [article_data])
      }.to change(NewsArticle, :count).by(1)
      
      article = NewsArticle.last
      expect(article.title).to eq("Test Article")
      expect(article.source).to eq("Test Source")
    end

    it 'prevents duplicate articles by title' do
      create(:news_article, title: "Test Article")
      
      expect {
        service.send(:save_articles, [article_data])
      }.not_to change(NewsArticle, :count)
    end

    it 'saves multiple unique articles' do
      articles_data = [
        article_data,
        { title: "Second Article", subtitle: "Sub", original_url: "https://example.com/2", published_at: Time.current, source: "Test" }
      ]
      
      expect {
        service.send(:save_articles, articles_data)
      }.to change(NewsArticle, :count).by(2)
    end
  end

  describe '#valid_article?' do
    it 'returns true for valid article' do
      article = {
        title: "Valid Title",
        original_url: "https://example.com",
        published_at: Time.current
      }
      expect(service.send(:valid_article?, article)).to be true
    end

    it 'returns false when title is missing' do
      article = {
        original_url: "https://example.com",
        published_at: Time.current
      }
      expect(service.send(:valid_article?, article)).to be false
    end

    it 'returns false when original_url is missing' do
      article = {
        title: "Title",
        published_at: Time.current
      }
      expect(service.send(:valid_article?, article)).to be false
    end

    it 'returns false when published_at is missing' do
      article = {
        title: "Title",
        original_url: "https://example.com"
      }
      expect(service.send(:valid_article?, article)).to be false
    end
  end

  describe '#parse_published_time' do
    it 'parses published time from entry' do
      entry = double('entry', published: 'Mon, 01 Jan 2023 12:00:00 GMT', updated: nil, last_modified: nil)
      time = service.send(:parse_published_time, entry)
      expect(time).to be_a(Time)
      expect(time.year).to eq(2023)
    end

    it 'falls back to updated time if published is nil' do
      entry = double('entry', published: nil, updated: 'Tue, 02 Jan 2023 13:00:00 GMT', last_modified: nil)
      time = service.send(:parse_published_time, entry)
      expect(time.year).to eq(2023)
      expect(time.month).to eq(1)
      expect(time.day).to eq(2)
    end

    it 'falls back to last_modified if published and updated are nil' do
      entry = double('entry', published: nil, updated: nil, last_modified: 'Wed, 03 Jan 2023 14:00:00 GMT')
      time = service.send(:parse_published_time, entry)
      expect(time.year).to eq(2023)
      expect(time.month).to eq(1)
      expect(time.day).to eq(3)
    end

    it 'falls back to current time if all time fields fail to parse' do
      entry = double('entry', published: 'invalid time', updated: 'also invalid', last_modified: nil)
      allow(Time).to receive(:parse).and_raise(ArgumentError.new("invalid time"))
      time = service.send(:parse_published_time, entry)
      expect(time).to be_a(Time)
      expect(time).to be_within(1.second).of(Time.current)
    end

    it 'falls back to current time if all time fields are nil' do
      entry = double('entry', published: nil, updated: nil, last_modified: nil)
      time = service.send(:parse_published_time, entry)
      expect(time).to be_a(Time)
      expect(time).to be_within(1.second).of(Time.current)
    end
  end

  describe '#extract_subtitle' do
    it 'extracts subtitle from summary' do
      entry = double('entry', summary: 'This is a summary', content: nil, description: nil)
      expect(service.send(:extract_subtitle, entry)).to eq('This is a summary')
    end

    it 'extracts subtitle from content if summary is nil' do
      entry = double('entry', summary: nil, content: 'This is content', description: nil)
      expect(service.send(:extract_subtitle, entry)).to eq('This is content')
    end

    it 'extracts subtitle from description if summary and content are nil' do
      entry = double('entry', summary: nil, content: nil, description: 'This is description')
      expect(service.send(:extract_subtitle, entry)).to eq('This is description')
    end

    it 'returns empty string if all fields are nil' do
      entry = double('entry', summary: nil, content: nil, description: nil)
      expect(service.send(:extract_subtitle, entry)).to eq('')
    end

    it 'strips HTML tags from subtitle' do
      entry = double('entry', summary: '<b>Bold</b> text <p>with paragraph</p>', content: nil, description: nil)
      result = service.send(:extract_subtitle, entry)
      expect(result).to eq('Bold text with paragraph')
    end

    it 'cleans HTML entities from subtitle' do
      entry = double('entry', summary: 'Text &amp; more &quot;quoted&quot;', content: nil, description: nil)
      result = service.send(:extract_subtitle, entry)
      expect(result).to eq('Text & more "quoted"')
    end
  end

  describe '#contains_media_content?' do
    it 'detects podcast in title' do
      article = {
        title: "Weekly Podcast Episode",
        subtitle: "",
        original_url: "https://example.com"
      }
      expect(service.send(:contains_media_content?, article)).to be true
    end

    it 'detects youtube.com in URL' do
      article = {
        title: "News Video",
        subtitle: "",
        original_url: "https://youtube.com/watch?v=123"
      }
      expect(service.send(:contains_media_content?, article)).to be true
    end

    it 'detects interview keyword' do
      article = {
        title: "CEO Interview",
        subtitle: "",
        original_url: "https://example.com"
      }
      expect(service.send(:contains_media_content?, article)).to be true
    end

    it 'returns false for regular news article' do
      article = {
        title: "Bitcoin Price Update",
        subtitle: "Market analysis",
        original_url: "https://example.com/news"
      }
      expect(service.send(:contains_media_content?, article)).to be false
    end
  end

  describe '#strip_html_tags' do
    it 'removes HTML tags from text' do
      html = "<p>Hello <strong>World</strong></p>"
      result = service.send(:strip_html_tags, html)
      expect(result).to eq("Hello World")
    end

    it 'handles empty string' do
      expect(service.send(:strip_html_tags, "")).to eq("")
    end
  end

  describe '#clean_text' do
    it 'replaces HTML entities' do
      text = "News &amp; Updates"
      result = service.send(:clean_text, text)
      expect(result).to eq("News & Updates")
      
      text2 = "&quot;Quote&quot;"
      result2 = service.send(:clean_text, text2)
      expect(result2).to eq("\"Quote\"")
    end
    
    it 'replaces &amp; with &' do
      text = "News &amp; Updates"
      result = service.send(:clean_text, text)
      expect(result).to eq("News & Updates")
    end
    
    it 'replaces &quot; with double quote' do
      text = "&quot;Quote&quot;"
      result = service.send(:clean_text, text)
      expect(result).to eq("\"Quote\"")
    end

    it 'replaces &lt; with <' do
      text = "Value &lt; 100"
      result = service.send(:clean_text, text)
      expect(result).to eq("Value < 100")
    end

    it 'replaces &gt; with >' do
      text = "Value &gt; 100"
      result = service.send(:clean_text, text)
      expect(result).to eq("Value > 100")
    end

    it 'replaces &nbsp; with space' do
      text = "Text&nbsp;with&nbsp;nbsp"
      result = service.send(:clean_text, text)
      expect(result).to eq("Text with nbsp")
    end

    it 'removes extra whitespace' do
      text = "Multiple    spaces    here"
      result = service.send(:clean_text, text)
      expect(result).to eq("Multiple spaces here")
    end

    it 'strips leading and trailing whitespace' do
      text = "   Trimmed   "
      result = service.send(:clean_text, text)
      expect(result).to eq("Trimmed")
    end

    it 'handles all HTML entities together' do
      text = "Text &lt;value&gt; &amp; &quot;quote&quot; &nbsp; more"
      result = service.send(:clean_text, text)
      expect(result).to include("<value>")
      expect(result).to include("&")
      expect(result).to include("\"quote\"")
      expect(result).to include("more")
    end
  end

  describe '#load_rss_sources' do
    it 'loads sources from YAML config' do
      sources = service.send(:load_rss_sources)
      expect(sources).to be_an(Array)
    end

    it 'returns empty array if sources key is missing' do
      allow(YAML).to receive(:load_file).and_return({})
      service = NewsCrawlerService.new
      sources = service.send(:load_rss_sources)
      expect(sources).to eq([])
    end
  end

  describe '#crawl_all_sources' do
    context 'non-test environment with error handling' do
      before do
        allow(Rails.env).to receive(:test?).and_return(false)
      end

      it 'handles errors gracefully and continues with other sources' do
        service.instance_variable_set(:@rss_sources, [
          { 'name' => 'Source 1', 'url' => 'http://example.com/rss1' },
          { 'name' => 'Source 2', 'url' => 'http://example.com/rss2' }
        ])

        stub_request(:get, "http://example.com/rss1").to_raise(StandardError.new("Network error"))
        stub_request(:get, "http://example.com/rss2").to_return(
          status: 200,
          body: sample_rss_feed,
          headers: { 'Content-Type' => 'application/rss+xml' }
        )

        expect(Rails.logger).to receive(:error).with(/Failed to crawl Source 1: Network error/)
        result = service.crawl_all_sources
        expect(result).to be_an(Array)
      end
    end
  end

  describe '#crawl_source' do
    let(:source_config) { { 'name' => 'Test Source', 'url' => 'http://example.com/test_rss' } }

    it 'fetches and parses RSS feed successfully' do
      stub_request(:get, source_config['url']).to_return(
        status: 200,
        body: sample_rss_feed,
        headers: { 'Content-Type' => 'application/rss+xml' }
      )

      expect(Rails.logger).to receive(:info).with(/Crawling Test Source/)
      expect(Rails.logger).to receive(:info).with(/Found \d+ articles from Test Source/)

      articles = service.send(:crawl_source, source_config)
      expect(articles).to be_an(Array)
      expect(articles.length).to eq(2)
    end

    it 'filters invalid articles missing title' do
      invalid_rss = <<~XML
        <?xml version="1.0"?>
        <rss><channel>
          <item>
            <title></title>
            <link>http://test.com</link>
            <pubDate>#{Time.current.rfc822}</pubDate>
          </item>
        </channel></rss>
      XML

      stub_request(:get, source_config['url']).to_return(
        status: 200,
        body: invalid_rss,
        headers: { 'Content-Type' => 'application/rss+xml' }
      )

      articles = service.send(:crawl_source, source_config)
      expect(articles).to be_empty
    end

    it 'strips title whitespace' do
      rss_with_spaces = <<~XML
        <?xml version="1.0"?>
        <rss><channel>
          <item>
            <title>  Title with spaces  </title>
            <link>http://test.com</link>
            <description>Test description</description>
            <pubDate>#{Time.current.rfc822}</pubDate>
          </item>
        </channel></rss>
      XML

      stub_request(:get, source_config['url']).to_return(
        status: 200,
        body: rss_with_spaces,
        headers: { 'Content-Type' => 'application/rss+xml' }
      )

      articles = service.send(:crawl_source, source_config)
      expect(articles.first[:title]).to eq("Title with spaces")
    end
  end
end

