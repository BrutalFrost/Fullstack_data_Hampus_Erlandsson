
-- Views and viewtime per date
WITH 
	date_table AS (SELECT * FROM datum.tabelldata OFFSET 1),
	date_total AS (SELECT * FROM datum.totalt OFFSET 1)
SELECT 
	STRFTIME('%Y-%m-%d', date_total.datum) AS Datum,
	date_table.visningar AS TotalViews,
	date_total.visningar AS TableViews,
	date_table."Visningstid (timmar)",
	date_table."Genomsnittlig visningslängd",
FROM date_total
LEFT JOIN date_table 
ON date_total.datum = date_table.datum;


-- What hardware is used to watch
SELECT * FROM enhetstyp.tabelldata;


-- What country they are watching from
SELECT * FROM geografi.tabelldata;

-- Information per video
SELECT 
	*
EXCLUDE(Innehåll)
FROM innehall.tabelldata
ORDER BY "Visningstid (timmar)"
DESC 
OFFSET 1;


-- Amount of views per OS
SELECT * FROM operativsystem.tabelldata;

-- Sources of subscribers
SELECT * FROM prenumerationskalla.tabelldata;
SELECT * FROM prenumerationskalla.diagramdata;

WITH
	subscriber_source AS (SELECT * FROM prenumerationskalla.diagramdata),
	trafic_source AS (SELECT * FROM trafikkalla.diagramdata)
SELECT 
	subscriber_source.Datum,
	subscriber_source.Prenumeranter,
	trafic_source.Visningar
FROM subscriber_source
INNER JOIN trafic_source ON subscriber_source.Datum = trafic_source.Datum
GROUP BY 
	subscriber_source.Datum,
	subscriber_source.Prenumeranter,
	trafic_source.Visningar

-- Amount of viewers that are subscribed or not
SELECT * FROM prenumerationsstatus.tabelldata;

SELECT 
	*
EXCLUDE(Städer)
FROM stader.tabelldata;

-- Genders of viewers
SELECT * FROM tittare.tabelldata_alder;

-- Age of viewers
SELECT * FROM tittare.tabelldata_kon;

-- How viewers found the videos
SELECT * FROM trafikkalla.tabelldata;

SELECT * FROM trafikkalla.diagramdata;


