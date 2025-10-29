# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w[ admin.js admin.css ]

# Explicitly register JSX files as assets so they can be fetched via asset_path in production
Rails.application.config.assets.precompile += %w[
  application.js
  components/AppLayout.jsx
  components/AppHeader.jsx
  components/AppSidebar.jsx
  components/AppContent.jsx
  components/AppFooter.jsx
  components/NewsCard.jsx
  components/NewsFeed.jsx
]
