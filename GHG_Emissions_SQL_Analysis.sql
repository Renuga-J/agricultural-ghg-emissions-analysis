/* =========================================================
   PROJECT: Global Agricultural Greenhouse Gas Emissions Analysis
   TOOLS USED: SQL Server, Power BI
   DATA PERIOD: 1990–2021
========================================================= */

----- DATA CLEANING AND MAPPING ----



SELECT DISTINCT Area,
	CASE 
		WHEN Area = 'Brunei Darussalam'	THEN 'Brunei'
		WHEN Area = 'Burkina Faso'	THEN 'Burkina'
		WHEN Area = 'Cabo Verde'	THEN 'Cape Verde'
		WHEN Area = 'China, Hong Kong SAR'	THEN 'Hong Kong'
		WHEN Area = 'China, mainland'	THEN 'China'
		WHEN Area = 'China, Taiwan Province of'	THEN 'Taiwan'
		WHEN Area = 'Côte d''Ivoire'	THEN 'Ivory Coast'
		WHEN Area = 'Democratic People''s Republic of Korea'	THEN 'North Korea'
		WHEN Area = 'Eswatini'	THEN 'Swaziland'
		WHEN Area = 'Lao People''s Democratic Republic'	THEN 'Laos'
		WHEN Area = 'Micronesia (Federated States of)'	THEN 'Micronesia'
		WHEN Area = 'Myanmar'	THEN 'Burma (Myanmar)'
		WHEN Area = 'Netherlands (Kingdom of the)'	THEN 'Netherlands'
		WHEN Area = 'North Macedonia'	THEN 'Macedonia'
		WHEN Area = 'Republic of Korea' THEN 'South Korea'
		WHEN Area = 'Republic of Moldova' THEN 'Moldova'
		WHEN Area = 'Russian Federation' THEN 'Russia'
		WHEN Area = 'Syrian Arab Republic' THEN 'Syria'
		WHEN Area = 'Timor-Leste' THEN 'East Timor'
		WHEN Area = 'Türkiye' THEN 'Turkey'
		WHEN Area = 'United Kingdom of Great Britain and Northern Ireland' THEN 'United Kingdom'
		WHEN Area = 'United Republic of Tanzania' THEN 'Tanzania'
		WHEN Area = 'United States of America' THEN 'United States'
		WHEN Area = 'USSR' THEN 'Russia'
		WHEN Area = 'Venezuela (Bolivarian Republic of)' THEN 'Venezuela'
		WHEN Area = 'Viet Nam' THEN 'Vietnam'
		ELSE Area
	END AS Country,
	Year,
	Element_Code AS Raw_Element,
	Element AS Gas_Emitted,
	Item AS Source,
	Unit,
	Value AS Emission 

INTO Final_Emissions_Cleaned


FROM dbo.GHG_Emissions_Table
WHERE Area NOT IN (
	'American Samoa',
	'Anguilla',
	'Aruba',
	'Belgium-Luxembourg',
	'Bermuda',
	'British Virgin Islands',
	'Cayman Islands',
	'Channel Islands',
	'China,Macao SAR',
	'Cook Islands',
	'Czechoslovakia',
	'Ethiopia PDR',
	'Falkland Islands (Malvinas)',
	'Faroe Islands',
	'French Guiana',
	'French Polynesia',
	'Gibraltar',
	'Greenland',
	'Guadeloupe',
	'Guam',
	'Holy See',
	'Isle of Man',
	'Martinique',
	'Mayotte',
	'Montserrat',
	'Netherlands Antilles (former)',
	'New Caledonia',
	'Niue',
	'Norfolk Island',
	'Northern Mariana Islands',
	'Pacific Islands Trust Territory',
	'Palestine',
	'Pitcairn',
	'Puerto Rico',
	'Réunion',
	'Saint Helena, Ascension and Tristan da Cunha',
	'Saint Pierre and Miquelon',
	'Serbia and Montenegro',
	'Sudan (former)',
	'Svalbard and Jan Mayen Islands',
	'Tokelau',
	'Turks and Caicos Islands',
	'United States Virgin Islands',
	'Wallis and Futuna Islands',
	'Western Sahara',
	'Yugoslav SFR'
	
);

---- FINAL TABLE PREPARATION ----

ALTER TABLE Final_Emissions_Cleaned
DROP COLUMN Area;


SELECT 
	e.Country,
	c.Continent,
	e.Year,
	CASE 
		WHEN e.Gas_Emitted LIKE '%CH4%' THEN 'Methane'
		WHEN e.Gas_Emitted LIKE '%N2O%' THEN 'Nitrous Oxide'
		WHEN e.Gas_Emitted LIKE '%CO2%' THEN 'Carbon Dioxide'
		ELSE 'Other'
	END AS Gas_Type,

	ROUND(e.Emission,2) AS Emissions,

	e.Unit
	
INTO Final_Analysis_Table 

FROM dbo.Final_Emissions_Cleaned  e

LEFT JOIN dbo.Reference_Table c
ON e.Country = c.Country;

----- DEBUGGING AND DATA CORRECTION ---

SELECT DISTINCT Country
FROM Final_Analysis_Table
WHERE Continent IS NULL;

UPDATE dbo.Reference_Table
SET Country = 'Democratic Republic of the Congo'
WHERE Country = 'Democratic Republic of Congo';

DELETE FROM Final_Emissions_Cleaned
WHERE Country LIKE '%Macao%';

UPDATE Final_Emissions_Cleaned
SET Country = 'Bolivia'
WHERE Country = 'Bolivia (Plurinational State of)';

UPDATE Final_Emissions_Cleaned
SET Country = 'Iran'
WHERE Country = 'Iran (Islamic Republic of)';


--- EXPLORATORY DATA ANALYSIS ----

--- How have total global agricultural greenhouse gas emissions changed over time? ---
SELECT 
	Year,
	ROUND(SUM(Emissions),2) AS Total_Global_Emissions
FROM Final_Analysis_Table
GROUP BY Year
ORDER BY Year;

SELECT 
	Year,
	Gas_Type,
	ROUND(SUM(Emissions),2) AS Total_Global_Emissions
FROM Final_Analysis_Table
GROUP BY Year,Gas_Type
ORDER BY Year, Gas_Type;


------ Which continent has the highest cumulative emissions over the last three decades?---
SELECT
    Continent,
    ROUND(SUM(Emissions),2) AS Total_Emissions
FROM Final_Analysis_Table
GROUP BY Continent
ORDER BY Total_Emissions DESC;

---- Which gas contributes most? ----
SELECT 
	Gas_Type,
	ROUND(SUM(Emissions),2) AS Total_Emissions
FROM Final_Analysis_Table
GROUP BY Gas_Type
ORDER BY Total_Emissions DESC;

---- Which are the top 10 countries with the highest emission in 2021?----
SELECT TOP 10
	Country,
	ROUND(SUM(Emissions),2) AS Total_Emissions 
FROM Final_Analysis_Table
WHERE Year = 2021
GROUP BY Country
ORDER BY Total_Emissions DESC;

---- Top 10 countries with the highest percentage increase in emissions from 1990-2021--- 

---- Compare emissions between 1990 and 2021----- 
WITH Emissions_1990 AS (
	SELECT 
		Country, 
		SUM(Emissions) AS Emissions_1990

	FROM Final_Analysis_Table
	WHERE Year = 1990
	GROUP BY Country
	),
Emissions_2021 AS (
	SELECT 
		Country, 
		SUM(Emissions) AS Emissions_2021

	FROM Final_Analysis_Table
	WHERE Year = 2021
	GROUP BY Country
	)


SELECT TOP 10
	e90.Country,
	ROUND(e90.Emissions_1990,2) AS Emissions_1990,
	ROUND(e21.Emissions_2021,2) AS Emissions_2021,
	ROUND(
	((e21.Emissions_2021 -e90.Emissions_1990)/e90.Emissions_1990)*100,2) AS Percentage_Increase

FROM Emissions_1990 e90

JOIN Emissions_2021 e21
ON e90.Country = e21.Country

WHERE e90.Emissions_1990 > 0

ORDER BY Percentage_Increase DESC;


--- Top 10 countries with a significant decrease in emissions from 1990-2021---

---- Compare emissions between 1990 and 2021-----
WITH Emissions_1990 AS (
	SELECT 
		Country, 
		SUM(Emissions) AS Emissions_1990

	FROM Final_Analysis_Table
	WHERE Year = 1990
	GROUP BY Country
	),
Emissions_2021 AS (
	SELECT 
		Country, 
		SUM(Emissions) AS Emissions_2021

	FROM Final_Analysis_Table
	WHERE Year = 2021
	GROUP BY Country
	)


SELECT TOP 10
	e90.Country,
	ROUND(e90.Emissions_1990,2) AS Emissions_1990,
	ROUND(e21.Emissions_2021,2) AS Emissions_2021,
	ROUND(e90.Emissions_1990 - e21.Emissions_2021,2) AS Emission_Reduction
FROM Emissions_1990 e90

JOIN Emissions_2021 e21
ON e90.Country = e21.COUNTRY

WHERE e21.Emissions_2021 < e90.Emissions_1990

ORDER BY Emission_Reduction DESC;

