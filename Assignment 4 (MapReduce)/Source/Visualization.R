##-------------------------------------------------------------------
## Visualization Program (Visualization.R)
## ---------------------------------------
## This program takes input as the intermediate files created by main 
## MapReduce.java and uses it to create visualizations showing 
## frequency of words from dataset. The program additionally
## prints the memory consumed through the execution of the program.
##
## Input File/s :  output.txt from Data folder
## Output File/s:  results.png created in Results folder
##-------------------------------------------------------------------

setwd("~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 4 (MapReduce)")
library(ggplot2)
input <- read.table(file = "Results/output.txt", sep = ":")
colnames(input) <- c("Words", "Frequency")
input <- input[order(input$Frequency, decreasing = TRUE),]
rownames(input) <- 1:nrow(input)
data <- head(input, 20)

png(filename = "Results/results.png", width = 500, height = 600, units = "px", bg = "white")
## group.colors <- c("#599ad3", "#f9a65a", "#9e66ab", "#cd7058", "#727272")
## g <- ggplot(data, aes(x = Words, y = Frequency, fill = Color)) 
g <- ggplot(data, aes(x = Words, y = Frequency))
g <- g + geom_bar(stat="identity", alpha = 0.8) 
g <- g + labs(x = "Words", y = "Frequency")
g <- g + theme(axis.text.x = element_text(angle=90, hjust = 1))
g <- g + ggtitle("Top 10 Common Words")
g <- g + scale_fill_manual(values = group.colors)
print(g)
dev.off()

usage <- sort(sapply(ls(), function(x){object.size(get(x))}))
usageMb <- sum(usage) / (1024*1024)
usage <- paste("Total Memory Usage in Visualization: ", round(usageMb, 3), " Mb", sep = "")
print(usage, quote = FALSE)
rm(input, data, g)

##-------------------------------------------------------------------