##-------------------------------------------------------------------
## Main Analysis Script (Analysis.R)
## ---------------------------------------
## This script reads from the previous output of Preprocessing.R 
## which stored the balance sheets as .csv files and does a financial 
## analysis on the same.
##
## Input File/s :  *.csv from Data folder
## Output File/s:  *.csv created in Data folder
##-------------------------------------------------------------------

setwd("~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 3 (Data Analysis)")

# list.of.packages <- c("ggplot", "dplyr", "tidyr")
# new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
# if(length(new.packages)) install.packages(new.packages)

apple <- read.csv(file = "Data/apple.csv")
cognizant <- read.csv(file = "Data/cognizant.csv")
facebook <- read.csv(file = "Data/facebook.csv")
intel <- read.csv(file = "Data/intel.csv")
starbucks <- read.csv(file = "Data/starbucks.csv")

company <- c("Apple", "Cognizant", "Starbucks", "Facebook", "Intel")

## Minor Adjustments
##------------------
intel$Terms <- as.character(intel$Terms)
intel <- rbind(intel, c("Total liabilities", (intel[22,2] + intel[23,2] + intel[24,2] + intel[25,2]), (intel[22,3] + intel[23,3] + intel[24,3] + intel[25,3])))

## Merging Balance Sheets 
##-----------------------
consolidated <- merge(x = apple, y = cognizant, by = "Terms", all = TRUE)
consolidated <- consolidated[,c(1,2,4)]
colnames(consolidated) <- c("Terms", "Apple", "Cognizant")
consolidated <- merge(x = consolidated, y = starbucks, by = "Terms", all = TRUE)
consolidated <- consolidated[,c(1,2,3,4)]
colnames(consolidated) <- c("Terms", "Apple", "Cognizant", "Starbucks")
consolidated <- merge(x = consolidated, y = facebook, by = "Terms", all = TRUE)
consolidated <- consolidated[,c(1,2,3,4,5)]
colnames(consolidated) <- c("Terms", "Apple", "Cognizant", "Starbucks", "Facebook")
consolidated <- merge(x = consolidated, y = intel, by = "Terms", all = TRUE)
consolidated <- consolidated[,c(1,2,3,4,5,6)]
colnames(consolidated) <- c("Terms", "Apple", "Cognizant", "Starbucks", "Facebook", "Intel")
compact <- consolidated[complete.cases(consolidated),]

## Working Capital Ratio
##----------------------
a <- as.numeric(unlist(consolidated[consolidated$Terms == 'Total current assets',c(2,3,4,5,6)]))
b <- as.numeric(unlist(consolidated[consolidated$Terms == 'Total current liabilities',c(2,3,4,5,6)]))
wcr <- a/b

## Quick Ratio
##----------------------
a <- as.numeric(unlist(consolidated[consolidated$Terms == 'Total current assets',c(2,3,4,5,6)]))
b <- as.numeric(unlist(consolidated[consolidated$Terms == 'Total current liabilities',c(2,3,4,5,6)]))
c <- as.numeric(unlist(consolidated[consolidated$Terms == 'Inventories',c(2,3,4,5,6)]))
c[which(is.na(c))] <- 0
qr <- (a-c)/b
rm(a,b,c)

##-------------------------------------------------------------------