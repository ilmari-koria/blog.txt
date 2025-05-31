<?xml version="1.0" encoding="utf-8"?>
<p:declare-step version="3.0"
                xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:err="http://www.w3.org/ns/xproc-error"
                xmlns:ixml="http://invisiblexml.org/NS">
  <p:documentation>
    This is the main publishing pipeline.
  </p:documentation>
  <p:option name="debug-messages-on" as="xs:boolean" select="true()">
    <p:documentation>
      Toggle messages. This should probably be at the top.
    </p:documentation>
  </p:option>
  <p:input port="source" primary="true" />
  <p:output port="result"
            primary="true" 
            serialization="map{ 'indent': true() }"
            pipe="result@generate-post-html"/>
  <p:variable name="full-date"
              select="fn:current-dateTime()"/>
  <p:variable name="ixml-blog-grammar"
              select="'../ixml/txt-post-to-xml.txt'"/>  
  <p:variable name="sch-validate-ixml-output"
              select="'../sch/validate-ixml-output.sch'"/>
  <p:variable name="xsl-ixml-post-to-html"
              select="'../xsl/ixml-post-to-html.xsl'"/>
  <p:variable name="xq-msg"
              select="'../xq/message.xq'"/>
  <p:message test="{$debug-messages-on}" select="[MORGANA] Converting posts..."/>
  <p:invisible-xml name="ixml-xml-conversion">
    <p:documentation>
      [1] pipeline starts here with txt to xml conversion
    </p:documentation>
    <p:with-input port="grammar"
                  href="{$ixml-blog-grammar}"/>
  </p:invisible-xml>
  <p:message test="{$debug-messages-on}" select="[MORGANA] Validating output..."/>
  <p:try>
    <p:validate-with-schematron
        report-format="xvrl"
        assert-valid="true">
      <p:documentation>
        [2] validate ixml output
        TODO this should output to a log file
      </p:documentation>
      <p:with-input port="schema"
                    href="{$sch-validate-ixml-output}"/>
    </p:validate-with-schematron>
    <p:catch code="err:XC0054">
      <p:identity/>
    </p:catch>
  </p:try>
  <p:message test="{$debug-messages-on}" select="[MORGANA] Validation OK..."/>
  <p:message test="{$debug-messages-on}" select="[MORGANA] Transforming posts to HTML"/>
  <p:xslt name="generate-post-html">
    <p:documentation>
      [3] transform valid ixml output to html
      TODO final html should be validated
    </p:documentation>
    <p:with-input port="stylesheet"
                  href="{$xsl-ixml-post-to-html}"/>
    <p:with-input port="source"
                  pipe="result@ixml-xml-conversion"/>
  </p:xslt>
  <p:message test="{$debug-messages-on}"
             select="[MORGANA] Done at {$full-date}"/>
</p:declare-step>
