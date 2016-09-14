Big Data and Cloud Computing (Assignment 1)


KMeans Clustering
-----------------------------------------------

This module is designed for clustering a given dataset stored as roadNet-CA.txt in Data folder.


Files
-----------------------------------------------

/Source
-------

1. Preprocessing.R

Chooses a random sample of a given size (data_size.txt) from the actual dataset (roadNet-CA.txt) and
writes it back into an output file (kmeans_input.txt) which is used for clustering in the next phase.

2. Clustering.cpp

Performs the main clustering task using kMeans algorithm as given by Lloyd. Initial points are chosen 
based on the theory of polar coordinates by giving random angle values to choose points from 
throughout the space.

3. Visualization.R

Takes input as the data passed to the clustering algorithm as well as the clustering 
resuls produced in the previous phase and merges them to create a single data frame which is used to 
create a plot showing clusters in the dataset distinguished by colours.

4. Clustering_Module.sh

Serves as the driver for the whole clustering module running the preprocessing script, 
clustering algorithm and the visualization script. The program takes in the size, k value and number 
of iterations as parameters which are passed onto the respective programs accordingly.

5. Batch_Clustering_Module.sh

This program provides a batch processing variant for the clustering module. This program runs 
the preprocessing script, clustering algorithm and the visualization script with different sizes 
starting from 55000 incrementing in multiples of 10 till 5500000 which is the maximum limit 
for values of k ranging from 2 to 7 with fixed number of iterations. 

/Data
-----

1. data_size.txt

Stores the size of data points to be used for the clustering. Size is stored through the user input 
of size coming from Clustering_Module.sh. 


2. kmeans_input.txt

Stores the random sample of a given size from the actual dataset created by Preprocessing.R.

3. kmeans_output.txt

Stores the clustering output created by Clustering.cpp.

4. roadNet-CA.txt

Contains the dataset used for the assignment. The same can be found on the website:
https://snap.stanford.edu/data/roadNet-CA.html 

/Results
--------

Stores the .png files resulting from the Visualization.R script.

-----------------------------------------------
