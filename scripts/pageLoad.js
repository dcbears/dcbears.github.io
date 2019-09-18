
var pageLinks = ["/", "/about/", "/news/", "/links/"];
var currentSection = window.location.pathname;
currentLink = ""
for(i=0; i< pageLinks.length; i++) {
    if(currentSection.startsWith(pageLinks[i])) {
        currentLink = pageLinks[i];
        break;
    }
}
$('a[href^="'+ currentLink +'"]').parent().addClass("current");