<?xml version="1.0" encoding="utf-8"?>
<p:declare-step version="3.0"
                xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:err="http://www.w3.org/ns/xproc-error"
                xmlns:ixml="http://invisiblexml.org/NS">
  <p:documentation>
    This is the main publishing pipeline.
  </p:documentation>
  <p:input port="source" primary="true" />
  <p:output port="result"
            primary="true" 
            serialization="map{ 'indent': true() }"/>
  <p:output port="msg"
            serialization="map{ 'indent': true() }"/>
  
  <!-- global vars -->
  <p:variable name="ixml-blog-grammar"
              select="'../ixml/txt-post-to-xml.txt'"/>  
  <p:variable name="sch-validate-ixml-output"
              select="'../sch/validate-ixml-output.sch'"/>
  <p:variable name="xsl-ixml-post-to-html"
              select="'../xsl/ixml-post-to-html.xsl'"/>
  <p:variable name="xq-msg"
              select="'../xq/message.xq'"/>
  <p:invisible-xml>
    <p:documentation>
      [1] pipeline starts here with txt to xml conversion
    </p:documentation>
    <p:with-input
        port="grammar"
        href="{$ixml-blog-grammar}"/>
  </p:invisible-xml>
  <p:try>
    <p:validate-with-schematron
        name="validate"
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
  <p:xslt>
    <p:documentation>
      [3] transform valid ixml output to html
          TODO final html should be validated
    </p:documentation>
    <p:with-input port="stylesheet"
                  href="{$xsl-ixml-post-to-html}"/>
  </p:xslt>
  <p:xquery parameters="map{'message': 'Done'}">
    <p:with-input port="query" href="{$xq-msg}"/>
  </p:xquery>  
</p:declare-step>

