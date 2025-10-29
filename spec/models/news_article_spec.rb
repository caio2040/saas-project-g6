require 'rails_helper'

RSpec.describe NewsArticle, type: :model do
  describe 'creation' do
    it 'can be created with valid attributes' do
      article = create(:news_article)
      expect(article).to be_persisted
      expect(article.id).not_to be_nil
    end

    it 'sets all attributes correctly' do
      article = create(:news_article, 
        title: "Test Title",
        subtitle: "Test Subtitle",
        original_url: "https://example.com/news",
        source: "Test Source"
      )
      
      expect(article.title).to eq("Test Title")
      expect(article.subtitle).to eq("Test Subtitle")
      expect(article.original_url).to eq("https://example.com/news")
      expect(article.source).to eq("Test Source")
    end
  end

  describe 'unique constraint on title' do
    it 'prevents duplicate titles at database level' do
      create(:news_article, title: "Unique Title")
      
      duplicate = build(:news_article, title: "Unique Title")
      expect { duplicate.save! }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it 'allows different titles' do
      create(:news_article, title: "First Title")
      
      second = create(:news_article, title: "Second Title")
      expect(second).to be_persisted
      expect(NewsArticle.count).to eq(2)
    end
  end

  describe 'timestamps' do
    it 'automatically sets created_at and updated_at' do
      article = create(:news_article)
      
      expect(article.created_at).not_to be_nil
      expect(article.updated_at).not_to be_nil
    end

    it 'updates updated_at when article is modified' do
      article = create(:news_article)
      original_updated_at = article.updated_at
      
      sleep(0.1)
      article.update(subtitle: "Updated subtitle")
      
      expect(article.updated_at).to be > original_updated_at
    end
  end

  describe 'query methods' do
    it 'can find articles by title' do
      article = create(:news_article, title: "Find Me")
      
      found = NewsArticle.find_by(title: "Find Me")
      expect(found).to eq(article)
    end

    it 'can order articles by published_at' do
      old_article = create(:news_article, published_at: 1.day.ago)
      new_article = create(:news_article, published_at: Time.current)
      
      ordered = NewsArticle.order(published_at: :desc)
      expect(ordered.first).to eq(new_article)
      expect(ordered.last).to eq(old_article)
    end
  end
end

