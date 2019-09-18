
var pageLinks = ["/", "/about/", "/news/", "/links/"];
var currentSection = window.location.pathname;
alert(currentSection);
var headerStr = "";
var currentPageMenuItem = $('a[href^="'+currentSection +'"]').parent();
alert(currentPageMenuItem.parent().attr("id"));
currentPageMenuItem.addClass("current")
