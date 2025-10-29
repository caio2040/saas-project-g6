function AppFooter() {
  const currentYear = new Date().getFullYear();

  return (
    <footer
      style={{
        backgroundColor: "#2c3e50",
        color: "white",
        padding: "40px 24px 20px",
        borderTop: "1px solid #34495e",
      }}
    >
      <div style={{ maxWidth: "1200px", margin: "0 auto" }}>
        {/* Main Footer Content */}
        <div style={{ display: "flex", justifyContent: "space-between", marginBottom: "30px", flexWrap: "wrap" }}>
          {/* Company Info */}
          <div style={{ flex: "1", minWidth: "250px", marginBottom: "20px" }}>
            <h3 style={{ margin: "0 0 15px 0", fontSize: "18px", fontWeight: "bold" }}>CoinFeed</h3>
            <p style={{ margin: "0 0 10px 0", fontSize: "14px", lineHeight: "1.5", opacity: 0.9 }}>
              Real-time cryptocurrency news aggregation platform.
            </p>
            <p style={{ margin: "0", fontSize: "12px", opacity: 0.7 }}>
              116th St & Broadway, New York, NY 10027
              <br />
              Contact: support@coinfeed.com
            </p>
          </div>

          {/* Quick Links */}
          <div style={{ flex: "1", minWidth: "200px", marginBottom: "20px" }}>
            <h4 style={{ margin: "0 0 15px 0", fontSize: "16px", fontWeight: "bold" }}>Quick Links</h4>
            <div style={{ display: "flex", flexDirection: "column", gap: "8px" }}>
              <a href="#" style={{ color: "#ecf0f1", textDecoration: "none", fontSize: "14px", opacity: 0.8 }}>
                About
              </a>
              <a href="#" style={{ color: "#ecf0f1", textDecoration: "none", fontSize: "14px", opacity: 0.8 }}>
                API
              </a>
              <a href="#" style={{ color: "#ecf0f1", textDecoration: "none", fontSize: "14px", opacity: 0.8 }}>
                Support
              </a>
              <a href="#" style={{ color: "#ecf0f1", textDecoration: "none", fontSize: "14px", opacity: 0.8 }}>
                Contact
              </a>
            </div>
          </div>

          {/* Legal */}
          <div style={{ flex: "1", minWidth: "200px", marginBottom: "20px" }}>
            <h4 style={{ margin: "0 0 15px 0", fontSize: "16px", fontWeight: "bold" }}>Legal</h4>
            <div style={{ display: "flex", flexDirection: "column", gap: "8px" }}>
              <a href="#" style={{ color: "#ecf0f1", textDecoration: "none", fontSize: "14px", opacity: 0.8 }}>
                Privacy Policy
              </a>
              <a href="#" style={{ color: "#ecf0f1", textDecoration: "none", fontSize: "14px", opacity: 0.8 }}>
                Terms of Service
              </a>
              <a href="#" style={{ color: "#ecf0f1", textDecoration: "none", fontSize: "14px", opacity: 0.8 }}>
                Disclaimer
              </a>
            </div>
          </div>

          {/* Social & Status */}
          <div style={{ flex: "1", minWidth: "200px", marginBottom: "20px" }}>
            <h4 style={{ margin: "0 0 15px 0", fontSize: "16px", fontWeight: "bold" }}>Connect</h4>
            <div style={{ display: "flex", gap: "15px", marginBottom: "15px" }}>
              <a href="#" style={{ color: "#ecf0f1", fontSize: "16px", opacity: 0.8 }}>
                Twitter
              </a>
              <a href="#" style={{ color: "#ecf0f1", fontSize: "16px", opacity: 0.8 }}>
                LinkedIn
              </a>
              <a href="#" style={{ color: "#ecf0f1", fontSize: "16px", opacity: 0.8 }}>
                GitHub
              </a>
            </div>
            <div style={{ fontSize: "12px", opacity: 0.7 }}>
              <p style={{ margin: "0 0 5px 0" }}>System Status: Operational</p>
              <p style={{ margin: "0" }}>Last Updated: {new Date().toLocaleTimeString()}</p>
            </div>
          </div>
        </div>

        {/* Bottom Bar */}
        <div
          style={{
            borderTop: "1px solid #34495e",
            paddingTop: "20px",
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
            flexWrap: "wrap",
          }}
        >
          <p style={{ margin: 0, fontSize: "14px" }}>© {currentYear} CoinFeed. All rights reserved.</p>
          <div style={{ fontSize: "12px", opacity: 0.7 }}>
            <span>Built with React & Rails</span>
          </div>
        </div>
      </div>
    </footer>
  );
}

window.AppFooter = AppFooter;
