# Assignment 4 (Word Frequency Using MapReduce)

This module is designed for counting the frequency of words present in a very large document using
MapReduce programming model. The data used can be found [here](http://www.gutenberg.org/ebooks/1661).

## Technologies Used

- R    : Used for visualization of results
- Java : Used for MapReduce task

## Requirements

- R v3.3.2
- JDK should be installed on the machine
- 'ggplot2' package should be installed 

## Files Enclosed

### Data

'The Adventures of Sherlock Holmes' has been used for this MapReduce Word Frequency task.

### Results

Stores the visualization of results saved as results.png coming from Visualization.R

### Source

- **Main.java**

This java code is the main driver class. It handles the data flow and calls sub modules to manage the MapReduce job.

- **Mapper.java**

This java code gets data as key-value pairs as input and utilises HashMaps to maintain the wordcount of the set of 
words passed into the mapper by the main class. It uses thread libraries provided by Java to run multiple instances
of similar type of classes concurrently so as to emulate Mapper classes from the Hadoop systems.

- **Reducer.java**

This java code takes HashMaps input into it by all the mapper classes and creates a common key set of words, then it 
utilises TreeMap (which is a variation of HashMap) to maintain the fianl word count as all the HashMaps are merged.

- **MapReduce.java**

This java code provides utility functions to divide the large document stored in the Data folder into 10 chunks 
where key value pairs from each chunk are then sent to a mapper which is run on separate threads executing in 
parallel. All the intermediate key value pairs are then sent to a single reducer to output final results and 
store it as output.txt in Results folder.

- **Visualization.R**

This script produces visualizations about the results obtained from MapReduce.java in form of bar plots which are
stored as results.png in the Results folder.

- **run_mapred.sh**

This script acts as the overall driver for the whole module as it collectively runs each and every program file accordingly
and opens up the final visualization and results.


## How To Execute

- Copy the folders in the home folder
- Run run_mapred.sh

