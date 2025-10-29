FactoryBot.define do
  factory :news_article do
    title { Faker::Lorem.sentence(word_count: 5) }
    subtitle { Faker::Lorem.paragraph(sentence_count: 2) }
    original_url { Faker::Internet.url }
    published_at { Faker::Time.backward(days: 30) }
    source { Faker::Company.name }
  end
end


