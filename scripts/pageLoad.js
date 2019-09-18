
var pageLinks = ["/", "/about/", "/news/", "/links/"];
var currentSection = window.location.pathname;
alert(currentSection);
var headerStr = "";
var currentPageMenuItem = $('a[href^="'+currentSection +'"]').parent();
alert(currentPageMenuItem);
var currentClass = currentPageMenuItem.attr("class");
currentClass += " current";
alert(currentClass);
$(currentPageMenuItem).attr("class", currentClass)
