function NewsFeed() {
  const [articles, setArticles] = React.useState([]);
  const [loading, setLoading] = React.useState(true);
  const [loadingMore, setLoadingMore] = React.useState(false);
  const [error, setError] = React.useState(null);
  const [currentPage, setCurrentPage] = React.useState(1);
  const [hasMore, setHasMore] = React.useState(true);

  React.useEffect(() => {
    fetchNews(1, true); // Load first page
  }, []);

  const fetchNews = (page = 1, isInitial = false) => {
    if (isInitial) {
      setLoading(true);
    } else {
      setLoadingMore(true);
    }

    fetch(`/api/news?page=${page}`)
      .then((response) => {
        if (!response.ok) {
          throw new Error("Failed to fetch news");
        }
        return response.json();
      })
      .then((data) => {
        if (isInitial) {
          setArticles(data.articles || []);
        } else {
          setArticles((prev) => [...prev, ...(data.articles || [])]);
        }
        setCurrentPage(data.current_page);
        setHasMore(data.has_more);
      })
      .catch((err) => {
        setError(err.message);
        console.error("Error fetching news:", err);
      })
      .finally(() => {
        setLoading(false);
        setLoadingMore(false);
      });
  };

  const loadMore = () => {
    if (!loadingMore && hasMore) {
      fetchNews(currentPage + 1, false);
    }
  };

  const handleScroll = (e) => {
    const { scrollTop, scrollHeight, clientHeight } = e.target;
    // Load more when user scrolls to bottom
    if (scrollHeight - scrollTop <= clientHeight + 100) {
      loadMore();
    }
  };

  if (loading) {
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
        <h2 style={{ margin: "0 0 20px 0", color: "#333" }}>Live Feed</h2>
        <div style={{ textAlign: "center", padding: "40px" }}>
          <div style={{ fontSize: "16px", color: "#666" }}>Loading news...</div>
        </div>
      </div>
    );
  }

  if (error) {
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
        <h2 style={{ margin: "0 0 20px 0", color: "#333" }}>Live Feed</h2>
        <div style={{ textAlign: "center", padding: "40px" }}>
          <div style={{ fontSize: "16px", color: "#e74c3c" }}>Error: {error}</div>
          <button
            onClick={() => fetchNews(1, true)}
            style={{
              marginTop: "10px",
              padding: "8px 16px",
              backgroundColor: "#3498db",
              color: "white",
              border: "none",
              borderRadius: "4px",
              cursor: "pointer",
            }}
          >
            Retry
          </button>
        </div>
      </div>
    );
  }

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
      onScroll={handleScroll}
    >
      <h2 style={{ margin: "0 0 20px 0", color: "#333" }}>Live Feed</h2>
      <div style={{ paddingBottom: "20px" }}>
        {articles.length === 0 ? (
          <div style={{ textAlign: "center", padding: "40px" }}>
            <div style={{ fontSize: "16px", color: "#666" }}>No news articles found</div>
          </div>
        ) : (
          <React.Fragment>
            {articles.map((article) => (
              <NewsCard
                key={article.id}
                title={article.title}
                subtitle={article.subtitle}
                original_url={article.original_url}
                published_at={article.published_at}
              />
            ))}
            {loadingMore && (
              <div style={{ textAlign: "center", padding: "20px" }}>
                <div style={{ fontSize: "14px", color: "#666" }}>Loading more...</div>
              </div>
            )}
            {!hasMore && articles.length > 0 && (
              <div style={{ textAlign: "center", padding: "20px" }}>
                <div style={{ fontSize: "14px", color: "#999" }}>No more feed</div>
              </div>
            )}
          </React.Fragment>
        )}
      </div>
    </div>
  );
}

window.NewsFeed = NewsFeed;
