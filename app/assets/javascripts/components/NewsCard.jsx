function NewsCard({ title, description, publishedAt }) {
  const handleReadMore = () => {
    alert(`Reading: ${title}`);
  };

  return (
    <div
      style={{
        border: "1px solid #ddd",
        borderRadius: "8px",
        padding: "16px",
        margin: "12px 0",
        backgroundColor: "white",
        boxShadow: "0 2px 4px rgba(0,0,0,0.1)",
      }}
    >
      <h3 style={{ margin: "0 0 8px 0", color: "#333" }}>{title}</h3>
      <p style={{ margin: "0 0 12px 0", color: "#666", lineHeight: "1.4" }}>{description}</p>
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
        <span style={{ fontSize: "12px", color: "#999" }}>{publishedAt}</span>
        <button
          onClick={handleReadMore}
          style={{
            padding: "6px 12px",
            backgroundColor: "#28a745",
            color: "white",
            border: "none",
            borderRadius: "4px",
            cursor: "pointer",
            fontSize: "12px",
          }}
        >
          Read More
        </button>
      </div>
    </div>
  );
}

window.NewsCard = NewsCard;

