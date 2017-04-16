SELECT XMLELEMENT(NAME "Resultat", XMLAGG(xt))
FROM (SELECT XMLELEMENT(NAME "Elev",
			 XMLATTRIBUTES(enamn AS "namn"),
			 XMLAGG(XMLELEMENT(NAME "Lokal",namn)))AS xt
			 FROM elev,lokal
			 WHERE namn IN (SELECT lokal
			 					  FROM deltag,ktillf
			 					  WHERE eid = elev
			 					  AND ktillf.kurs = deltag.kurs
			 				 	  AND ktillf.sdat = deltag.sdat
			 					  AND XMLEXISTS('$KONTAKT//adress[@postort="Kista"]'))
	  GROUP BY eid, enamn);

