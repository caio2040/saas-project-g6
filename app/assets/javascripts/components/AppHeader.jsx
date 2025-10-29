function AppHeader({ onToggleSidebar }) {
  return (
    <header
      style={{
        backgroundColor: "#2c3e50",
        color: "white",
        padding: "16px 24px",
        display: "flex",
        justifyContent: "space-between",
        alignItems: "center",
        boxShadow: "0 2px 4px rgba(0,0,0,0.1)",
      }}
    >
      <div style={{ display: "flex", alignItems: "center", gap: "16px" }}>
        <button
          onClick={onToggleSidebar}
          style={{
            padding: "8px",
            backgroundColor: "transparent",
            color: "white",
            border: "1px solid white",
            borderRadius: "4px",
            cursor: "pointer",
            fontSize: "16px",
          }}
        >
          ☰
        </button>
        <h1 style={{ margin: 0, fontSize: "24px", fontWeight: "bold" }}>CoinFeed</h1>
      </div>
      <div style={{ display: "flex", alignItems: "center", gap: "16px" }}>
        <button
          style={{
            padding: "8px 16px",
            backgroundColor: "#3498db",
            color: "white",
            border: "none",
            borderRadius: "4px",
            cursor: "pointer",
          }}
        >
          Login
        </button>
      </div>
    </header>
  );
}

window.AppHeader = AppHeader;
