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
    <!-- UniqueID -->
    <dct:identifier>
      doi:<xsl:value-of select="dc:identifier"/>
    </dct:identifier>
    <!-- Name -->
    <eposap:facilityName>
      <xsl:value-of select="dc:titles/dc:title"/>
    </eposap:facilityName>
    <!-- Type. Unfortunately there is no common source for this.
         already GFZ and ETH have some differences. -->
    <dct:type>
      <skos:Concept>
        <skos:prefLabel>
          <xsl:if test="dc:resourceType/@resourceTypeGeneral='Other'">
            <xsl:if test="string-length(dc:resourceType)>0">
              <xsl:value-of select="dc:resourceType"/>
            </xsl:if>
            <xsl:if test="string-length(dc:resourceType)=0">
              Seismic Network
            </xsl:if>
          </xsl:if>
        </skos:prefLabel>
        <skos:inScheme/>
      </skos:Concept>
    </dct:type>
    <!-- Country. This is not available at any source. -->
    <vcard:hasAddress>
      <vcard:Address>
        N/A
      </vcard:Address>
    </vcard:hasAddress>
    <!-- Organization. FIXME: Enumerate the possible sources for this. -->
    <xsl:for-each select="dc:contributors/dc:contributor">
      <eposap:owner>
        <eposap:organisation>
          <vcard:fn>
            <xsl:value-of select="dc:contributorName"/>
          </vcard:fn>
          <eposap:organisationID>
            <xsl:value-of select="@contributorType"/>
          </eposap:organisationID>
        </eposap:organisation>
      </eposap:owner>
    </xsl:for-each>
    <!-- Website -->
    <foaf:page>
      <foaf:Document>
        <foaf:primaryTopic>
          http://dx.doi.org/<xsl:value-of select="dc:identifier"/>
        </foaf:primaryTopic>
      </foaf:Document>
    </foaf:page>
    <!-- Science domain. TODO: Check that this hardcoded value is OK. -->
    <dcat:theme>
      Seismology
    </dcat:theme>
    <xsl:for-each select="dc:contributors/dc:contributor[@contributorType='ContactPerson']">
      <!-- Contact. TODO: There is no contact from ETH. See others. -->
      <dcat:contactPoint>
        <eposap:Person>
          <xsl:value-of select="dc:contributorName"/>
        </eposap:Person>
      </dcat:contactPoint>
    </xsl:for-each>
    <!-- Facility Manager. FIXME: Check that the loop works. -->
    <eposap:facilityManager>
      <eposap:Person>
        <xsl:value-of select="dc:creators/dc:creator/dc:creatorName"/>
        <!-- <eposap:personID>idvalue3</eposap:personID> -->
      </eposap:Person>
    </eposap:facilityManager>
    <!-- Description -->
    <dct:description>
      <xsl:value-of select="dc:descriptions/dc:description"/>
    </dct:description>
  </eposap:Facility>
</xsl:for-each>
</eposap:Baseline>
</xsl:template>
</xsl:stylesheet>
