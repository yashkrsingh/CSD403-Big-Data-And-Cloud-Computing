##-------------------------------------------------------------------
## Driver Program (run_arm.sh)
## -------------------------------------
## This program serves as the driver for the whole association rule mining
## module running the preprocessing script, apriori and rule generation  
## algorithms. The program takes in the below mentioned parameters as
## input which are passed onto the respective programs accordingly.
##
## Input :  Size of data (int) (should be <= 50000), Minimum Support 
##			Count (int), Minimum Confidence Threshold (float)
## Output:  arm_freitems.txt and arm_arules.txt created in
##			Results folder
##-------------------------------------------------------------------

#!/bin/bash
echo $1 > ../Data/size.txt
Rscript Preprocessing.R
g++ -std=c++11 ~/C++ Projects/Big Data and Cloud Computing Lab/Assignment 2 (Association Rule Mining)/Source/AssociationRules.cpp 
./a.out $2 $3

##-------------------------------------------------------------------