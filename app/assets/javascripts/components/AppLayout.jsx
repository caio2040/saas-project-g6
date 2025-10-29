function AppLayout() {
  const [sidebarCollapsed, setSidebarCollapsed] = React.useState(true);

  const toggleSidebar = () => {
    setSidebarCollapsed(!sidebarCollapsed);
  };

  return (
    <div style={{ display: "flex", flexDirection: "column", minHeight: "100vh" }}>
      <AppHeader onToggleSidebar={toggleSidebar} />
      <div style={{ display: "flex", flex: 1 }}>
        <AppSidebar collapsed={sidebarCollapsed} />
        <AppContent />
      </div>
      <AppFooter />
    </div>
  );
}

window.AppLayout = AppLayout;
