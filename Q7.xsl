<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:variable name="doc" select="document('filmer1.xml')" />
	<xsl:template match="/">
	 	<xsl:for-each select="$doc//Film[not(Produktionsbolag = preceding::Produktionsbolag)]">
	 		<html>
	 			<body><h3><xsl:value-of select="."/></h3>

	 		<table border="1.5">
	 			<tr>
	 				<th>Titel</th>
	 				<th>År</th>
	 				<th>Regissör</th>
	 				<th>Regissörens land</th>
	 				<th>Antal skådisar</th>
	 			</tr>
	 				<xsl:apply-templates select="Produktionsbolag"/>
	 		</table>
	 		</body>
	 	</html>
	 	</xsl:for-each>
	</xsl:template>
	<xsl:template match="text()">
		<xsl:apply-templates select="$doc//Film[Produktionsbolag = current()]">
			<xsl:sort select="@År" order="ascending"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="Film">
		<tr>
			<td><xsl:value-of select="@Titel"/></td>
			<td><xsl:value-of select="@År"/></td>
			<td><xsl:value-of select="./Regissör/@Namn"/></td>
			<td><xsl:value-of select="./Regissör/@Land"/></td>
			<td><xsl:value-of select="count(./Skådis/@Namn)"/></td>
		</tr>
	</xsl:template>
</xsl:transform> 