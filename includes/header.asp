		<div id="header" class="clearAfter">
			<a href="/" title="DC Bears Fans Home"><img id="logo" alt="DC Bears Fans" title="DC Bears Fans" src="/_images/clubname1.gif" border="0" /></a>
            <ul id="topNav">
           <%
                var pageNames = new Array("Home", "About", "Club News & Events", "Bear Links", "Photo Gallery", "Contact" );
                var pageLinks = new Array("/", "/about/", "/news/", "/links/", "/photos/", "/contact/");
                var currentSection = new String(Request.ServerVariables("URL"));
                for (var i=0; i< pageNames.length; i++)
                {
                    var className = "";
                    if (pageLinks[i] == "/" && (currentSection == "" || currentSection == "/" || currentSection == "/index.asp"))
                        className = "current";
                    else if(pageLinks[i] != "/")
                        className = currentSection.indexOf(pageLinks[i]) != -1 ? "current" : "";
                    className += i == (pageNames.length-1) ? " last" : "";
                    Response.Write("\t<li class='" + className + "'><a title='" + pageNames[i] + "' href='" + pageLinks[i] + "'>" + pageNames[i] + "</a></li>\n\t");
                }%>
             </ul>
		</div>
