$(document).ready( function () {
    $("#header").load("/includes/header.html");
    highlightActiveNavItem();
  });

function highlightActiveNavItem() {
    var pageLinks = ["about", "news", "links"];
    var currentSection = window.location.pathname;
    currentLink = ""
    if (currentSection == "" || currentSection == "/" || currentSection == "/index.html"){
        $('a[href="/"]').parent().addClass("current");
        return;
    }
    for(i=0; i< pageLinks.length; i++){
        if (currentSection.startsWith(pageLinks[i])) {
            $('a[href="/'+pageLinks[i]+'/"]').parent().addClass("current");
            return;
        }
    }
}