# Global Agricultural Greenhouse Gas Emissions Analysis (1991–2021)

## Project overview
This project analyzes global agricultural greenhouse gas emissions trends from 1991–2021 using SQL Server and Power BI.

The goal of this project was to clean and transform raw emissions data into an analysis-ready dataset and build an interactive dashboard to identify major trends, top contributing countries, greenhouse gas distributions and continent-wise emission pattern. 

## Objectives
The project focuses on:

- Emission trends over time
- Major greenhouse gas contributors
- Continent-wise emission patterns
- Top agricultural emitting countries
- Comparative analysis across regions

## Tools & Technologies
- SQL Server (SSMS)
- Power BI
- Excel

## Data Cleaning & Transformation
The raw data contained inconsistent country names, obsolete regions and missed continent mappings. I used the following steps to clean the data using SSMS. 

- Standardized country names using CASE statements
- Removed invalid and obsolete regions
- Mapped countries to continents using reference tables
- Categorized greenhouse gases into Carbon dioxide (CO2), Methane (CH4), and Nitrous oxide (N2O)
- Built a final analysis-ready table for further analysis and dashboard creation

## Exploratory Data Analysis (EDA)

SQL analysis was performed to identify:

1. How have agricultural greenhouse gas emissions changed over time?
2. Which continents contribute the highest emissions?
3. Which greenhouse gas contributes the most?
4. Which countries were the top emitters in 2021?
5. Which countries showed the highest emission increase between 1991–2021?
6. Which countries showed a decrease in emissions between 1991 and 2021?

## Dashboard Features

The Power BI dashboard includes:

- KPI cards for total emissions, country count and 
- Interactive slicers for continent and year
- Emissions trend analysis (1991–2021)
- Greenhouse gas contribution breakdown
- Continent-wise emissions comparison
- Top agricultural emitting countries visualization

## Key Insights
- Carbon dioxide accounted for the largest share of agricultural emissions globally.
- Asia recorded the highest cumulative agricultural emissions.
- Brazil, China, and Indonesia were among the top emitters in 2021.
- Global agricultural emissions showed fluctuations but remained consistently high across decades.

## Project Screenshots

### SQL Data Cleaning
<img width="1427" height="833" alt="sql_datacleaning_casewhen" src="https://github.com/user-attachments/assets/45be255e-906a-4806-89af-19f000a84373" />
<img width="781" height="813" alt="sql_finaltableprep" src="https://github.com/user-attachments/assets/fd766987-5b98-4724-97a6-0536dc54076e" />

### SQL Analysis Queries
<img width="1076" height="761" alt="sql_eda_1" src="https://github.com/user-attachments/assets/53e77d1b-5622-4592-bd20-3e1695e03b0a" />
<img width="1118" height="808" alt="sql_eda_2" src="https://github.com/user-attachments/assets/6f4d5e43-3b2a-43d2-9c01-78cea65fe832" />

### Dashboard Overview
<img width="1347" height="743" alt="dashboard_overview" src="https://github.com/user-attachments/assets/a080315e-cf7f-47bc-85e7-0748726cc7b7" />
<img width="1347" height="751" alt="dashboard_filtered_view" src="https://github.com/user-attachments/assets/21bf5a0e-ce8c-49ef-9097-36ad475953fc" />
<img width="720" height="654" alt="top_10_emitters_2021" src="https://github.com/user-attachments/assets/bb727499-32dc-45b4-85e6-aa9b0c6a5300" />

## Author
Renuga J
