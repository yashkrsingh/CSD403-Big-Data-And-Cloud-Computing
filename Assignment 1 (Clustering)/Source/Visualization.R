##-------------------------------------------------------------------
## Visualization Program (Visualization.R)
## ---------------------------------------
## This program takes input as the data passed to the clustering  
## algorithm as well as the clustering resuls produced in the previous  
## phase and merges them to create a single data frame which is used to 
## create a plot showing clusters in the dataset distinguished by 
## colours. The program additionally prints the memory consumed 
## through the execution of the program.
##
## Input File/s :  kmeans_input.txt, kmeans_output.txt from Data folder
## Output File/s:  result_k<clusterinput>_size<sizeinput>.png created
##				   in Results folder
##-------------------------------------------------------------------

library(ggplot2)
library(plyr)
input <- read.table(file = "~/Assignment 1 (Clustering)/Data/kmeans_input.txt")
input[,3] <- head(read.table(file = "~/Assignment 1 (Clustering)/Data/kmeans_output.txt", colClasses = 'factor'), n = nrow(input))
colnames(input) <- c('xCoordinates', 'yCoordinates', 'Clusters')
size <- read.table(file = "~/Assignment 1 (Clustering)/Data/data_size.txt", header = FALSE)

k <- levels(input$Clusters)
k <- k[length(k)]
legName <- tabulate(input$Clusters)
legName <- paste(1:length(legName), legName, sep = " : ")
input$Clusters <- mapvalues(input$Clusters, from = levels(input$Clusters), to = legName)

path <- paste("~/Assignment 1 (Clustering)/Results/result_k", k, "size", size, ".png", sep = "")
png(filename = path, width = 580, height = 580, units = "px", bg = "white")
g <- ggplot(data = input, aes(xCoordinates,yCoordinates, col = Clusters))
g <- g + geom_point()
g <- g + xlab("x-axis") + ylab("y-axis") + ggtitle("Clustered Output")
print(g)
dev.off()
usage <- sort(sapply(ls(), function(x){object.size(get(x))}))
usageMb <- sum(usage) / (1024*1024)
usage <- paste("Total Memory Usage in Visualization: ", round(usageMb, 3), " Mb", sep = "")
print(usage, quote = FALSE)
rm(k, path, g, size, usage, usageMb, legName)

##-------------------------------------------------------------------