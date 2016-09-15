##-------------------------------------------------------------------
## Preprocessing Program (Preprocessing.R)
## ---------------------------------------
## This program chooses a random sample of a given size (data_size.txt) 
## from the actual dataset (roadNet-CA.txt) and writes it back into an 
## output file (kmeans_input.txt) which is used for clustering in the 
## next phase. The program additionally prints the memory consumed 
## through the execution of the program.
##
## Input File/s :  roadNet-CA.txt, data_size.txt from Data folder
## Output File/s:  kmeans_input.txt created in Data folder
##-------------------------------------------------------------------

dataPreprocessing <- function(data, size){
  tf <- sample(c(TRUE, FALSE), nrow(data), replace = TRUE, prob = c((size/nrow(data)), 1 - (size/nrow(data))))
  data[,3] <- tf
  sub <- subset(data, data$V3 == TRUE)
  sub <- sub[,c(1,2)]
  write.table(sub, file = "~/Assignment 1 (Clustering)/Data/kmeans_input.txt", col.names = FALSE, row.names = FALSE)
}

data <- read.table(file = "~/Assignment 1 (Clustering)/Data/roadNet-CA.txt")
data_size <- read.table(file = "~/Assignment 1 (Clustering)/Data/data_size.txt", header = FALSE)
dataPreprocessing(data, data_size)
usage <- sort(sapply(ls(), function(x){object.size(get(x))}))
usageMb <- sum(usage) / (1024*1024)
usage <- paste("Total Memory Usage in Preprocessing: ", round(usageMb, 3), " Mb", sep = "")
print(usage, quote = FALSE)
rm(usage, usageMb)

##-------------------------------------------------------------------