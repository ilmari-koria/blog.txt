<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ixml="http://invisiblexml.org/NS"
    exclude-result-prefixes="ixml">
  <xsl:output method="html"/>
  <xsl:template match="post">
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <title>
          <xsl:value-of select="title"/>
        </title>
      </head>
      <body>
        <article>
          <header>
            <xsl:apply-templates select="title"/>
            <xsl:apply-templates select="date"/>
          </header>
          <section>
            <xsl:apply-templates select="body/p"/>
          </section>
        </article>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="title">
    <h1>
      <xsl:apply-templates />
    </h1>
  </xsl:template>
  <xsl:template match="date">
    <time datetime="{concat(@year, '-', @month, '-', @day)}">
      <xsl:value-of
          select="concat(@day, ' ', @month, ' ', @year)"/>
    </time>
  </xsl:template>
  <xsl:template match="p">
    <p>
      <xsl:apply-templates />
    </p>
  </xsl:template>
</xsl:stylesheet>
