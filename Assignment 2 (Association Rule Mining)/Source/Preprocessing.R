##-------------------------------------------------------------------
## Preprocessing Program (Preprocessing.R)
## ---------------------------------------
## This program chooses a specified number of transactions (transaction.txt) 
## from the actual dataset (OnlineRetail.csv) and writes it back into an 
## output file (arm_input.csv) which is used for association rule mining  
## in the next phase. The program additionally prints the memory consumed 
## through the execution of the program.
##
## Input File/s :  OnlineRetail.csv, transaction.txt from Data folder
## Output File/s:  arm_input.csv, data_size.txt, items.txt created in  
##                 Data folder
##-------------------------------------------------------------------

preprocessing <- function(data, size){
  temp<-data[!duplicated(data[,1]),]
  temp<-temp[1:size, 1:2]
  trans <- as.data.frame(c(size, length(unique(temp$StockCode))))
  write.table(trans, file = "~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Data/data_size.txt", sep = "\n" ,row.names = FALSE, col.names = FALSE)
  ctable<-ftable(temp)
  new <- as.data.frame(ctable)
  items <- new[,2]
  items <- as.character(unique(items))
  vec <- character(0)
  for(i in 1:length(items)){
    vec[i] <- data[data$StockCode == items[i], ]$Description[1]
  }
  write.table(vec, file = "~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Data/items.txt", sep = "\n" ,row.names = FALSE, col.names = FALSE)
  final<-as.table(as.matrix(ctable))
  write.table(final, file = "~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Data/arm_input.csv", sep = "," ,row.names = FALSE, col.names = FALSE)
  rm(temp,ctable,new,trans)
}

data <- read.csv(file = "~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Data/OnlineRetail.csv", stringsAsFactors = FALSE, header = TRUE, colClasses = c(NA,NA,NA,"NULL","NULL","NULL","NULL","NULL"))
num_Trans <- read.table(file = "~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Data/size.txt", header = FALSE, sep = "\n")
data$Description[data$Description == ""] <- NA
data <- data[complete.cases(data),]
preprocessing(data, size = num_Trans[1,1])

usage <- sort(sapply(ls(), function(x){object.size(get(x))}))
usageMb <- sum(usage) / (1024*1024)
usage <- paste("Total Memory Usage in Preprocessing: ", round(usageMb, 3), " Mb", sep = "")
print(usage, quote = FALSE)
rm(usage, usageMb)


##-------------------------------------------------------------------