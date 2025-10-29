# Crypto News Aggregator

A real-time cryptocurrency news aggregator built with Rails and React that crawls RSS feeds from major crypto news sources.

## Team Members

- Yonseung Choi (yc3763)
- Charlie Mei (jm5912)

## Requirements

Before you begin, ensure you have the following installed:

- **Ruby** 3.4.7 (see `.ruby-version`)
- **SQLite3** (version 3.8.0 or higher)

## Getting Started

### 1. Install Ruby Dependencies

```bash
gem install bundler
bundle install
```

### 2. Set Up the Database

```bash
rails db:create db:migrate
```

### 3. Start the Server

```bash
rails server
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
