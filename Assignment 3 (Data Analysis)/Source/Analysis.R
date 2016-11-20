##-------------------------------------------------------------------
## Main Analysis Script (Analysis.R)
## ---------------------------------------
## This script reads from the previous output of Preprocessing.R 
## which stored the balance sheets as .csv files and does a financial 
## analysis on the same.
##
## Input File/s :  *.csv from Data folder
## Output File/s:  *.csv created in Data folder, 
##                 *.png created in Results folder
##-------------------------------------------------------------------

setwd("~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 3 (Data Analysis)")

# list.of.packages <- c("ggplot")
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
consolidated2015 <- merge(x = apple, y = cognizant, by = "Terms", all = TRUE)
consolidated2015 <- consolidated2015[,c(1,2,4)]
colnames(consolidated2015) <- c("Terms", "Apple", "Cognizant")
consolidated2015 <- merge(x = consolidated2015, y = starbucks, by = "Terms", all = TRUE)
consolidated2015 <- consolidated2015[,c(1,2,3,4)]
colnames(consolidated2015) <- c("Terms", "Apple", "Cognizant", "Starbucks")
consolidated2015 <- merge(x = consolidated2015, y = facebook, by = "Terms", all = TRUE)
consolidated2015 <- consolidated2015[,c(1,2,3,4,5)]
colnames(consolidated2015) <- c("Terms", "Apple", "Cognizant", "Starbucks", "Facebook")
consolidated2015 <- merge(x = consolidated2015, y = intel, by = "Terms", all = TRUE)
consolidated2015 <- consolidated2015[,c(1,2,3,4,5,6)]
colnames(consolidated2015) <- c("Terms", "Apple", "Cognizant", "Starbucks", "Facebook", "Intel")
compact2015 <- consolidated2015[complete.cases(consolidated2015),]

consolidated2014 <- merge(x = apple, y = cognizant, by = "Terms", all = TRUE)
consolidated2014 <- consolidated2014[,c(1,3,5)]
colnames(consolidated2014) <- c("Terms", "Apple", "Cognizant")
consolidated2014 <- merge(x = consolidated2014, y = starbucks, by = "Terms", all = TRUE)
consolidated2014 <- consolidated2014[,c(1,2,3,5)]
colnames(consolidated2014) <- c("Terms", "Apple", "Cognizant", "Starbucks")
consolidated2014 <- merge(x = consolidated2014, y = facebook, by = "Terms", all = TRUE)
consolidated2014 <- consolidated2014[,c(1,2,3,4,6)]
colnames(consolidated2014) <- c("Terms", "Apple", "Cognizant", "Starbucks", "Facebook")
consolidated2014 <- merge(x = consolidated2014, y = intel, by = "Terms", all = TRUE)
consolidated2014 <- consolidated2014[,c(1,2,3,4,5,7)]
colnames(consolidated2014) <- c("Terms", "Apple", "Cognizant", "Starbucks", "Facebook", "Intel")
compact2014 <- consolidated2014[complete.cases(consolidated2014),]

## Debt to Equity Ratio
##----------------------
a <- as.numeric(unlist(consolidated2015[consolidated2015$Terms == 'Total liabilities',c(2,3,4,5,6)]))
b <- as.numeric(unlist(consolidated2015[consolidated2015$Terms == 'Total shareholders\' equity',c(2,3,4,5,6)]))
de2015 <- a/b

a <- as.numeric(unlist(consolidated2014[consolidated2014$Terms == 'Total liabilities',c(2,3,4,5,6)]))
b <- as.numeric(unlist(consolidated2014[consolidated2014$Terms == 'Total shareholders\' equity',c(2,3,4,5,6)]))
de2014 <- a/b

## Current Ratio
##----------------------
a <- as.numeric(unlist(consolidated2015[consolidated2015$Terms == 'Total current assets',c(2,3,4,5,6)]))
b <- as.numeric(unlist(consolidated2015[consolidated2015$Terms == 'Total current liabilities',c(2,3,4,5,6)]))
cr2015 <- a/b

a <- as.numeric(unlist(consolidated2014[consolidated2014$Terms == 'Total current assets',c(2,3,4,5,6)]))
b <- as.numeric(unlist(consolidated2014[consolidated2014$Terms == 'Total current liabilities',c(2,3,4,5,6)]))
cr2014 <- a/b

## Gross Profit Margin
##--------------------
pr <- read.csv("Data/Operations.csv")
pr$b <- pr$a - pr$b
pr$d <- pr$c - pr$d
pr$a <- pr$b / pr$a
pr$c <- pr$d / pr$c
pr2015 <- pr$a
pr2014 <- pr$c
rm(a,b)

## Visualization
##--------------
library(ggplot2)

de1 <- data.frame("Company" = company, "DE.Ratio" = de2015)
de1$Year <- "2015"
de2 <- data.frame("Company" = company, "DE.Ratio" = de2014)
de2$Year <- "2014"
de <- rbind(de1, de2)
rm(de1, de2, de2014, de2015)
png(filename = "Results/Financial Ratios/DebttoEquityRatio.png", width = 550, height = 500, units = "px", bg = "white")
g <- ggplot(data = de, aes(Company, DE.Ratio, fill = Year))
g <- g + geom_bar(stat = "identity", position = "dodge", alpha = 0.3)
g <- g + labs(x = "Company", y = "Debt to Equity Ratio")
g <- g + ggtitle("Leverage Ratio")
print(g)
dev.off()

pr1 <- data.frame("Company" = company, "P.Ratio" = pr2015)
pr1$Year <- "2015"
pr2 <- data.frame("Company" = company, "P.Ratio" = pr2014)
pr2$Year <- "2014"
pr <- rbind(pr1, pr2)
rm(pr1, pr2, pr2014, pr2015)
png(filename = "Results/Financial Ratios/GrossProfitMargin.png", width = 550, height = 500, units = "px", bg = "white")
g <- ggplot(data = pr, aes(Company, P.Ratio, fill = Year))
g <- g + geom_bar(stat = "identity", position = "dodge", alpha = 0.3)
g <- g + labs(x = "Company", y = "Gross Profit Margin")
g <- g + ggtitle("Profitability Ratio")
print(g)
dev.off()

cr1 <- data.frame("Company" = company, "C.Ratio" = cr2015)
cr1$Year <- "2015"
cr2 <- data.frame("Company" = company, "C.Ratio" = cr2014)
cr2$Year <- "2014"
cr <- rbind(cr1, cr2)
rm(cr1, cr2, cr2014, cr2015)
png(filename = "Results/Financial Ratios/CurrentRatio.png", width = 550, height = 500, units = "px", bg = "white")
g <- ggplot(data = cr, aes(Company, C.Ratio, fill = Year))
g <- g + geom_bar(stat = "identity", position = "dodge", alpha = 0.3)
g <- g + labs(x = "Company", y = "Current Ratio")
g <- g + ggtitle("Liquidity Ratios")
print(g)
dev.off()

rm(g, de, pr, cr, company)

##-------------------------------------------------------------------