class Api::NewsController < ApplicationController
  def index
    # Get page parameter (default to 1)
    page = params[:page]&.to_i || 1
    per_page = 5  
    
    # Crawl latest news (only on first page to avoid too much crawling)
    if page == 1
      crawler = NewsCrawlerService.new
      crawler.crawl_all_sources
    end
    
    # Return paginated articles
    articles = NewsArticle.order(published_at: :desc)
                         .limit(per_page)
                         .offset((page - 1) * per_page)
    
    render json: {
      articles: articles.map do |article|
        {
          id: article.id,
          title: article.title,
          subtitle: article.subtitle,
          original_url: article.original_url,
          published_at: article.published_at,
          source: article.source
        }
      end,
      has_more: articles.count == per_page,
      current_page: page,
      total_count: NewsArticle.count
    }
  end
end
