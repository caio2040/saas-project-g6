require 'rails_helper'

RSpec.describe "Api::News", type: :request do
  describe 'GET /api/news' do
    context 'with no articles in database' do
      it 'returns empty articles array' do
        get '/api/news'
        
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        
        expect(json_response['articles']).to eq([])
        expect(json_response['has_more']).to eq(false)
        expect(json_response['current_page']).to eq(1)
        expect(json_response['total_count']).to eq(0)
      end
    end

    context 'with articles in database' do
      let!(:old_article) do
        create(:news_article,
          title: "Old Article",
          published_at: 2.days.ago,
          source: "CoinDesk"
        )
      end
      
      let!(:new_article) do
        create(:news_article,
          title: "New Article",
          published_at: 1.hour.ago,
          source: "CoinTelegraph"
        )
      end

      it 'returns articles in descending order by published_at' do
        get '/api/news'
        
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        articles = json_response['articles']
        
        expect(articles.length).to eq(2)
        expect(articles.first['title']).to eq("New Article")
        expect(articles.last['title']).to eq("Old Article")
      end

      it 'returns correct JSON structure' do
        get '/api/news'
        
        json_response = JSON.parse(response.body)
        
        expect(json_response).to have_key('articles')
        expect(json_response).to have_key('has_more')
        expect(json_response).to have_key('current_page')
        expect(json_response).to have_key('total_count')
        
        article = json_response['articles'].first
        expect(article).to have_key('id')
        expect(article).to have_key('title')
        expect(article).to have_key('subtitle')
        expect(article).to have_key('original_url')
        expect(article).to have_key('published_at')
        expect(article).to have_key('source')
      end

      it 'returns 5 articles per page (pagination)' do
        6.times do |i|
          create(:news_article, title: "Article #{i}", published_at: i.hours.ago)
        end
        
        get '/api/news'
        
        json_response = JSON.parse(response.body)
        expect(json_response['articles'].length).to eq(5)
        expect(json_response['has_more']).to eq(true)
        expect(json_response['total_count']).to eq(8)
      end

      it 'handles page parameter correctly' do
        6.times do |i|
          create(:news_article, title: "Article #{i}", published_at: i.hours.ago)
        end
        
        get '/api/news', params: { page: 2 }
        
        json_response = JSON.parse(response.body)
        expect(json_response['current_page']).to eq(2)
        expect(json_response['articles'].length).to be <= 5
      end

      it 'defaults to page 1 when page parameter is not provided' do
        get '/api/news'
        
        json_response = JSON.parse(response.body)
        expect(json_response['current_page']).to eq(1)
      end

      it 'returns has_more false when on last page' do
        NewsArticle.destroy_all
        
        5.times do |i|
          create(:news_article, title: "Article #{i}", published_at: i.hours.ago)
        end
        
        get '/api/news'
        
        json_response = JSON.parse(response.body)
        expect(json_response['articles'].length).to eq(5)
        expect(json_response['total_count']).to eq(5)
      end
      
      it 'returns has_more false when fewer articles than per_page' do
        NewsArticle.destroy_all
        
        3.times do |i|
          create(:news_article, title: "Article #{i}", published_at: i.hours.ago)
        end
        
        get '/api/news'
        
        json_response = JSON.parse(response.body)
        expect(json_response['articles'].length).to eq(3)
        expect(json_response['has_more']).to eq(false)
        expect(json_response['total_count']).to eq(3)
      end
    end
  end
end

