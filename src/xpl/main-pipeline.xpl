<?xml version="1.0" encoding="utf-8"?>
<p:declare-step version="3.0"
                xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:err="http://www.w3.org/ns/xproc-error"
                xmlns:xvrl="http://www.xproc.org/ns/xvrl"
                xmlns:ixml="http://invisiblexml.org/NS">
  <p:documentation>
    This is the main publishing pipeline.
  </p:documentation>
  <p:option name="debug-messages-on" as="xs:boolean" select="true()">
    <p:documentation>
      Toggle messages. This should probably be at the top.
    </p:documentation>
  </p:option>
  <p:input port="source"
           primary="true" />
  <p:output port="result"
            primary="true" 
            serialization="map{ 'indent': true() }"/>
  <p:output port="validation-report"
            serialization="map{ 'indent': true() }"
            pipe="report@validate-ixml">
    <p:documentation>
      This redirects the XVRL validation report to a file.
    </p:documentation>
  </p:output>
  <p:output port="output-ixml"
            serialization="map{ 'indent': true() }"
            pipe="result@ixml-xml-conversion">
    <p:documentation>
      Return ixml output.
    </p:documentation>
  </p:output>
  <p:variable name="full-date"
              select="fn:current-dateTime()"/>
  <p:variable name="ixml-blog-grammar"
              select="'../ixml/txt-post-to-xml.txt'"/>  
  <p:variable name="sch-validate-ixml-output"
              select="'../sch/validate-ixml-output.sch'"/>
  <p:variable name="xsl-ixml-post-to-html"
              select="'../xsl/ixml-post-to-html.xsl'"/>
  <p:variable name="xsl-errors"
              select="'../xsl/ixml-errors.xsl'"/>
  <p:message test="{$debug-messages-on}"
             select="[MORGANA] Converting posts..."/>
  <p:invisible-xml name="ixml-xml-conversion">
    <p:documentation>
      Pipeline starts here with txt to xml conversion.
    </p:documentation>
    <p:with-input port="grammar"
                  href="{$ixml-blog-grammar}"/>
  </p:invisible-xml>
  <p:message test="{$debug-messages-on}"
             select="[MORGANA] Validating output..."/>
  <p:validate-with-schematron
      report-format="xvrl"
      assert-valid="false"
      name="validate-ixml">
    <p:documentation>
      Validate ixml output.
      TODO this should output to a log file
    </p:documentation>
    <p:with-input port="schema"
                  href="{$sch-validate-ixml-output}"/>
  </p:validate-with-schematron>
    <p:xslt name="generate-post-html">
      <p:documentation>
        Transform valid ixml output to html.
        Only run if schematron is valid.
        TODO final html should be validated
      </p:documentation>
      <p:with-input port="stylesheet"
                    href="{$xsl-ixml-post-to-html}"/>
      <p:with-input port="source"
                    pipe="result@ixml-xml-conversion"/>
    </p:xslt>
  <p:xslt name="return-validation-message">
    <p:documentation>
      Return validation messages to standard output.
    </p:documentation>
    <p:with-input port="stylesheet"
                  href="{$xsl-errors}"/>
    <p:with-input port="source"
                  pipe="report@validate-ixml"/>
  </p:xslt>
  <p:message test="{$debug-messages-on}"
             select="[MORGANA] Done at {$full-date}"/>
</p:declare-step>
