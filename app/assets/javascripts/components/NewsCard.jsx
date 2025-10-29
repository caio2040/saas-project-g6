function NewsCard({ title, subtitle, original_url, published_at }) {
  const handleReadMoreClick = (e) => {
    e.stopPropagation(); // Prevent card click event
    if (original_url) {
      window.open(original_url, "_blank");
    }
  };

  const formatPublishedAt = (publishedAt) => {
    if (!publishedAt) return "";

    const date = new Date(publishedAt);
    const now = new Date();

    if (isNaN(date.getTime())) return "";

    const diffInMinutes = Math.floor((now - date) / (1000 * 60));
    const diffInHours = Math.floor((now - date) / (1000 * 60 * 60));
    const diffInDays = Math.floor((now - date) / (1000 * 60 * 60 * 24));

    if (diffInMinutes < 1) return "Just now";
    if (diffInMinutes < 60) return `${diffInMinutes} minutes ago`;
    if (diffInHours < 24) return `${diffInHours} hours ago`;
    if (diffInDays < 7) return `${diffInDays} days ago`;

    return date.toLocaleDateString();
  };

  return (
    <div
      style={{
        backgroundColor: "white",
        padding: "15px",
        borderRadius: "8px",
        marginBottom: "15px",
        boxShadow: "0 2px 4px rgba(0,0,0,0.05)",
        border: "1px solid #eee",
      }}
    >
      <h3 style={{ margin: "0 0 8px 0", fontSize: "18px", color: "#2c3e50" }}>{title}</h3>
      <p style={{ margin: "0 0 10px 0", fontSize: "14px", color: "#555" }}>{subtitle}</p>
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
        <span style={{ fontSize: "12px", color: "#777" }}>{formatPublishedAt(published_at)}</span>
        {original_url && (
          <span
            onClick={handleReadMoreClick}
            style={{
              fontSize: "12px",
              color: "#3498db",
              cursor: "pointer",
              textDecoration: "underline",
            }}
            onMouseOver={(e) => {
              e.target.style.color = "#2980b9";
            }}
            onMouseOut={(e) => {
              e.target.style.color = "#3498db";
            }}
          >
            Read more →
          </span>
        )}
      </div>
    </div>
  );
}

window.NewsCard = NewsCard;
