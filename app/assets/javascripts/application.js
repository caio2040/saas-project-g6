//= require react
//= require react_ujs
//= require components

import React from "react";
import ReactDOM from "react-dom";
import Babel from "@babel/standalone";

window.React = React;
window.ReactDOM = ReactDOM;
window.Babel = Babel;

document.addEventListener("DOMContentLoaded", function () {
  Promise.all([
    fetch("/assets/components/AppLayout.jsx").then((response) => response.text()),
    fetch("/assets/components/AppHeader.jsx").then((response) => response.text()),
    fetch("/assets/components/AppSidebar.jsx").then((response) => response.text()),
    fetch("/assets/components/AppContent.jsx").then((response) => response.text()),
    fetch("/assets/components/AppFooter.jsx").then((response) => response.text()),
    fetch("/assets/components/NewsCard.jsx").then((response) => response.text()),
    fetch("/assets/components/NewsFeed.jsx").then((response) => response.text()),
  ])
    .then(
      ([appLayoutCode, appHeaderCode, appSidebarCode, appContentCode, appFooterCode, newsCardCode, newsFeedCode]) => {
        const compiledAppLayout = Babel.transform(appLayoutCode, { presets: ["react"] }).code;
        const compiledAppHeader = Babel.transform(appHeaderCode, { presets: ["react"] }).code;
        const compiledAppSidebar = Babel.transform(appSidebarCode, { presets: ["react"] }).code;
        const compiledAppContent = Babel.transform(appContentCode, { presets: ["react"] }).code;
        const compiledAppFooter = Babel.transform(appFooterCode, { presets: ["react"] }).code;
        const compiledNewsCard = Babel.transform(newsCardCode, { presets: ["react"] }).code;
        const compiledNewsFeed = Babel.transform(newsFeedCode, { presets: ["react"] }).code;

        eval(compiledAppLayout);
        eval(compiledAppHeader);
        eval(compiledAppSidebar);
        eval(compiledAppContent);
        eval(compiledAppFooter);
        eval(compiledNewsCard);
        eval(compiledNewsFeed);

        if (window.AppLayout) {
          ReactDOM.render(React.createElement(window.AppLayout), document.getElementById("react-root"));
        }
      }
    )
    .catch((error) => {
      console.error("Error loading JSX files:", error);
    });
});
