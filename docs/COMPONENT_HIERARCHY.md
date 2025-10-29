# Component Hierarchy

```
AppLayout (Root Container)
├── AppHeader (Navigation Header)
│   └── Toggle Button for Sidebar
├── Main Content Area (Flex Container)
│   ├── AppSidebar (Collapsible Navigation)
│   │   └── Menu Items with Font Awesome Icons
│   │       ├── News Feed
│   │       ├── Market Data
│   │       ├── Portfolio
│   │       ├── Alerts
│   │       └── Settings
│   └── AppContent (Main Content Wrapper)
│       └── NewsFeed
│           └── NewsCard[]
│               ├── Title
│               ├── Description
│               └── Published Time
└── AppFooter (Copyright Footer)
```
