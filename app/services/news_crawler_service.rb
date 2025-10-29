class NewsCrawlerService
  include HTTParty
  
  def initialize
    @rss_sources = load_rss_sources
  end

  def crawl_all_sources
    return [] if Rails.env.test?
    
    all_articles = []
    
    @rss_sources.each do |source|
      begin
        articles = crawl_source(source)
        all_articles.concat(articles)
      rescue => e
        Rails.logger.error "Failed to crawl #{source['name']}: #{e.message}"
      end
    end
    
    save_articles(all_articles)
    all_articles
  end

  private

  def load_rss_sources
    rss_config = YAML.load_file(Rails.root.join('config', 'rss_sources.yml'))
    rss_config['sources'] || []
  end

  def crawl_source(source)
    Rails.logger.info "Crawling #{source['name']}..."
    
    response = HTTParty.get(source['url'], timeout: 30)
    feed = Feedjira.parse(response.body)
    
    articles = []
    feed.entries.each do |entry|
      article = {
        title: entry.title&.strip,
        subtitle: extract_subtitle(entry),
        original_url: entry.url,
        published_at: parse_published_time(entry),
        source: source['name']
      }
      
      articles << article if valid_article?(article)
    end
    
    Rails.logger.info "Found #{articles.count} articles from #{source['name']}"
    articles
  end

  def parse_published_time(entry)
    # Try different time fields and parse them properly
    time_fields = [entry.published, entry.updated, entry.last_modified]
    
    time_fields.each do |time_field|
      next unless time_field
      
      begin
        # Parse the time string
        parsed_time = Time.parse(time_field.to_s)
        return parsed_time if parsed_time
      rescue => e
        Rails.logger.debug "Failed to parse time '#{time_field}': #{e.message}"
      end
    end
    
    # Fallback to current time if no valid time found
    Time.current
  end

  def extract_subtitle(entry)
    # Try different fields for subtitle/description
    content = entry.summary || entry.content || (entry.respond_to?(:description) ? entry.description : nil) || ""
    
    # Remove HTML tags and clean up the text
    content = strip_html_tags(content)
    content = clean_text(content)
    
    content
  end

  def strip_html_tags(html)
    # Remove HTML tags
    html.gsub(/<[^>]*>/, '')
  end

  def clean_text(text)
    # Clean up extra whitespace and special characters
    text.gsub(/\s+/, ' ')
        .gsub(/&nbsp;/, ' ')
        .gsub(/&amp;/, '&')
        .gsub(/&lt;/, '<')
        .gsub(/&gt;/, '>')
        .gsub(/&quot;/, '"')
        .strip
  end

  def valid_article?(article)
    return false unless article[:title].present? && 
                       article[:original_url].present? && 
                       article[:published_at].present?
    
    # Filter out video/audio content
    return false if contains_media_content?(article)
    
    true
  end

  def contains_media_content?(article)
    title = article[:title].downcase
    subtitle = article[:subtitle]&.downcase || ""
    url = article[:original_url].downcase
    
    # More specific keywords that clearly indicate video/audio content
    media_keywords = [
      'interview', 'podcast', 'webinar', 'livestream', 'live stream',
      'youtube.com', 'vimeo.com', 'spotify.com', 'soundcloud.com', 
      'twitch.tv', 'watch', 'listen', 'tune in', 'broadcast',
      'episode', 'season', 'series', 'show', 'talk show',
      'panel discussion', 'conference', 'summit', 'event', 'meetup',
      'video:', 'audio:', 'podcast:', 'interview:', 'webinar:'
    ]
    
    # Check title, subtitle, and URL for media keywords
    content_to_check = "#{title} #{subtitle} #{url}"
    
    # Only filter if it's clearly media content
    media_keywords.any? { |keyword| content_to_check.include?(keyword) }
  end

  def save_articles(articles)
    articles.each do |article_data|
      # Check if article already exists by title (more reliable than URL)
      existing_article = NewsArticle.find_by(
        title: article_data[:title]
      )
      
      next if existing_article
      
      NewsArticle.create!(
        title: article_data[:title],
        subtitle: article_data[:subtitle],
        original_url: article_data[:original_url],
        published_at: article_data[:published_at],
        source: article_data[:source]
      )
    end
    
    Rails.logger.info "Saved #{articles.count} new articles"
  end
end
