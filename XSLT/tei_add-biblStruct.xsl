<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output encoding="UTF-8" indent="yes" omit-xml-declaration="no" method="xml"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    
    
    
    <!-- transform rows into bibls -->
    <xsl:template match="tei:row[@role='data']">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
            <cell n="10">
                <biblStruct>
                    <monogr>
                        <!-- title(s) -->
                        <xsl:apply-templates select="child::tei:cell[@n=4]/tei:name" mode="m_bibl"/>
                        <!-- editor -->
                        <xsl:apply-templates select="child::tei:cell[@n=6]/tei:persName" mode="m_bibl"/>
                        <imprint>
                            <!-- publisher -->
                            <xsl:apply-templates select="child::tei:cell[@n=6]/tei:orgName" mode="m_bibl"/>
                            <!-- place of publication -->
                            <xsl:apply-templates select="child::tei:cell[@n=5]/tei:placeName" mode="m_bibl"/>
                            <!-- date of publication -->
                            <xsl:apply-templates select="child::tei:cell[@n=1]/tei:date" mode="m_bibl"/>
                            <xsl:apply-templates select="child::tei:cell[@n=3]/tei:date" mode="m_bibl"/>
                        </imprint>
                    </monogr>
                </biblStruct>
            </cell>
        </xsl:copy>
    </xsl:template>
    
    <!-- dates -->
    <xsl:template match="tei:cell[@n=1]/tei:date" mode="m_bibl">
        <xsl:copy>
            <xsl:attribute name="type" select="'start'"/>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="tei:cell[@n=3]/tei:date" mode="m_bibl">
        <xsl:copy>
            <xsl:attribute name="type" select="'end'"/>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <!-- titles -->
    <xsl:template match="tei:cell[@n=4]/tei:name" mode="m_bibl">
        <title level="j" xml:lang="ar-Latn-x-ijmes">
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    <xsl:template match="tei:cell[@n=5]/tei:placeName" mode="m_bibl">
        <pubPlace>
            <xsl:copy>
                <xsl:attribute name="xml:lang" select="'en'"/>
                <xsl:apply-templates/>
            </xsl:copy>
        </pubPlace>
    </xsl:template>
    <xsl:template match="tei:cell[@n=6]/tei:orgName" mode="m_bibl">
        <publisher>
            <xsl:copy>
                <xsl:attribute name="xml:lang" select="'en'"/>
                <xsl:apply-templates/>
            </xsl:copy>
        </publisher>
    </xsl:template>
    <xsl:template match="tei:cell[@n=6]/tei:persName" mode="m_bibl">
        <editor>
            <xsl:copy>
                <xsl:attribute name="xml:lang" select="'ar-Latn-x-ijmes'"/>
                <xsl:apply-templates/>
            </xsl:copy>
        </editor>
    </xsl:template>
    
</xsl:stylesheet>