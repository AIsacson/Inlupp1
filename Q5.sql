SELECT XMLELEMENT(NAME "Resultat", XMLAGG(xt))
FROM(SELECT XMLELEMENT(NAME "Kurstillfälle",
			XMLATTRIBUTES(ktillf.kurs AS "kurskod", kurs.kursben AS "kursnamn",
						  ktillf.sdat AS "startdatum", lokal AS "lokal"),
			XMLAGG(XMLFOREST(lnamn AS "Lärare", (SELECT COUNT(eid)
													FROM deltag,elev
													WHERE eid = deltag.elev
													AND deltag.kurs = ktillf.kurs
													AND deltag.sdat = ktillf.sdat) AS "Antal"))) AS xt
	 FROM ktillf, kurs, lärare
	 WHERE kurs.kurskod = ktillf.kurs
	 AND lid = ktillf.lärare
	 GROUP BY ktillf.kurs, kurs.kursben, ktillf.sdat, lokal)