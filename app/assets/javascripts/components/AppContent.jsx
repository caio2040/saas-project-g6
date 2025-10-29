function AppContent() {
  return (
    <main
      style={{
        flex: 1,
        padding: "24px",
        backgroundColor: "#ecf0f1",
        overflow: "auto",
      }}
    >
      <NewsFeed />
    </main>
  );
}

window.AppContent = AppContent;
