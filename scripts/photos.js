function switchPhoto(url, width, height, title, imagePosition) {
    var imgId = "#largeImage";
    var videoId = "#largeVideo";
    var titleId = "#mainImageTitle";
    var backLinkId = "#backLink";
    var nextLinkId = "#nextLink";
    var loading = "#loadingImage";
    var maxHeight = 500;
    var maxWidth = 600;
    var imageNumber = Number(imagePosition.substring(0, imagePosition.indexOf("of")));
    var imageTotal = Number(imagePosition.substring(imagePosition.indexOf("of") + 2));
    //show loading image and hide image/video while loading
    $(imgId).hide();
    $(videoId).hide();
    $(loading).show();
    //alert(imagePosition);
    //it's a video
    if (url.toLowerCase().indexOf('youtube') != -1) {
        var videoNum = Number(url.substring(5));
        $('#movieUrl').attr("value", url);
        $('#srcUrl').attr("src", url);
        $(loading).hide();
        $(videoId).show();
        $(videoId).focus();
        $(".selected").removeClass("selected");
        $("#thumbLink" + imageNumber).parent().addClass("selected");
    }
    //the default is an image
    else { 
    $(imgId).attr("src", url); //set to new image
        //calculate width and height of image
        var newHeight = height;
        var newWidth = width;
        /*if (height <= width && width > maxWidth) {//vertical or square and too big
            var ratio = maxWidth / width;
            newHeight = height * ratio;
            newWidth = maxWidth;
        }*/
        if (width > maxWidth || height > maxHeight) {//horizontal and too big
            var ratio = maxHeight / height;
            newWidth = width * ratio;
            newHeight = maxHeight;
        }
        //show actual image
        $(imgId).attr("height", newHeight); //set height attribute on image
        $(imgId).attr("width", newWidth); //set weight attribut on image
        $(loading).hide();
        $(imgId).show();

        $(imgId).focus(); //focus on the main image to ensure the arrow keys work without having to click the page
        $(".selected").removeClass("selected");
        $("#thumb" + imageNumber).addClass("selected");
    }
    
    
    //change the forward and back links
    if (imageNumber == 1) {
        $(backLinkId).attr("href", "");
        $(backLinkId).attr("onclick", "return false;");
        $(backLinkId).addClass("disabled");     
    }
    else {
        //alert(imageNumber);
        $(backLinkId).removeClass("disabled");     
        $(backLinkId).attr("href", "?defaultImage=" + url);
        $(backLinkId).attr("onClick", "$('#thumbLink" + (imageNumber - 1) + "').click(); return false;");
    }
    if (imageNumber == imageTotal) {
        $(nextLinkId).attr("href", "");
        $(nextLinkId).attr("onClick", "return false;");
        $(nextLinkId).addClass("disabled");     
    }
    else{
        $(nextLinkId).removeClass("disabled");     
        $(nextLinkId).attr("href", "?defaultImage=" + url);
        $(nextLinkId).attr("onClick", "$('#thumbLink" + (imageNumber + 1) + "').click(); return false;");
    }
    title = title.replace(/\|\|/gi, "\"").replace(/\|/gi, "'"); //replace "||" with a double quotes, then replace "|" with single quote
    $(titleId).text(title); //set title text for main image
    //change thumbnail outline
    return;
}
function clickLink(keyCode) {//back or next
    switch (keyCode) {
        case 37:
            $("#backLink").click();
            break;
        case 39:
            $("#nextLink").click();
            break;
        default:
            break;
    }
    return;
}