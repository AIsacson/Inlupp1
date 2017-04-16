<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml"/>
<xsl:variable name="doc" select="document('filmer1.xml')" />
	<xsl:template match="/">
		<xsl:element name="Filmer">
			<xsl:for-each select="$doc//Film[not(@Namn = preceding::Film/@Namn)]">
				<xsl:sort select="@År" order="ascending"/>
				<xsl:element name="Film">
					<xsl:attribute name="Titel"><xsl:value-of select="@Titel"/></xsl:attribute>
					<xsl:attribute name="År"><xsl:value-of select="@År"/></xsl:attribute>
					<xsl:attribute name="Produktionsbolag"><xsl:value-of select="./Produktionsbolag"/></xsl:attribute>
					<xsl:attribute name="Regissör"><xsl:value-of select="./Regissör/@Namn"/></xsl:attribute>
					<xsl:apply-templates select="."/>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="Film">
		<xsl:for-each select=".//Skådis">
			<xsl:element name="Skådis"><xsl:value-of select="@Namn"/></xsl:element>
		</xsl:for-each>
	</xsl:template>
</xsl:transform>