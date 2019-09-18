$(document).ready( function () {
    $("#header").load("/includes/header.html");
    highlightActiveNavItem();
  });

function highlightActiveNavItem() {
    var currentSection = window.location.pathname;
    if (currentSection == "" || currentSection == "/" || currentSection == "/index.html"){
        $('a[href="/"]').parent().addClass("current");
        return;
    }
    if (currentSection.startsWith("/about")) {
        $('a[href="/about/"]').parent().addClass("current");
        return;
    }
    if (currentSection.startsWith("/news")) {
        $('a[href="/news/"]').parent().addClass("current");
        return;
    }
    if (currentSection.startsWith("/links")) {
        $('a[href="/links/"]').parent().addClass("current");
        return;
    }
}