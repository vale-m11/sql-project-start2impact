SELECT "year", cname_send, main_posting, title, gender, cname_receive, ccode_send, ccodealp_send, ccodeCOW_send, region_send, GME_send, v2lgfemleg_send, FFP_send, ccode_receive, ccodealp_receive, ccodeCOW_receive, region_receive, GME_receive, FFP_receive
FROM sqlgendip;

-- Per avere una visione complessiva della disparità di genere, lancio una query per capire quanti elementi ho per tutti e tre i valori del campo 'gender'

SELECT gender, COUNT(*)
FROM sqlgendip
GROUP BY gender

-- Analizzo i dati per capire se e come è presente disparità di genere nel corso del tempo: lancio un conteggio di quanti uomini, quante donne e quanti con genere mancante per anno

SELECT year, gender, COUNT(*)
FROM sqlgendip
GROUP BY year, gender 

-- Per avere una visualizzazione più chiara, ripeto il conteggio per ognuno dei valori del campo 'gender' e raggruppando per anno

SELECT year, COUNT(*)
FROM sqlgendip
WHERE gender = '0'
GROUP BY year

SELECT year, COUNT(*)
FROM sqlgendip
WHERE gender = '1'
GROUP BY year

SELECT year, COUNT(*)
FROM sqlgendip
WHERE gender = '99'
GROUP BY year

-- Per avere una visualizzazione più chiara e lanciare una sola query, ripeto il conteggio raggruppando per anno e per genere e ordinando i dati per anno in ordine crescente

SELECT year, gender, COUNT(*) 
FROM sqlgendip
GROUP BY year, gender
ORDER BY year ASC

-- Uso CASE WHEN per trasformare gli 0/1/99 in valori testuali e calcolo le percentuali di donne, uomini e genere mancante rispetto al totale.

SELECT year, gender, COUNT(*),
CASE WHEN gender = '0' THEN 'uomini'
WHEN gender = '1' THEN 'donne'
WHEN gender = '99' THEN 'mancante'
END AS genere
FROM sqlgendip
GROUP BY year, gender
ORDER BY year ASC

SELECT year, (COUNT(gender)/COUNT(*))*100 as percentuale
FROM sqlgendip
WHERE gender = 0
GROUP BY year

SELECT year, (COUNT(gender)/COUNT(*))*100 as percentuale
FROM sqlgendip
WHERE gender = 1
GROUP BY year

SELECT year, (COUNT(gender)/COUNT(*))*100 as percentuale
FROM sqlgendip
WHERE gender = 99
GROUP BY YEAR

-- in alternativa

WITH total AS
(SELECT sqlgendip.year, COUNT(*) as total
FROM sqlgendip
GROUP BY sqlgendip.year) 
SELECT sqlgendip.year, 
CASE 
WHEN gender = '0' THEN 'uomini'
WHEN gender = '1' THEN 'donne'
WHEN gender = '99' THEN 'mancante'
END AS gender, 
COUNT(*)/total as percentuale
FROM sqlgendip
LEFT JOIN total
ON total.year = sqlgendip.year
GROUP BY total, sqlgendip.year, gender


-- Analizzo i dati per capire la disparità di genere tra le aree geografiche

SELECT region_send, gender, COUNT(*) 
FROM sqlgendip
GROUP BY gender, region_send 
ORDER BY region_send ASC

-- Ripeto il conteggio confrontando le aree geografiche e isolando i dati di ognuno dei tre valori del campo 'gender' con query distinte

SELECT region_send, COUNT(*) 
FROM sqlgendip
WHERE gender = '0'
GROUP BY region_send 
ORDER BY region_send ASC

SELECT region_send, COUNT(*) 
FROM sqlgendip
WHERE gender = '1'
GROUP BY region_send 
ORDER BY region_send ASC

SELECT region_send, COUNT(*) 
FROM sqlgendip
WHERE gender = '99'
GROUP BY region_send 
ORDER BY region_send ASC

-- Analizzo i dati per capire se e come è presente disparità di genere tra uomo e donna per ognuno dei titoli. Raggruppo per titolo e ordino i dati per titolo in ordine crescente. Lancio una query per isolare i dati relativi agli uomini e una per i dati relativi alle donne

SELECT title, COUNT(*)
FROM sqlgendip
WHERE gender = '0'
GROUP BY title 
ORDER BY title ASC

SELECT title, COUNT(*)
FROM sqlgendip
WHERE gender = '1'
GROUP BY title 
ORDER BY title ASC

-- Analizzo i dati relativi all'Italia

-- Per avere una visione della disparità di genere, lancio una query per capire quanti elementi ho per tutti e tre i valori del campo 'gender'

SELECT gender, COUNT(*)
FROM sqlgendip
WHERE cname_send = 'Italy'
GROUP BY gender

-- Analizzo i dati per capire se e come è presente disparità di genere nel corso del tempo: lancio un conteggio di quanti uomini, quante donne e quanti con genere mancante per anno

SELECT year, gender, COUNT(*)
FROM sqlgendip
WHERE cname_send = 'Italy'
GROUP BY year, gender 

-- Per avere una visualizzazione più chiara, ripeto il conteggio per ognuno dei valori del campo 'gender' raggruppando per anno

SELECT year, COUNT(*)
FROM sqlgendip
WHERE gender = '0'
AND cname_send = 'Italy'
GROUP BY year

SELECT year, COUNT(*)
FROM sqlgendip
WHERE gender = '1'
AND cname_send = 'Italy'
GROUP BY year

SELECT year, COUNT(*)
FROM sqlgendip
WHERE gender = '99'
AND cname_send = 'Italy'
GROUP BY year

-- Per avere una visualizzazione più chiara e lanciare una sola query, ripeto il conteggio raggruppando per anno e per genere e ordinando i dati per genere in ordine crescente

SELECT gender, year, COUNT(*) 
FROM sqlgendip
WHERE cname_send = 'Italy'
GROUP BY year, gender
ORDER BY gender ASC

-- Analizzo i dati per capire se e come è presente disparità di genere tra uomo e donna in Italia per ognuno dei titoli. Raggruppo per titolo e ordino i dati per titolo in ordine crescente

SELECT title, COUNT(*)
FROM sqlgendip
WHERE gender = '0'
AND cname_send = 'Italy'
GROUP BY title 
ORDER BY title ASC

SELECT title, COUNT(*)
FROM sqlgendip
WHERE gender = '1'
AND cname_send = 'Italy'
GROUP BY title 
ORDER BY title ASC

