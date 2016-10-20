##-------------------------------------------------------------------
## Visualization Program (Visualization.R)
## ---------------------------------------
## This program takes input as the intermediate files created by main 
## AssociationRules.cpp as well as some information from numfiles.txt   
## and uses it to create a create a plot showing k-frequent itemsets
## from dataset for given support count. The program additionally
## prints the memory consumed through the execution of the program.
##
## Input File/s :  numfiles.txt from Data folder
## Output File/s:  arm_freqitems<k>.png created in Results folder
##-------------------------------------------------------------------

library(ggplot2)
input <- read.table(file = "~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Results/numfiles.txt")
size <- input[1,]
support <- input[2,]

for(i in 1:size){
  path <- paste("~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Results/arm_freqitems", i ,".txt", sep = "")
  data <- read.table(file = path)
  colnames(data) <- c("Items", "Support")
  file.remove(path)
  filestore <- paste("~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Results/arm_freqitems", i ,".png", sep = "")
  title <- paste("Frequent ", i, "-Itemset", sep = "")
  png(filename = filestore, width = 500, height = 600, units = "px", bg = "white")
  g <- ggplot(data, aes(x=Items, y = Support)) 
  g <- g + geom_bar(stat="identity") 
  g <- g + labs(x = "Items", y = "Support Count")
  g <- g + theme(axis.text.x = element_text(angle=90, hjust = 1))
  g <- g + geom_hline(yintercept = support)
  g <- g + ggtitle(title)
  g 
  print(g)
  dev.off()
}

usage <- sort(sapply(ls(), function(x){object.size(get(x))}))
usageMb <- sum(usage) / (1024*1024)
usage <- paste("Total Memory Usage in Visualization: ", round(usageMb, 3), " Mb", sep = "")
print(usage, quote = FALSE)
rm(filestore, i, support, title, input, data, path, g)

##-------------------------------------------------------------------