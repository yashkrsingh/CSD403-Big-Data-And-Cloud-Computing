##-------------------------------------------------------------------
## Visualization Script (Visualization.R)
## ---------------------------------------
## This script reads from the previous output of Preprocessing.R 
## which stored the balance sheets as .csv files and plots exploratory 
## graphs on the balance sheet data.
##
## Input File/s :  *.csv from Data folder
## Output File/s:  *.png created in Results folder
##-------------------------------------------------------------------

setwd("~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 3 (Data Analysis)")

list.of.packages <- c("plotly")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

apple <- read.csv(file = "Data/apple.csv")
cognizant <- read.csv(file = "Data/cognizant.csv")
facebook <- read.csv(file = "Data/facebook.csv")
intel <- read.csv(file = "Data/intel.csv")
starbucks <- read.csv(file = "Data/starbucks.csv")

## Plots for Apple Inc
##--------------------

library(plotly)
data1 <- apple[1:6, ]
data1 <- rbind(data1, apple[8:12, ])
data2 <- apple[14:22, ]
data2 <- rbind(data2, apple[24:27, ])
p <- plot_ly() %>%
    add_pie(data = data1, labels = ~Terms, values = ~FY2015,
            name = "Assets", domain = list(x = c(0, 0.4), y = c(0.2, 1))) %>%
    add_pie(data = data1, labels = ~Terms, values = ~FY2014,
            name = "Assets", domain = list(x = c(0.6, 1), y = c(0.2, 1))) %>%
    layout(title = "Distribution of Assets for Apple Inc in FY2015 and FY2014", showlegend = TRUE,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

p <- plot_ly() %>%
    add_pie(data = data2, labels = ~Terms, values = ~FY2015,
            name = "Liabilities", domain = list(x = c(0, 0.4), y = c(0.2, 1))) %>%
    add_pie(data = data2, labels = ~Terms, values = ~FY2014,
            name = "Liabilities", domain = list(x = c(0.6, 1), y = c(0.2, 1))) %>%
    layout(title = "Distribution of Liabilities for Apple Inc in FY2015 and FY2014", showlegend = TRUE,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

## Plots for Cognizant
##--------------------

data1 <- cognizant[1:5, ]
data1 <- rbind(data1, cognizant[7:11, ])
data2 <- cognizant[13:21, ]
data2 <- rbind(data2, cognizant[23:28, ])
p <- plot_ly() %>%
    add_pie(data = data1, labels = ~Terms, values = ~FY2015,
            name = "Assets", domain = list(x = c(0, 0.4), y = c(0.2, 1))) %>%
    add_pie(data = data1, labels = ~Terms, values = ~FY2014,
            name = "Assets", domain = list(x = c(0.6, 1), y = c(0.2, 1))) %>%
    layout(title = "Distribution of Assets for Cognizant in FY2015 and FY2014", showlegend = TRUE,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

p <- plot_ly() %>%
    add_pie(data = data2, labels = ~Terms, values = ~FY2015,
            name = "Liabilities", domain = list(x = c(0, 0.4), y = c(0.2, 1))) %>%
    add_pie(data = data2, labels = ~Terms, values = ~FY2014,
            name = "Liabilities", domain = list(x = c(0.6, 1), y = c(0.2, 1))) %>%
    layout(title = "Distribution of Liabilities for Cognizant in FY2015 and FY2014", showlegend = TRUE,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

## Plots for Facebook Inc
##-----------------------

data1 <- facebook[1:4, ]
data1 <- rbind(data1, facebook[6:9, ])
data2 <- facebook[11:18, ]
data2 <- rbind(data2, facebook[20:22, ])
p <- plot_ly() %>%
    add_pie(data = data1, labels = ~Terms, values = ~FY2015,
            name = "Assets", domain = list(x = c(0, 0.4), y = c(0.2, 1))) %>%
    add_pie(data = data1, labels = ~Terms, values = ~FY2014,
            name = "Assets", domain = list(x = c(0.6, 1), y = c(0.2, 1))) %>%
    layout(title = "Distribution of Assets for Facebook Inc in FY2015 and FY2014", showlegend = TRUE,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

p <- plot_ly() %>%
    add_pie(data = data2, labels = ~Terms, values = ~FY2015,
            name = "Liabilities", domain = list(x = c(0, 0.4), y = c(0.2, 1))) %>%
    add_pie(data = data2, labels = ~Terms, values = ~FY2014,
            name = "Liabilities", domain = list(x = c(0.6, 1), y = c(0.2, 1))) %>%
    layout(title = "Distribution of Liabilities for Facebook Inc in FY2015 and FY2014", showlegend = TRUE,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

## Plots for Intel Corp
##---------------------

data1 <- intel[1:7, ]
data1 <- rbind(data1, intel[9:14, ])
data2 <- intel[16:21, ]
data2 <- rbind(data2, intel[23:30, ])
p <- plot_ly() %>%
    add_pie(data = data1, labels = ~Terms, values = ~FY2015,
            name = "Assets", domain = list(x = c(0, 0.4), y = c(0.2, 1))) %>%
    add_pie(data = data1, labels = ~Terms, values = ~FY2014,
            name = "Assets", domain = list(x = c(0.6, 1), y = c(0.2, 1))) %>%
    layout(title = "Distribution of Assets for Intel Corp in FY2015 and FY2014", showlegend = TRUE,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

p <- plot_ly() %>%
    add_pie(data = data2, labels = ~Terms, values = ~FY2015,
            name = "Liabilities", domain = list(x = c(0, 0.4), y = c(0.2, 1))) %>%
    add_pie(data = data2, labels = ~Terms, values = ~FY2014,
            name = "Liabilities", domain = list(x = c(0.6, 1), y = c(0.2, 1))) %>%
    layout(title = "Distribution of Liabilities for Intel Corp in FY2015 and FY2014", showlegend = TRUE,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

## Plots for Starbucks
##--------------------

data1 <- starbucks[1:6, ]
data1 <- rbind(data1, starbucks[8:14, ])
data2 <- starbucks[16:22, ]
data2 <- rbind(data2, starbucks[24:30, ])
p <- plot_ly() %>%
    add_pie(data = data1, labels = ~Terms, values = ~FY2015,
            name = "Assets", domain = list(x = c(0, 0.4), y = c(0.2, 1))) %>%
    add_pie(data = data1, labels = ~Terms, values = ~FY2014,
            name = "Assets", domain = list(x = c(0.6, 1), y = c(0.2, 1))) %>%
    layout(title = "Distribution of Assets for Starbucks in FY2015 and FY2014", showlegend = TRUE,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

p <- plot_ly() %>%
    add_pie(data = data2, labels = ~Terms, values = ~FY2015,
            name = "Liabilities", domain = list(x = c(0, 0.4), y = c(0.2, 1))) %>%
    add_pie(data = data2, labels = ~Terms, values = ~FY2014,
            name = "Liabilities", domain = list(x = c(0.6, 1), y = c(0.2, 1))) %>%
    layout(title = "Distribution of Liabilities for Starbucks in FY2015 and FY2014", showlegend = TRUE,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

rm(data1, data2, new.packages, list.of.packages, p)

##-------------------------------------------------------------------
