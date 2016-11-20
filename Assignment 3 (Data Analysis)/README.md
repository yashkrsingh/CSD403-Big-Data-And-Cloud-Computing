# Assignment 3 (Data Analysis)

This module is designed for analysis of various financial statements in form of 10-K filings. The files are not 
included in the submission. The data used can be found [here](www.sec.gov).

## Technologies Used

- R : Used for preprocessing, visualization and analysis of data

## Requirements

- R v3.3.2
- JDK should be installed on the machine
- 'rJava', 'tabulizer', 'ggplot2', 'plotly', 'dplyr', 'tidyr' packages should be installed 

## Files Enclosed

### Data

10-K filings for Apple, Facebook, Intel, Starbucks and Cognizant are used as the source of data.

### Results

Stores the plots saved as .png files from Analysis.R and Visualization.R

### Source

- **Preprocessing.R**

For each .pdf 10-K report, this script extracts the consolidated balance sheet and produces a clean .csv file
saved in the same folder for further analysis.

- **Visualization.R**

This script produces exploratory plots about the asset and liability distribution of the various companies to 
manually see any interesting pattern that might exist.

- **Analysis.R**

Analysis of extracted balance sheets is done by calculating selected financial ratios to judge the company's
current financial standings as compared to the others. Plots for the same are also generated.

## How To Execute

- Copy the folders in the home folder
- Open R terminal and source the R scripts one by one keeping the logical order of preprocessing, visualization and analysis.

