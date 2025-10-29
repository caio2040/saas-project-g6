Feature: View Cryptocurrency News Articles
  As a crypto news reader
  I want to view aggregated cryptocurrency news from multiple trusted sources
  So that users can quickly scan headlines and subtitles, then access full articles when needed
  
  Users want to quickly understand the overall trends and flow of the crypto market. They seek 
  to rapidly scan through multiple news articles to get a general sense of market developments 
  without diving deep into each article. This need makes short subtitles the preferred content 
  format - users specifically want brief, scannable summaries rather than long-form articles when 
  browsing. Short subtitles allow users to efficiently browse and grasp the market landscape, 
  then decide which articles to read in full when needed, addressing the pain point of being 
  overwhelmed by too much content at once.
  
  Traditional crypto news websites overwhelm users with too much information at once, making it 
  difficult to focus. News articles are scattered across different sections, creating a cluttered 
  and distracting reading experience. Our solution provides a calm, distraction-free interface 
  with soft colors and clean design to reduce information overload. Following the familiar feed 
  format of Threads and X (Twitter), we present news articles in a unified, vertical scrolling 
  feed that allows users to easily browse and scan content without visual clutter.

  Background:
    Given the database is empty
    And the system aggregates news from multiple RSS sources including CoinDesk, CoinTelegraph, Decrypt, and The Block
    And subtitles are automatically extracted from RSS feed content to provide users with a brief overview
    And the UI presents news in a calm, minimal design with soft colors to reduce visual clutter and information overload
    And articles are displayed in a Threads and X-inspired vertical feed format for easy browsing



  # 1
  Scenario: View empty news articles list
    When the user views the news feed
    Then the user should see an empty list
    And the feed should indicate no more articles are available

  # 2
  Scenario: View news articles from aggregated sources
    Given there are news articles from different sources in the database
    When the user views the news feed
    Then the user should see articles from multiple sources
    And each article should display its source name

  # 3
  Scenario: View news articles with short subtitles for quick scanning
    Given there are 5 news articles with subtitles in the database
    When the user views the news feed
    Then the user should see articles with short subtitles
    And the subtitles should provide a brief overview of each article that meets users' need for quick market scanning
    And the subtitles are extracted from RSS feed content to provide a brief overview

  # 4
  Scenario: Access full article content via original URL
    Given there is a news article with title "Bitcoin Price Surges" from CoinDesk
    When the user views the news feed
    Then the user should see an article with title "Bitcoin Price Surges"
    And the article should have an original URL pointing to the full article
    And the user should be able to access the complete article content through the original URL

  # 5
  Scenario: View news articles with pagination
    Given there are 7 news articles in the database
    When the user views the first page of the news feed
    Then the user should see 5 news articles
    And the feed should indicate more articles are available
    And the current page should be 1
    And the total count should be 7

    When the user views the second page of the news feed
    Then the user should see 2 news articles
    And the feed should indicate no more articles are available
    And the current page should be 2

  # 6
  Scenario: View news articles ordered by published date
    Given there are 3 news articles in the database with different publish dates
    When the user views the news feed
    Then the articles should be ordered by published date in descending order
    And the most recent articles should appear first

  # 7
  Scenario: View complete article details with all metadata
    Given there is a news article with title "Ethereum Update" from CoinTelegraph
    When the user views the news feed
    Then the user should see an article with title "Ethereum Update"
    And the article should have a subtitle for quick scanning
    And the article should have an original URL for full content access
    And the article should have a published date
    And the article should display its source name

  # 8
  Scenario: Prevent duplicate articles with same title
    Given there is a news article with title "Bitcoin News" from CoinDesk
    When the user views the news feed
    Then the user should see only one article with title "Bitcoin News"
    And duplicate articles should not be displayed

  # 9
  Scenario: Filter out media content like videos and podcasts
    Given there are 3 news articles in the database
    When the user views the news feed
    Then the feed should only display text-based news articles
    And video or podcast content should be filtered out

  # 10
  Scenario: Automatically fetch latest news when viewing first page
    Given the database is empty
    When the user views the first page of the news feed
    Then the system should automatically crawl latest news from RSS sources
    And new articles should be added to the database
