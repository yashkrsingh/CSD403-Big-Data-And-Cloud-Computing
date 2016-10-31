##-------------------------------------------------------------------
## Driver Program (association-rule-mining.sh)
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
cd /home/manav/ARM/Results/
rm * > /dev/null 2>&1
cd /home/manav/ARM/Source/
len=0
for i in $*; do
	len=$(($len+1))	
done
if [[ $len < 3 ]]; then
	echo "incorrect arguments"
	echo "execute as : associaiton-rule-mining <args> <size> <min_sup_count> <min_conf>"
fi
if [[ $len == 3 ]]; then
	echo $1 > /home/manav/ARM/Data/size.txt
	echo $(Rscript Preprocessing.R)>/dev/null 2>&1
	echo $(g++ -std=c++11 AssociationRules.cpp)>/dev/null 2>&1 
	echo $(./a.out $2 $3)>/dev/null 2>&1
	echo $(Rscript Visualization.R)>/dev/null 2>&1
	cd /home/manav/ARM/Results/
	subl arm_freqitems.txt
	subl arm_arules.txt
	shotwell *.png
fi
if [[ $len == 4 ]]; then
	if [[ $1 == "--verbose" ]]; then
		echo $2 > /home/manav/ARM/Data/size.txt
		Rscript Preprocessing.R
		g++ -std=c++11 AssociationRules.cpp
		./a.out $3 $4
		Rscript Visualization.R
		cd /home/manav/ARM/Results/
		subl arm_freqitems.txt
		subl arm_arules.txt
		shotwell *.png
	fi
fi

##-------------------------------------------------------------------