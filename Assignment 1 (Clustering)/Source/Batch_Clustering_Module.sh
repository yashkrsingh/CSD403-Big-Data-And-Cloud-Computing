##-------------------------------------------------------------------
## Additional Driver Program (Batch_Clustering_Module.sh)
## ------------------------------------------------------
## This program provides a batch processing variant for the clustering
## module. This program runs the preprocessing script, clustering algorithm 
## and the visualization script with different sizes starting from 55000 
## incrementing in multiples of 10 till 5500000 which is the maximum limit
## for values of k ranging from 2 to 7 with fixed number of iterations. 
##
## Input :  No input
## Output:  result_k<clusterinput>_size<sizeinput>.png created in
##			Results folder
##-------------------------------------------------------------------

#!/bin/bash
for (( k = 2; k < 7; k++ )); do
	size=55000
	iter=5
	for (( i = 0; i < 3; i++ )); do
		start=$(date + %s)
		echo $size > ~/Assignment 1(Clustering)/Data/data_size.txt
		echo 'Preprocessing Data'
		Rscript Preprocessing.R
		echo 'Compiling Clutering.cpp'
		g++ -std=c++11 Clustering.cpp
		echo 'Running Clustering.cpp'
		./a.out $k $iter
		echo 'Visualizing Clusters'
		Rscript Visualization.R | grep "Total Memory"
		end=$(date + %s)
		runtime=$((end - start))
		echo "Runtime : $runtime sec"
		$size=((size*10))
	done
done

##-------------------------------------------------------------------