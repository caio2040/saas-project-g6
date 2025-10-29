# Crypto News Aggregator

A real-time cryptocurrency news aggregator built with Rails and React that crawls RSS feeds from major crypto news sources.

## Team Members

- Yonseung Choi (yc3763)
- Charlie Mei (jm5912)

## Prerequisites

Before you begin, ensure you have the following installed:

- **Ruby** 3.4.7 (see `.ruby-version`)
- **SQLite3** (version 3.8.0 or higher)

## Getting Started

### 1. Install Ruby Dependencies

```bash
# Install bundler if not already installed
gem install bundler

# Install all gem dependencies
bundle install
```

### 2. Set Up the Database

```bash
# Create database, load schema, and run migrations
rails db:create db:migrate
```

### 3. Start the Server

```bash
# Start the Rails development server
rails server
```

The application will be available at `http://localhost:3000`
