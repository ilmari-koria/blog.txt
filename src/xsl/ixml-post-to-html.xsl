<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ixml="http://invisiblexml.org/NS">
  <xsl:template match="/">
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
            <h1>
              <xsl:value-of select="title"/>
            </h1>
            <time datetime="{concat(@year, '-', @month, '-', @day)}">
              <xsl:value-of
                  select="concat(
                            date/@day, ' ', date/@month, ' ', date/@year
                          )"/>
            </time>
          </header>
          <section>
            <xsl:apply-templates select="body/p"/>
          </section>
        </article>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="body/p">
    <p>
      <xsl:value-of select="."/>
    </p>
  </xsl:template>
</xsl:stylesheet>
