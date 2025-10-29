# Crypto News Aggregator

A real-time cryptocurrency news aggregator built with Rails and React that crawls RSS feeds from major crypto news sources.

## Team Members

- Yonseung Choi (yc3763)
- Charlie Mei (jm5912)

## Requirements

Before you begin, ensure you have the following installed:

- **Ruby** 3.4.7 (see `.ruby-version`)
- **SQLite3** (version 3.8.0 or higher)

## Getting Started (Locally)

### 1. Install Ruby Dependencies

```bash
gem install bundler
bundle install
```

### 2. Set Up the Database

```bash
rails db:create 
rails db:migrate
```

### 3. Start the Server

```bash
bin/rails server
```

The application will be available at `http://localhost:3000`

## Testing

This project uses RSpec and Cucumber for testing.

### Running Tests

```bash
# Run all tests
bundle exec rspec
bundle exec cucumber

```

### Test Locations and Coverage

- RSpec tests:
  - Location: `spec/`
    - Models: `spec/models/` (e.g., `spec/models/news_article_spec.rb`)
    - Requests (API): `spec/requests/api/` (e.g., `spec/requests/api/news_spec.rb`)
    - Services: `spec/services/` (e.g., `spec/services/news_crawler_service_spec.rb`)
    - Factories: `spec/factories/` (e.g., `spec/factories/news_articles.rb`)
  - Covers: model validations and behavior, API responses/pagination/ordering, and RSS crawling service behavior (with WebMock).

- Cucumber features (user stories):
  - Location: `features/`
    - Feature files: `features/news_articles.feature`
    - Step definitions: `features/step_definitions/news_article_steps.rb`
    - Support files: `features/support/`
  - Covers: viewing an empty feed, aggregated sources, short subtitles for quick scanning, accessing original article URLs, pagination and counts, ordering by published date, presence of article metadata (subtitle/source/published_at/original_url), deduplication of duplicate titles, filtering out media (video/podcast), and auto-fetch behavior on first page.

### Test Results (Expected Output)

After running the full suites, you should see all tests passing (green):

```bash
bundle exec rspec    # All examples pass
WARNING: Cucumber-rails has been required outside of env.rb. The rest of loading is being deferred until env.rb is called.

To avoid this warning, move `gem 'cucumber-rails', require: false` under `group :test` in your Gemfile.
If it is already in the `:test` group, be sure you are specifying 'require: false'.
.........................................................

Finished in 0.32138 seconds (files took 0.99117 seconds to load)
57 examples, 0 failures

Coverage report generated for RSpec to /Users/charliemei/Desktop/saas-project-g6/coverage.
Line Coverage: 85.11% (80 / 94)
bundle exec cucumber # All scenarios pass, 0 failures
...
# 10
  Scenario: Automatically fetch latest news when viewing first page         # features/news_articles.feature:105
    Given the database is empty                                             # features/step_definitions/news_article_steps.rb:1
    When the user views the first page of the news feed                     # features/step_definitions/news_article_steps.rb:104
    Then the system should automatically crawl latest news from RSS sources # features/step_definitions/news_article_steps.rb:378
    And new articles should be added to the database                        # features/step_definitions/news_article_steps.rb:384

10 scenarios (10 passed)
100 steps (100 passed)
0m0.148s
┌──────────────────────────────────────────────────────────────────────────────┐
│ Share your Cucumber Report with your team at https://reports.cucumber.io     │
│                                                                              │
│ Command line option:    --publish                                            │
│ Environment variable:   CUCUMBER_PUBLISH_ENABLED=true                        │
│ cucumber.yml:           default: --publish                                   │
│                                                                              │
│ More information at https://cucumber.io/docs/cucumber/environment-variables/ │
│                                                                              │
│ To disable this message, specify CUCUMBER_PUBLISH_QUIET=true or use the      │
│ --publish-quiet option. You can also add this to your cucumber.yml:          │
│ default: --publish-quiet                                                     │
└──────────────────────────────────────────────────────────────────────────────┘
```


Notes:
- RSpec output should end with lines similar to:
  - `57 examples, 0 failures`
  - `Line Coverage: 85.11% (80 / 94)`
- Cucumber output should end with lines similar to:
  - `10 scenarios (100 passed)`

## Deployment (Heroku)

This app is configured for Heroku (PostgreSQL in production).
Heroku Link (so you don't have to build the app yourself): 

1. Ensure you have the Heroku CLI and are logged in:
   ```bash
   heroku login -i
   ```

2. Create the app and add Postgres:
   ```bash
   heroku create
   
   ```

3. Deploy:
   ```bash
   git push heroku main
   ```

4. Run database setup and open the app:
   ```bash
   heroku run rails db:migrate
   heroku run rails db:seed
   heroku open
   ```

Notes:
- Production uses PostgreSQL (`pg` gem) and `DATABASE_URL`; development/test use SQLite.
- The `Procfile` runs Puma via `config/puma.rb`.
