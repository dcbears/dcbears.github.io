<?xml version="1.0" encoding="utf-16"?>
<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gphoto='http://schemas.google.com/photos/2007' xmlns:media='http://search.yahoo.com/mrss/' xmlns:openSearch='http://a9.com/-/spec/opensearchrss/1.0/' >
    <xsl:variable name="class">
        <i ref="0">even</i>
        <i ref="1">odd</i>
    </xsl:variable>
    <xsl:output method="html" encoding="utf-8" indent="yes"  />
	<xsl:strip-space elements="*"/>
	<xsl:template match="/">
      <ul id="schedule">
          <li>
              <ul class="header clearAfter">
                  <li class="date">Date</li>
                  <li class="team">Bad guys</li>
                  <li class="time">Time (ET)</li>
              </ul>
          </li>
		<xsl:for-each select="//item">
            <li>
                <ul class="stripe{normalize-space(position() mod 2)} clearAfter">
                    <li class="date"><xsl:value-of select="substring-after(substring-before(description, ', home'), 'datetoshow: ')"/></li>
                    <li class="team">
                        <xsl:if test="contains(description, 'home: FALSE')">@ </xsl:if>
                        <xsl:value-of select="substring-after(substring-before(description,', et:'), 'opponent: ')"/>
                    </li>
                    <xsl:if test="not(contains(description, 'finalbearsscore'))">
                        <li class="time"><xsl:value-of select="substring-after(substring-before(description, ', channel'), 'et: ')"/></li>
                    </xsl:if>
                    <xsl:if test="contains(description, 'finalbearsscore')">
                        <li class="final">                            
                            <xsl:if test="contains(description, 'win: TRUE')">W </xsl:if>
                            <xsl:if test="contains(description, 'win: FALSE')">L </xsl:if>
                            <xsl:value-of select="substring-after(substring-before(description, ', finalopponentscore'), 'finalbearsscore: ')"/> - <xsl:value-of select="substring-after(substring-before(description, ', win:'), 'finalopponentscore: ')"/>
                    </li>
                    </xsl:if>
                </ul>
            </li>
	    </xsl:for-each>
          <li>
              <ul class="stripe{(count(//item) +1 ) mod 2} record clearAfter">
                  <li>
                      Record: <xsl:value-of select="count(//item[contains(description, 'win: TRUE')])"/>-<xsl:value-of select="count(//item[contains(description, 'win: FALSE')])"/>
                  </li>
              </ul>
          </li>
      </ul>
	</xsl:template>
</xsl:transform>
