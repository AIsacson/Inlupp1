SELECT XMLELEMENT(NAME "Resultat", XMLAGG(xt))
FROM(SELECT XMLELEMENT(NAME "Kurstillf�lle",
			XMLATTRIBUTES(ktillf.kurs AS "kurskod", kurs.kursben AS "kursnamn",
						  ktillf.sdat AS "startdatum", lokal AS "lokal"),
			XMLAGG(XMLFOREST(lnamn AS "L�rare", (SELECT COUNT(eid)
													FROM deltag,elev
													WHERE eid = deltag.elev
													AND deltag.kurs = ktillf.kurs
													AND deltag.sdat = ktillf.sdat) AS "Antal"))) AS xt
	 FROM ktillf, kurs, l�rare
	 WHERE kurs.kurskod = ktillf.kurs
	 AND lid = ktillf.l�rare
	 GROUP BY ktillf.kurs, kurs.kursben, ktillf.sdat, lokal)