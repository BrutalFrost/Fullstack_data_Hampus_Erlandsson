WITH 
	date_table AS (SELECT * FROM datum.tabelldata OFFSET 1),
	date_total AS (SELECT * FROM datum.totalt OFFSET 1)
SELECT 
	STRFTIME('%Y-%m-%d', date_total.datum),
	date_table.visningar AS TotalViews,
	date_total.visningar AS TableViews,
	date_table."Visningstid (timmar)",
	date_table."Genomsnittlig visningslängd",
FROM date_total
LEFT JOIN date_table 
ON date_total.datum = date_table.datum

