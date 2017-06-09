<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:dc="http://datacite.org/schema/kernel-3"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

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

<xsl:for-each select="dc:resource">
  <eposap:Facility>
    <dct:identifier>
      <xsl:value-of select="dc:identifier"/>
    </dct:identifier>
    <eposap:facilityName>facilityName</eposap:facilityName>
    <eposap:country>N/A</eposap:country>
    <dct:description>
      <xsl:value-of select="dc:descriptions/dc:description"/>
    </dct:description>
    <eposap:organisation>
      <eposap:organisationID>idvalue0</eposap:organisationID>
    </eposap:organisation>
    <eposap:contact>
      <eposap:personID>idvalue3</eposap:personID>
    </eposap:contact>
    <eposap:facilityManager>
      <eposap:personID>idvalue3</eposap:personID>
    </eposap:facilityManager>
    <dct:type>
      <skos:Concept>
        <skos:prefLabel><xsl:value-of select="dc:resourceType"/></skos:prefLabel>
        <skos:inScheme/>
      </skos:Concept>
    </dct:type>
    <foaf:page>
      <foaf:Document>
        <foaf:primaryTopic>
          http://dx.doi.org/<xsl:value-of select="dc:identifier"/>
        </foaf:primaryTopic>
      </foaf:Document>
    </foaf:page>
    <eposap:scienceDomain>
      <!-- FIXME This is not working -->
      <xsl:value-of select="dc:subjects/dc:subject"/>
    </eposap:scienceDomain>
  </eposap:Facility>
</xsl:for-each>
</eposap:Baseline>
</xsl:template>
</xsl:stylesheet>
