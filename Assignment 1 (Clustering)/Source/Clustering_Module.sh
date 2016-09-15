##-------------------------------------------------------------------
## Driver Program (Clustering_Module.sh)
## -------------------------------------
## This program serves as the driver for the whole clustering module
## running the preprocessing script, clustering algorithm and the 
## visualization script. The program takes in the below mentioned 
## parameters as input which are passed onto the respective programs
## accordingly.
##
## Input :  Size of data (int) (should be <= 5500000), Number of 
##			clusters (int), Number of iterations for kMeans (int)
## Output:  result_k<clusterinput>_size<sizeinput>.png created in
##			Results folder
##-------------------------------------------------------------------

#!/bin/bash
echo "Enter sample size :"
read size
echo "Enter number of clusters :"
read k
echo "Enter number of iterations :"
read iter
start=$(date + %s)
echo $size > ~/KMeans_c++/Data/data_size.txt
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
echo "Total Runtime : $runtime sec"

##-------------------------------------------------------------------