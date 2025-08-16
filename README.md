# Rental Dataset Analysis

## Project Overview
This repository contains a comprehensive data analytics solution for an Airbnb rental dataset. The project involves:
- Loading the dataset into a SQL Server database.
- Designing a dimensional model with fact and dimension tables.
- Importing the data into Power BI for analysis.
- Creating interactive dashboards with KPIs and visualizations to analyze pricing, host activity, reviews, availability, and geographic distribution.

## Features
- **Data Loading**: Imports rental dataset from Excel into SQL Server with data quality checks.
- **Dimensional Modeling**: Includes dimension tables (e.g., Hosts, Location, Property Details, Booking Policies) and a fact table for metrics like price, reviews, and availability.
- **Power BI Dashboards**: Visualizations and KPIs for:
  - **Pricing Analysis**: Average price by room type, price distribution by neighborhood, highest/lowest prices.
  - **Host Analysis**: Listings per host, verified vs. non-verified hosts, top hosts by listings.
  - **Reviews & Ratings**: Average review rates by neighborhood, total reviews, review trends over time, and review frequency by cancellation policy.
  - **Availability & Booking**: Total availability days, average minimum nights, percentage of instant bookable listings.
  - **Geographic Analysis**: Map visualizations by location (latitude/longitude), listings by neighborhood.
  - **Other Insights**: Correlations between price and reviews, impact of construction year, service fee analysis.
- **Summary Report**: Highlights key findings from the analysis.

## Technologies Used
- SQL Server
- Power BI
- Excel

## Repository Structure
- `/sql`: SQL scripts for creating the dimensional model and loading data.
- `/powerbi`: Power BI report file (.pbix) with dashboards and visualizations.
- `/docs`: Summary report with key findings.
- `/data`: Sample dataset schema.

## Getting Started
1. **Setup SQL Server**:
   - Run the SQL scripts in `/sql` to create the database and dimensional model.
   - Import the Excel dataset into SQL Server.
2. **Power BI Setup**:
   - Open the `.pbix` file in Power BI Desktop.
   - Connect to the SQL Server database to import the dimensional model.
   - Explore the dashboards for insights.
3. **Review Findings**:
   - Check the summary report in `/docs` for key insights from the analysis.

## Prerequisites
- SQL Server 2022
- Power BI Desktop
- Excel

## Future Enhancements
- Add advanced DAX formulas for custom KPIs.
- Incorporate machine learning models for predictive analytics.
- Expand geographic analysis with clustering techniques.
