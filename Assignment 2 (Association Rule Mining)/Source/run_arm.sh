##-------------------------------------------------------------------
## Driver Program (run_arm.sh)
## -------------------------------------
## This program serves as the driver for the whole association rule mining
## module running the preprocessing script, apriori and rule generation  
## algorithms. The program takes in the below mentioned parameters as
## input which are passed onto the respective programs accordingly.
##
## Input :  Size of data (int) (should be <= 100), Minimum Support 
##			Count (int), Minimum Confidence Threshold (float)
## Output:  arm_freitems.txt, arm_arules.txt and barplots created in
##			Results folder
##-------------------------------------------------------------------

#!/bin/bash
cd ../Results/
rm * > /dev/null
cd ../Source/
echo $1 > ../Data/size.txt
Rscript Preprocessing.R
g++ -std=c++11 AssociationRules.cpp 
./a.out $2 $3
Rscript Visualization.R
##-------------------------------------------------------------------