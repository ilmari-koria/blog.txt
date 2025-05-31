<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:xvrl="http://www.xproc.org/ns/xvrl">
  <xsl:output method="xml"
              indent="no"
              encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="/">
    <xsl:if test="//xvrl:digest/@valid = 'false'">
      <xsl:message>VALIDATION ERROR: <xsl:value-of select="//xvrl:detection/xvrl:message"/> (<xsl:value-of select="//xvrl:detection/xvrl:location/@xpath"/>).</xsl:message>
    </xsl:if>
    <xsl:if test="//xvrl:digest/@valid = 'true'">
      <xsl:message>ixml output OK.</xsl:message>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
