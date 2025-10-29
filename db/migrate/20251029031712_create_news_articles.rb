class CreateNewsArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :news_articles do |t|
      t.string :title
      t.text :subtitle
      t.string :original_url
      t.datetime :published_at
      t.string :source

      t.timestamps
      
      t.index ["title"], name: "index_news_articles_on_title", unique: true
    end
  end
end
