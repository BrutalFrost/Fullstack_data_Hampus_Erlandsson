DESC;

SELECT 
	* 
FROM information_schema.schemata 
WHERE catalog_name = 'youtube_data';

CREATE SCHEMA IF NOT EXISTS marts;

CREATE TABLE IF NOT EXISTS marts.content_view_time AS 
(
SELECT
	Videotitel,
	"Publiceringstid för video" AS Publiceringstid,
	Visningar,
	"Visningstid (timmar)" AS Visningstid_timmar,
	Exponeringar,
	Prenumeranter,
	"Klickfrekvens för exponeringar (%)" AS "Klickfrekvens_exponering_%"
FROM
	innehall.tabelldata
ORDER BY
	"Visningstid (timmar)" DESC OFFSET 1);

CREATE TABLE IF NOT EXISTS marts.views_per_date AS (
SELECT
	STRFTIME('%Y-%m-%d',
	Datum) AS Datum,
	Visningar
FROM
	innehall.totalt);


CREATE TABLE IF NOT EXISTS marts.viewer_genders AS (
SELECT
	*
FROM
	tittare.tabelldata_kon);

CREATE TABLE IF NOT EXISTS marts.viewer_ages AS (
SELECT
	*
FROM
	tittare.tabelldata_alder);

CREATE TABLE IF NOT EXISTS marts.subsriber_ratio AS (
SELECT
	*
FROM
	prenumerationsstatus.tabelldata);

CREATE TABLE IF NOT EXISTS marts.subscriber_countries AS (
SELECT
	*
FROM
	geografi.tabelldata);

CREATE TABLE IF NOT EXISTS marts.views_and_subscribers AS (
	WITH
		subscriber_source AS (SELECT Datum, SUM(Prenumeranter) AS Prenumeranter FROM prenumerationskalla.diagramdata GROUP BY Datum),
		trafic_source AS (SELECT Datum, SUM(Visningar) AS Visningar FROM trafikkalla.diagramdata GROUP BY Datum)
	SELECT 
		subscriber_source.Datum,
		subscriber_source.Prenumeranter,
		trafic_source.Visningar
	FROM subscriber_source
	INNER JOIN trafic_source ON subscriber_source.Datum = trafic_source.Datum
);


SELECT
	*
FROM
	information_schema.tables
WHERE
	table_schema = 'marts';

SELECT
	*
FROM
	marts.content_view_time;


SELECT
	*
FROM
	marts.views_per_date;


SELECT * FROM marts.viewer_genders;

SELECT * FROM marts.viewer_ages;

SELECT * FROM marts.subsriber_ratio;

SELECT * FROM marts.subscriber_countries;

SELECT 
	Datum,

FROM marts.views_and_subscribers
ORDER BY Datum DESC;

SELECT SUM(Visningar) FROM marts.views_and_subscribers