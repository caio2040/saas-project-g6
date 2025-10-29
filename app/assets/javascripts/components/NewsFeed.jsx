function NewsFeed() {
  const newsData = [
    {
      id: 1,
      title: "Bitcoin Reaches New All-Time High",
      description:
        "Bitcoin has reached a new all-time high of $100,000, marking a significant milestone in cryptocurrency history.",
      publishedAt: "2 hours ago",
    },
    {
      id: 2,
      title: "Ethereum 2.0 Upgrade Complete",
      description:
        "The long-awaited Ethereum 2.0 upgrade has been successfully completed, bringing improved scalability and energy efficiency.",
      publishedAt: "5 hours ago",
    },
    {
      id: 3,
      title: "Major Bank Adopts Blockchain Technology",
      description:
        "A leading global bank has announced its adoption of blockchain technology for cross-border payments, reducing transaction times significantly.",
      publishedAt: "1 day ago",
    },
    {
      id: 4,
      title: "Solana Network Experiences Rapid Growth",
      description:
        "Solana's ecosystem has seen explosive growth with over 100 new projects launching this month, solidifying its position as a major blockchain platform.",
      publishedAt: "3 hours ago",
    },
    {
      id: 5,
      title: "DeFi Total Value Locked Surpasses $200B",
      description:
        "The decentralized finance sector has reached a new milestone with TVL exceeding $200 billion, driven by innovative yield farming protocols.",
      publishedAt: "6 hours ago",
    },
    {
      id: 6,
      title: "NFT Market Shows Signs of Recovery",
      description:
        "After months of decline, the NFT market is showing strong recovery signals with trading volume increasing by 40% this week.",
      publishedAt: "8 hours ago",
    },
    {
      id: 7,
      title: "Central Bank Digital Currency Pilot Expands",
      description:
        "Several countries have announced expansion of their CBDC pilot programs, with China leading the way in digital currency innovation.",
      publishedAt: "12 hours ago",
    },
    {
      id: 8,
      title: "Layer 2 Solutions Gain Mainstream Adoption",
      description:
        "Major corporations are increasingly adopting Layer 2 scaling solutions to reduce transaction costs and improve blockchain efficiency.",
      publishedAt: "1 day ago",
    },
    {
      id: 9,
      title: "Crypto Regulation Framework Announced",
      description:
        "The European Union has unveiled a comprehensive regulatory framework for cryptocurrencies, providing clarity for businesses and investors.",
      publishedAt: "1 day ago",
    },
    {
      id: 10,
      title: "Web3 Gaming Platform Raises $50M",
      description:
        "A leading Web3 gaming platform has secured $50 million in Series A funding, signaling strong investor confidence in blockchain gaming.",
      publishedAt: "2 days ago",
    },
    {
      id: 11,
      title: "Cross-Chain Bridge Technology Breakthrough",
      description:
        "New cross-chain bridge technology promises to eliminate security vulnerabilities while maintaining fast transaction speeds across blockchains.",
      publishedAt: "2 days ago",
    },
    {
      id: 12,
      title: "Mining Difficulty Adjustment Optimizes Network",
      description:
        "Bitcoin's mining difficulty adjustment has optimized network performance, reducing energy consumption while maintaining security standards.",
      publishedAt: "3 days ago",
    },
    {
      id: 13,
      title: "Stablecoin Market Cap Reaches $150B",
      description:
        "The stablecoin market has reached $150 billion in market capitalization, providing essential liquidity for the broader crypto ecosystem.",
      publishedAt: "3 days ago",
    },
    {
      id: 14,
      title: "Smart Contract Security Audit Standards",
      description:
        "Industry leaders have established new security audit standards for smart contracts, aiming to reduce vulnerabilities and protect users.",
      publishedAt: "4 days ago",
    },
    {
      id: 15,
      title: "Crypto Payment Integration Expands",
      description:
        "Major e-commerce platforms are expanding crypto payment options, making digital currencies more accessible for everyday transactions.",
      publishedAt: "4 days ago",
    },
    {
      id: 16,
      title: "Decentralized Storage Network Growth",
      description:
        "Decentralized storage networks have seen 300% growth in usage this quarter, offering alternatives to traditional cloud storage.",
      publishedAt: "5 days ago",
    },
    {
      id: 17,
      title: "Yield Farming Strategies Evolve",
      description:
        "Advanced yield farming strategies are emerging, offering higher returns while managing risk through sophisticated DeFi protocols.",
      publishedAt: "5 days ago",
    },
    {
      id: 18,
      title: "Blockchain Interoperability Solutions",
      description:
        "New interoperability solutions are enabling seamless communication between different blockchain networks, breaking down silos.",
      publishedAt: "6 days ago",
    },
  ];

  return (
    <div
      className="news-feed"
      style={{
        padding: "20px",
        backgroundColor: "#f5f5f5",
        borderRadius: "8px",
        margin: "20px auto",
        maxWidth: "50%",
        minWidth: "400px",
        maxHeight: "80vh",
        overflowY: "auto",
        border: "1px solid #e0e0e0",
        boxShadow: "0 4px 6px rgba(0, 0, 0, 0.1)",
        scrollbarWidth: "none",
        msOverflowStyle: "none",
      }}
    >
      <h2
        style={{
          margin: "0 0 20px 0",
          color: "#333",
        }}
      >
        Live Feed
      </h2>
      <div style={{ paddingBottom: "20px" }}>
        {newsData.map((news) => (
          <NewsCard key={news.id} title={news.title} description={news.description} publishedAt={news.publishedAt} />
        ))}
      </div>
    </div>
  );
}

window.NewsFeed = NewsFeed;
