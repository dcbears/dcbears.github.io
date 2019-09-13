<%
    // Load the XML 
    var xsl = new ActiveXObject("Msxml2.xsltemplate.3.0");
    var xsldoc = new ActiveXObject("Msxml2.FreeThreadedDOMDocument.3.0");
    var xslproc;
    xsldoc.async = false;
    xsldoc.load(Server.MapPath("/_includes/schedule.xslt"));
    if (xsldoc.parseError.errorCode != 0) {
        var myErr = xsldoc.parseError;
        WScript.Echo("You have error " + myErr.reason);
    }
    else {
        xsl.stylesheet = xsldoc;
        var xmldoc = Server.CreateObject("Msxml2.DOMDocument");
        xmldoc.setProperty("ServerHTTPRequest", true);
        xmldoc.async = false;
        xmldoc.load("http://spreadsheets.google.com/feeds/list/0AgFAvVJ6_yLudE9MOGd1MndxWU9HUUlVRkx1SHFWNEE/od6/public/basic?alt=rss");
        if (xmldoc.parseError.errorCode != 0) {
            var myErr = xmldoc.parseError;
            WScript.Echo("You have error " + myErr.reason);
        }
        else {
            xslproc = xsl.createProcessor();
            xslproc.input = xmldoc;
            xslproc.transform();
            Response.Write(xslproc.output);
        }
    }
%>
