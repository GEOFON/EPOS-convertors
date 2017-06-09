<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:st="http://www.fdsn.org/xml/station/1"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:key name="str-no-comp" match="st:Network/st:Station/st:Channel" use="substring(@code, 1, 2)" />

<xsl:template match="/st:FDSNStationXML">

<eposap:Baseline
xmlns:adms="http://www.w3.org/ns/adms#"
xmlns:dcat="http://www.w3.org/ns/dcat#"
xmlns:dct="http://purl.org/dc/terms/"
xmlns:eposap="http://www.epos-ip.org/"
xmlns:foaf="http://xmlns.com/foaf/0.1/"
xmlns:locn="http://www.w3.org/ns/locn#"
xmlns:owl="http://www.w3.org/2002/07/owl#"
xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:schema="http://schema.org/"
xmlns:skos="http://www.w3.org/2004/02/skos/core#"
xmlns:spdx="http://spdx.org/rdf/terms#"
xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
xmlns:xml="http://www.w3.org/XML/1998/namespace"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://www.epos-ip.org/ EPOS_DCAT-AP.xsd ">

<xsl:for-each select="st:Network/st:Station/st:Channel[count(. | key('str-no-comp', substring(@code, 1, 2))[1]) = 1]">
  <xsl:variable name="current-grouping-key"
                select="substring(@code, 1, 2)"/>
  <xsl:variable name="current-group"
                select="key('str-no-comp',
                            $current-grouping-key)"/>
  <eposap:Equipment>
    <dct:identifier><xsl:value-of select="../../@code"/>.<xsl:value-of select="../@code"/>.<xsl:value-of select="@locationCode"/>.<xsl:value-of select="$current-grouping-key"/></dct:identifier>
    <eposap:serialNumber>serialNumber TBD!</eposap:serialNumber>
    <dct:type>
      <skos:Concept>
        <skos:prefLabel>type. TBD! Why this nesting of tags?</skos:prefLabel>
        <skos:inScheme/>
      </skos:Concept>
    </dct:type>
    <eposap:quantity><xsl:value-of select="count(key('str-no-comp', $current-grouping-key))"/></eposap:quantity>
    <eposap:manufacturer>
      <xsl:for-each select="$current-group">
         <!-- processing for elements in group -->
         <!-- you can use xsl:sort here also, if necessary -->
         <xsl:value-of select="st:DataLogger/st:Manufacturer"/>
      </xsl:for-each>
    </eposap:manufacturer>
    <dct:description><xsl:value-of select="../st:Site/st:Name"/>, <xsl:value-of select="../st:Site/st:Country"/></dct:description>
    <eposap:instrumentName><xsl:value-of select="../../@code"/>.<xsl:value-of select="../@code"/>.<xsl:value-of select="@locationCode"/>.<xsl:value-of select="$current-grouping-key"/></eposap:instrumentName>
    <dct:temporal>
      <dct:PeriodOfTime>
        <schema:startDate><xsl:value-of select="@startDate"/></schema:startDate>
        <schema:endDate><xsl:value-of select="@endDate"/></schema:endDate>
      </dct:PeriodOfTime>
    </dct:temporal>
    <eposap:orientation>Orientation TBD!</eposap:orientation>
    <eposap:dynamicRange>
      <eposap:evaluationID>Dynamic Range TBD!</eposap:evaluationID>
    </eposap:dynamicRange>
    <eposap:resolution>Resolution TBD!</eposap:resolution>
    <eposap:samplePeriod>
      <eposap:value>1/<xsl:value-of select="st:SampleRate"/></eposap:value>
    </eposap:samplePeriod>
    <eposap:filter>some filter TBD!</eposap:filter>
    <dct:spatial>
      <dct:Location>
        <locn:geometry>POINT(<xsl:value-of select="st:Latitude"/>,<xsl:value-of select="st:Longitude"/>,<xsl:value-of select="st:Elevation"/>)</locn:geometry>
      </dct:Location>
    </dct:spatial>
  </eposap:Equipment>
</xsl:for-each>
</eposap:Baseline>
</xsl:template>
</xsl:stylesheet>
