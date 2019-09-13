<?xml version="1.0" encoding="utf-16"?>
<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gphoto='http://schemas.google.com/photos/2007' xmlns:media='http://search.yahoo.com/mrss/' xmlns:openSearch='http://a9.com/-/spec/opensearchrss/1.0/' >
  <xsl:param name="defaultImage" />
  <xsl:param name="maxHeight">500</xsl:param>
    <xsl:variable name="quot">"</xsl:variable>
    <xsl:variable name="sQuot">'</xsl:variable>
    <xsl:variable name="numVideos">1</xsl:variable>

    <xsl:output method="html" encoding="utf-8" indent="yes"  />
	<xsl:strip-space elements="*"/>
	<xsl:template match="/">
    <script src="/_scripts/photos.js" type="text/javascript" />
    <xsl:if test="count(//item/media:group/media:content[@url=$defaultImage]) &gt; 0 or contains($defaultImage, 'youtube')" ><!-- If there is an image that matches the parameter passed in or the parameter contains "video" in it -->
  
    <div id="mainImage" class="mainImage">
      <div id="largeImageCanvas">
          <xsl:if test="contains($defaultImage, 'youtube')">
              <object id="largeVideo" width="640" height="505">
                  <param id="movieUrl" name="movie" value="{normalize-space($defaultImage)}"></param>
                  <param name="allowFullScreen" value="true"></param>
                  <param name="allowscriptaccess" value="always"></param>
                  <embed id="srcUrl" src="{normalize-space($defaultImage)}" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="640" height="505"></embed>
              </object>
              <img id="largeImage" name="largeImage" style="display:none;" />
          </xsl:if>
          <xsl:if test="not(contains($defaultImage, 'youtube'))">
              <object id="largeVideo" style="display:none;" width="640" height="505">
                  <param id="movieUrl" name="movie" value=""></param>
                  <param name="allowFullScreen" value="true"></param>
                  <param name="allowscriptaccess" value="always"></param>
                  <embed id="srcUrl" src="" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="640" height="505"></embed>
              </object>
              <img id="largeImage" name="largeImage" width="{normalize-space(//item/media:group/media:content[@url=$defaultImage]/@width * $maxHeight div //item/media:group/media:content[@url=$defaultImage]/@height)}" height="{normalize-space($maxHeight)}" onclick="$('#nextLink').click();" src="{normalize-space($defaultImage)}" />
          </xsl:if>
        <img id="loadingImage" name="loadingImage" src="/_images/loading.gif" style="display:none;"/>
      </div>
      <div id="photoNavigation" class="clearAfter">
        <xsl:if test="count(//item/media:group/media:content[@url=$defaultImage]/../../preceding-sibling::item) &gt; 0">
          <span id="back">
            <a id="backLink" href="/photos/?defaultImage={normalize-space(//item/media:group/media:content[@url=$defaultImage]/../../preceding-sibling::item[last()]/media:group/media:content/@url )}" onclick="return false;">&lt; Prev</a>
          </span>
        </xsl:if>
        <xsl:if test="count(//item/media:group/media:content[@url=$defaultImage]/../../preceding-sibling::item) = 0">
          <span id="back">
            <a id="backLink" class="disabled" onclick="?thumb{normalize-space(count(//item/media:group/media:content[@url=$defaultImage]/../../preceding-sibling::item) )}; return false;">&lt; Prev</a>
          </span>
        </xsl:if>
        <xsl:if test="count(//item/media:group/media:content[@url=$defaultImage]/../../following-sibling::item) &gt; 0">
          <span id="next">
            <a id="nextLink" href="/photos/?defaultImage={normalize-space(//item/media:group/media:content[@url=$defaultImage]/../../following-sibling::item[1]/media:group/media:content/@url )}" onclick="?thumb{normalize-space(count(//item/media:group/media:content[@url=$defaultImage]/../../preceding-sibling::item)+2 )}; return false;">Next &gt;</a>
          </span>
        </xsl:if>
        <xsl:if test="count(//item/media:group/media:content[@url=$defaultImage]/../../following-sibling::item) = 0">
          <span id="next">
            <a id="nextLink" class="disabled" onclick="return false;">Next &gt;</a>
          </span>
        </xsl:if>
      </div>
      <div id="mainImageTitle" class="mainImageTitle">
          <xsl:value-of select="//item/media:group/media:content[@url=$defaultImage]/../media:description"/>
      </div>
    </div>
  </xsl:if>
  
  <xsl:if test="count(//item/media:group/media:content[@url=$defaultImage]) = 0 and not(contains($defaultImage, 'youtube'))" ><!-- If there are no images that match the parameter passed in (or no parameter is passed in) default to first image -->
    <div id="mainImage" class="mainImage">
      <div id="largeImageCanvas">
          <object id="largeVideo" style="display:none;" width="640" height="505">
              <param id="movieUrl" name="movie" value=""></param>
              <param name="allowFullScreen" value="true"></param>
              <param name="allowscriptaccess" value="always"></param>
              <embed id="srcUrl" src="" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="640" height="505"></embed>
          </object>
          <img id="largeImage" name="largeImage" width="{normalize-space(//item[1]/media:group/media:content/@width * $maxHeight div //item[1]/media:group/media:content/@height)}" height="{normalize-space($maxHeight)}" onclick="$('#nextLink').click();" src="{normalize-space(//item[1]/media:group/media:content/@url)}" />
        <img id="loadingImage" name="loadingImage" src="/_images/loading.gif" style="display:none;"/>
      </div>
      <div id="photoNavigation" class="clearAfter">
        <span id="back"><a id="backLink" class="disabled" onclick="return false;">&lt; Prev</a></span>
        <span id="next"><a id="nextLink" href="/photos/?defaultImage={normalize-space(//item[2]/media:group/media:content/@url)}" onclick="return false;">Next &gt;</a></span>
      </div>
      <div id="mainImageTitle" class="mainImageTitle">
        <xsl:value-of select="//item[1]/media:group/media:description"/>
      </div>
    </div>
  </xsl:if>
    <div class="thumbs" id="thumbs">
      <script type="text/javascript" defer="defer">
          $(document).ready( function() {
          $.ajaxSetup ({
          // Disable caching of AJAX responses */
          cache: false
          });

          <xsl:if test="count(//item/media:group) &gt; 0">
          <xsl:if  test="count(//item/media:group/media:content[@url=$defaultImage]) &gt; 0 or contains($defaultImage, 'youtube')">
              <xsl:if test="contains($defaultImage, 'youtube')">
            switchPhoto("<xsl:value-of select="$defaultImage" />", 0, 0, "10/9/09 - Chicago Bears fans at the Union Pub", "<xsl:value-of select="count(//item/media:group)+ $numVideos"/>of<xsl:value-of select="count(//item/media:group) + $numVideos"/>");                  
              </xsl:if>
              <xsl:if test="not(contains($defaultImage, 'youtube'))">
            switchPhoto("<xsl:value-of select="$defaultImage" />", <xsl:value-of select="//item/media:group/media:content[@url=$defaultImage]/@width" />, <xsl:value-of select="//item/media:group/media:content[@url=$defaultImage]/@height" />, "<xsl:value-of select="translate(translate(//item/media:group/media:content[@url=$defaultImage]/../media:description, $quot, '||'), $sQuot, '|')" />", "<xsl:value-of select="count(//item/media:group/media:content[@url=$defaultImage]/../../preceding-sibling::item)+1"/>of<xsl:value-of select="count(//item/media:group) + $numVideos"/>");
              </xsl:if>
          </xsl:if>
          <xsl:if  test="count(//item/media:group/media:content[@url=$defaultImage]) = 0 and not(contains($defaultImage, 'youtube'))">
            switchPhoto("<xsl:value-of select="//item[1]/media:group/media:content/@url" />", <xsl:value-of select="//item[1]/media:group/media:content/@width" />, <xsl:value-of select="//item[1]/media:group/media:content/@height" />, "<xsl:value-of select="translate(translate(//item[1]/media:group/media:description, $quot, '||'), $sQuot, '|')" />", "<xsl:value-of select="position()"/>of<xsl:value-of select="count(//item/media:group) + $numVideos"/>");
          </xsl:if>
        </xsl:if>
          /*Can't get this to work, so disabling for the time being.  It only works on first event in either direction, then continues to call same as first call
          $(document).keydown(function(event)
          {
            return clickLink(Number(event.keyCode));
          });*/
      });
      </script>
      <ul class="clearAfter">
			<xsl:for-each select="//item/media:group">
        <li>
          <a href="/photos/?defaultImage={normalize-space(media:content/@url)}" id="thumbLink{normalize-space(position())}" onclick="switchPhoto('{normalize-space(media:content/@url)}','{normalize-space(media:content/@width)}','{normalize-space(media:content/@height)}','{normalize-space(translate(translate(media:description, $quot, '||'), $sQuot, '|'))}', '{normalize-space(position())}of{normalize-space(count(//item/media:group)) + $numVideos}'); return false;">
            <xsl:if test="//item/media:group/media:content[@url=$defaultImage]/@url = media:content/@url or (count(//item/media:group/media:content[@url=$defaultImage]) = 0 and position() = 1 and not(contains($defaultImage, 'youtube')))" >
              <img class="selected" id="thumb{normalize-space(position())}" title="{normalize-space(translate(media:description, $quot, $sQuot))}" src="{normalize-space(media:thumbnail[1]/@url)}" />
            </xsl:if>
            <xsl:if test="//item/media:group/media:content[@url=$defaultImage]/@url != media:content/@url or (count(//item/media:group/media:content[@url=$defaultImage]) = 0 and position() > 1) or contains($defaultImage, 'youtube')" >
              <img class="" id="thumb{normalize-space(position())}" title="{normalize-space(translate(media:description, $quot, $sQuot))}" src="{normalize-space(media:thumbnail[1]/@url)}" />
            </xsl:if>
          </a>
        </li>
			</xsl:for-each>
        <xsl:if test="not(contains($defaultImage, 'youtube'))" >
          <li class="video">
              <a href="/photos/?defaultImage=http://www.youtube.com/v/6PyOxFMvxJM?fs=1&amp;hl=en_GB&amp;rel=0&amp;color1=0x2b405b&amp;color2=0x6b8ab6" id="thumbLink{normalize-space(count(//item/media:group) + 1)}" onclick="switchPhoto('http://www.youtube.com/v/6PyOxFMvxJM?fs=1&amp;hl=en_GB&amp;rel=0&amp;color1=0x2b405b&amp;color2=0x6b8ab6',0,0,'10/9/09 - Chicago Bears fans at the Union Pub', '{normalize-space(count(//item/media:group) + 1)}of{normalize-space(count(//item/media:group) + $numVideos)}'); return false;">
                <img class="" id="thumb{normalize-space(count(//item/media:group) + 1)}" src="/_images/video1thumb.jpg" title="10/9/09 - Chicago Bears fans at the Union Pub" />
              </a>
          </li>
        </xsl:if>
        <xsl:if test="contains($defaultImage,'youtube')" >
            <li class="video selected">
                <a href="/photos/?defaultImage=http://www.youtube.com/v/6PyOxFMvxJM?fs=1&amp;hl=en_GB&amp;rel=0&amp;color1=0x2b405b&amp;color2=0x6b8ab6" id="thumbLink{normalize-space(count(//item/media:group) + 1)}" onclick="switchPhoto('http://www.youtube.com/v/6PyOxFMvxJM?fs=1&amp;hl=en_GB&amp;rel=0&amp;color1=0x2b405b&amp;color2=0x6b8ab6',0,0,'10/9/09 - Chicago Bears fans at the Union Pub', '{normalize-space(count(//item/media:group) + 1)}of{normalize-space(count(//item/media:group) + $numVideos)}'); return false;">
                    <img class="" id="thumb{normalize-space(count(//item/media:group) + 1)}" src="/_images/video1thumb.jpg" title="10/9/09 - Chicago Bears fans at the Union Pub" />
                </a>
            </li>
        </xsl:if>
      </ul>
		</div>
	</xsl:template>
</xsl:transform>
