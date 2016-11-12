##-------------------------------------------------------------------
## Preprocessing Script (Preprocessing.R)
## ---------------------------------------
## This script runs over all the 10-K reports stored as pdf in the Data
## folder and extracts the 'Consolidated Balance Sheet' for each of them
## which written to .csv files to be read and analysed in further steps.
##
## Input File/s :  *.pdf from Data folder
## Output File/s:  *.csv created in Data folder
##-------------------------------------------------------------------

setwd("~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 3 (Data Analysis)")

list.of.packages <- c("rJava", "ghit")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)){
  install.packages(new.packages)
  library(ghit)
  ghit::install_github(c("ropenscilabs/tabulizerjars", "ropenscilabs/tabulizer"), INSTALL_opts = "--no-multiarch")
} 

library("tabulizer")
library("stringr")

page <- c(44, 69, 54, 60, 66)
company <- c("apple", "cognizant", "starbucks", "facebook", "intel")

for(i in 1:5){
    path <- paste("Data/", company[i], ".pdf", sep = "")
    data <- extract_tables(path, pages = page[i])
    data <- data[[1]]
    if(i < 4){
        c1 <- data[ ,4]
        c2 <- data[ ,6]
    }
    else{
        c1 <- data[ ,3]
        c2 <- data[ ,5]
    }
	if(i == 1)
	    c3 <- c("Cash and cash equivalents", "Short-term marketable securities", "Accounts receivable", "Inventories", "Vendor non-trade receivables", "Other current assets", "Total current assets",
	            "Long-term marketable securities", "Property, plant and equipment net", "Goodwill", "Acquired intangible assets net", "Other non-current assets", "Total assets",
	            "Accounts payable", "Accrued expenses", "Deferred revenue", "Commercial paper", "Current portion of long-term debt", "Total current liabilities",
	            "Deferred revenue non-current", "Long-term debt", "Other non-current liabilities", "Total liabilities",
	            "Additional paid-in capital", "Retained earnings", "Accumulated other comprehensive income (loss)", "Total shareholders' equity", "Total liabilities and shareholders' equity")
    else if(i == 2)
        c3 <- c("Cash and cash equivalents", "Short-term marketable securities", "Accounts receivable", "Vendor non-trade receivables", "Other current assets", "Total current assets",
                "Property, plant and equipment net", "Goodwill", "Acquired intangible assets net", "Deferred income tax assets net","Other non-current assets", "Total assets",
                "Accounts payable", "Deferred revenue", "Short-term debt", "Accrued expenses", "Total current liabilities",
                "Deferred revenue non-current", "Deferred income tax liabilities", "Long-term debt", "Other non-current liabilities", "Total liabilities",
                "Common stock", "Additional paid-in capital", "Retained earnings", "Accumulated other comprehensive income (loss)", "Total shareholders' equity", "Total liabilities and shareholders' equity")
    else if(i == 3)
        c3 <- c("Cash and cash equivalents", "Short-term marketable securities", "Accounts receivable", "Inventories", "Other current assets", "Deferred tax assets", "Total current assets",
                "Long-term investments", "Equity and cost investments", "Property, plant and equipment net", "Deferred income tax net", "Other non-current assets", "Acquired intangible assets net", "Goodwill", "Total assets",
                "Accounts payable", "Accrued liabilities", "Insurance reserve",  "Stored value card liability", "Total current liabilities", "Long-term debt", "Other long term liabilities", "Total liabilities",
                "Common stock", "Additional paid-in capital", "Retained earnings", "Accumulated other comprehensive income (loss)",  "Total shareholders' equity", "Non controlling interest", "Total equity", "Total liabilities and shareholders' equity")
    else if(i == 4)
        c3 <- c("Cash and cash equivalents", "Short-term marketable securities", "Accounts receivable", "Other current assets", "Total current assets",
                "Property, plant and equipment net", "Acquired intangible assets net", "Goodwill","Other non-current assets", "Total assets",
                "Accounts payable", "Partners payable", "Accrued expenses", "Deferred revenue", "Short-term debt",  "Total current liabilities",
                "Capital lease obligations", "Other non-current liabilities", "Total liabilities",
                "Additional paid-in capital", "Accumulated other comprehensive income (loss)", "Retained earnings", "Total shareholders' equity", "Total liabilities and shareholders' equity")
    else
        c3 <- c("Cash and cash equivalents", "Short-term marketable securities", "Trading assets", "Accounts receivable", "Inventories", "Deferred tax assets", "Other current assets", "Total current assets",
                "Property, plant and equipment net", "Marketable equity securities", "Long-term investments", "Goodwill", "Acquired intangible assets net", "Other non-current assets", "Total assets",
                "Short-term debt", "Accounts payable", "Accrued expenses", "Accrued advertising",  "Deferred revenue",   "Other accured liabilities", "Total current liabilities",
                "Long-term debt", "Long-term deferred tax liabilities", "Other long-term liabilities", "Temporary equity", "Common stock", "Accumulated other comprehensive income (loss)", "Retained earnings", "Total shareholders' equity", "Total liabilities and shareholders' equity")
    c1 <- unlist(regmatches(c1, gregexpr('\\(?[0-9,.]+', c1)))
    c1 <- as.numeric(gsub('\\(', '-', gsub(',', '', c1)))
    c2 <- unlist(regmatches(c2, gregexpr('\\(?[0-9,.]+', c2)))
    c2 <- as.numeric(gsub('\\(', '-', gsub(',', '', c2)))
    c1 <- c1[complete.cases(c1)]
    c2 <- c2[complete.cases(c2)]
    if(i == 2 || i == 4){
        c1 <- c1[-1]
        c2 <- c2[-1]
    }
    data <- data.frame("Terms" = c3, "Current.Year" = c1, "Past.Year" = c2)
    path <- paste("Data/", company[i], ".csv", sep = "")
    write.csv(data, file = path, row.names = FALSE)
}

rm(c1,c2,c3,list.of.packages,new.packages, i, path, company, page, data)

##-------------------------------------------------------------------