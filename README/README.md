# Global Agricultural Greenhouse Gas Emissions Analysis (1990–2021)

## Project overview
This project analyzes global agricultural greenhouse gas emissions trends from 1990–2021 using SQL Server and Power BI.

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
5. Which countries showed the highest emission increase between 1990–2021?
6. Which countries showed a decrease in emissions between 1990 and 2021?

## Dashboard Features

The Power BI dashboard includes:

- KPI cards for total emissions, country count and 
- Interactive slicers for continent and year
- Emissions trend analysis (1990–2021)
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

### SQL Analysis Queries
<img width="1076" height="761" alt="sql_eda_1" src="https://github.com/user-attachments/assets/53e77d1b-5622-4592-bd20-3e1695e03b0a" />

### Dashboard Overview
<img width="1351" height="748" alt="dashboard_overview" src="https://github.com/user-attachments/assets/d7d397e6-184a-4d76-b557-07865a7487f9" />


## Author
Renuga J
