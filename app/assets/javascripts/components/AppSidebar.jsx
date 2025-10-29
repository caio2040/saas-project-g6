function AppSidebar({ collapsed }) {
  const menuItems = [
    { id: 1, name: "News Feed", icon: "fas fa-newspaper" },
    { id: 2, name: "Market Data", icon: "fas fa-chart-line" },
    { id: 3, name: "Portfolio", icon: "fas fa-wallet" },
    { id: 4, name: "Alerts", icon: "fas fa-bell" },
    { id: 5, name: "Settings", icon: "fas fa-cog" },
  ];

  const handleMenuClick = (item) => {
    alert(`Selected: ${item.name}`);
  };

  return (
    <aside
      style={{
        width: collapsed ? "60px" : "250px",
        backgroundColor: "#34495e",
        color: "white",
        padding: "20px 0",
        minHeight: "calc(100vh - 80px)",
        transition: "width 0.3s ease",
        overflow: "hidden",
      }}
    >
      <nav>
        <ul style={{ listStyle: "none", padding: 0, margin: 0 }}>
          {menuItems.map((item) => (
            <li key={item.id}>
              <button
                onClick={() => handleMenuClick(item)}
                style={{
                  width: "100%",
                  padding: collapsed ? "12px" : "12px 24px",
                  backgroundColor: "transparent",
                  color: "white",
                  border: "none",
                  textAlign: collapsed ? "center" : "left",
                  cursor: "pointer",
                  fontSize: "16px",
                  transition: "background-color 0.2s",
                  display: "flex",
                  alignItems: "center",
                  gap: collapsed ? "0" : "12px",
                  justifyContent: collapsed ? "center" : "flex-start",
                }}
                onMouseOver={(e) => (e.target.style.backgroundColor = "#2c3e50")}
                onMouseOut={(e) => (e.target.style.backgroundColor = "transparent")}
                title={collapsed ? item.name : ""}
              >
                <i className={item.icon} style={{ fontSize: "20px", width: "20px" }}></i>
                {!collapsed && <span>{item.name}</span>}
              </button>
            </li>
          ))}
        </ul>
      </nav>
    </aside>
  );
}

window.AppSidebar = AppSidebar;
