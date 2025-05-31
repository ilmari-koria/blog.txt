<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        queryBinding="xslt3">
  <ns uri="http://invisiblexml.org/NS" prefix="ixml"/>
  <pattern id="check-title-exist">
    <rule context="//title">
      <let name="title-value" value="./text()"/>
      <assert test="$title-value != ''"
              role="error">
        The value of 'title' cannot be empty.
      </assert>
    </rule>
  </pattern>
</schema>
