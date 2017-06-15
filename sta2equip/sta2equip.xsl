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
    <!-- UniqueID -->
    <dct:identifier>
      <xsl:value-of select="../../@code"/>.<xsl:value-of select="../@code"/>.<xsl:value-of select="@locationCode"/>.<xsl:value-of select="$current-grouping-key"/>-<xsl:value-of select="@startDate"/>
    </dct:identifier>
    <!-- SerialNumber -->
    <eposap:serialNumber>
      Sensor: <xsl:value-of select="st:Sensor/st:SerialNumber"/>. DataLogger: <xsl:value-of select="st:DataLogger/st:SerialNumber"/>.
    </eposap:serialNumber>
    <!-- Type. Using the 2nd letter from channel to get a description from the
    Seed Manual -->
    <dct:type>
      <skos:Concept>
        <skos:prefLabel>
          <!-- Transform the 2nd channel letter into a description. -->
          <xsl:apply-templates select="@code"/>
        </skos:prefLabel>
        <skos:inScheme/>
      </skos:Concept>
    </dct:type>
    <!-- Quantity.
    Count how many components can be found. -->
    <eposap:quantity>
      <xsl:value-of select="count(key('str-no-comp', $current-grouping-key))"/>
    </eposap:quantity>
    <!-- Manufacturer.
    Take the one from the Datalogger based on GFZ.
    TODO: Check in other data centres. -->
    <eposap:manufacturer>
      Sensor: <xsl:value-of select="st:Sensor/st:Manufacturer"/>. DataLogger: <xsl:value-of select="st:DataLogger/st:Manufacturer"/>.
    </eposap:manufacturer>
    <!-- Description.
    TODO: Merge what is in 'type' and the description of the Site. -->
    <dct:description>
      <xsl:apply-templates select="@code"/> in
      <xsl:value-of select="../st:Site/st:Name"/>, <xsl:value-of select="../st:Site/st:Country"/>
    </dct:description>
    <!-- ValidFrom -->
    <!-- ValidTo -->
    <dct:temporal>
      <dct:PeriodOfTime>
        <schema:startDate><xsl:value-of select="@startDate"/></schema:startDate>
        <schema:endDate><xsl:value-of select="@endDate"/></schema:endDate>
      </dct:PeriodOfTime>
    </dct:temporal>
    <!-- InstrumentName
    Use the NET.STA.LOC.CHA code. -->
    <eposap:instrumentName>
      <xsl:value-of select="../../@code"/>.<xsl:value-of select="../@code"/>.<xsl:value-of select="@locationCode"/>.<xsl:value-of select="$current-grouping-key"/>
    </eposap:instrumentName>
    <!-- Orientation
    TODO: Take Azimuth and Dip for each channel. -->
    <eposap:orientation>Orientation TBD!</eposap:orientation>
    <!-- dynamicRange -->
    <eposap:dynamicRange>
      <eposap:evaluationID>
        N/A
      </eposap:evaluationID>
    </eposap:dynamicRange>
    <!-- Resolution -->
    <eposap:resolution>
      N/A
    </eposap:resolution>
    <!-- samplePeriod -->
    <eposap:samplePeriod>
      <!-- FIXME This does not seem to match the XSD. Maybe evaluationID? -->
      <eposap:Evaluation>
        <!-- samplePeriod/value -->
        <eposap:value>
          <xsl:value-of select="format-number(1 div st:SampleRate,'#.###')"/>
        </eposap:value>
        <!-- samplePeriod/unit -->
        <eposap:unit>
          s
        </eposap:unit>
      </eposap:Evaluation>
    </eposap:samplePeriod>
    <!-- filter -->
    <eposap:filter>
      N/A
    </eposap:filter>
    <!-- Location
    Use a POINT with longitude, latitude and elevation as parameters. -->
    <dct:spatial>
      <dct:Location>
        <locn:geometry>POINT(<xsl:value-of select="st:Longitude"/>,<xsl:value-of select="st:Latitude"/>,<xsl:value-of select="st:Elevation"/>)</locn:geometry>
      </dct:Location>
    </dct:spatial>
  </eposap:Equipment>
</xsl:for-each>
</eposap:Baseline>
</xsl:template>

<xsl:template match="/st:FDSNStationXML/st:Network/st:Station/st:Channel/@code">
  <xsl:choose>
    <xsl:when test="substring(., 2, 1)='H'">
      High Gain Seismometer
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='L'">
      Low Gain Seismometer
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='G'">
      Gravimeter
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='M'">
      Mass Position Seismometer
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='N'">
      Accelerometer
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='A'">
      Tiltmeter
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='B'">
      Creep meter
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='C'">
      Calibration Unit
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='D'">
      Barometer
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='E'">
      Electronic Test Point
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='F'">
      Magnetometer
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='I'">
      Humidity measurement
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='J'">
      Rotational Sensor
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='K'">
      Temperature measurement
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='O'">
      Water current measurement
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='Q'">
      Electric Potential
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='R'">
      Rainfall measurement
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='S'">
      Linear Strain
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='T'">
      Tide instrument (Depth of water)
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='U'">
      Bolometer
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='W'">
      Wind measurement
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='X'">
      Derived or generated channel
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='Y'">
      Non-specific instrument
    </xsl:when>
    <xsl:when test="substring(., 2, 1)='Z'">
      Synthesized Beams
    </xsl:when>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
