# Assignment 2 (Association Rule Mining)

This module is designed for finding association rules from a given dataset stored as OnlineRetail.csv 
in Data folder. The data used is a mocked up dataset created in form of a supermarket transactional database.

## Technologies Used
- R    : Used for preprocessing and visualizing data
- C++  : Used to program association rule mining algorithm
- Bash : Used as a glue language to run programs and other commands

## Requirements

- Linux environment (any flavour)
- g++ v4.9.3 or above (capable of running C++11)
- R v2.1 or above 

## Files Enclosed

### Data

- **data_size.txt**

Stores the number of transactions and the number of items.

- **size.txt**

Stores the size of data points to be used for the clustering. Size is stored through the user input 
of size coming from run_arm.sh. 

- **items.txt**

Stores the items by name.

- **arm_input.txt**

Stores the specified sample of a given size from the actual dataset created by Preprocessing.R.

- **OnlineRetail.csv**

Contains the dataset used for the assignment. 

### Results

Stores the .txt files resulting from AssociationRules.cpp and .png files resulting from Visualization.R.

### Source

- **Preprocessing.R**

Chooses a specified number of transactions coming from size.txt from the actual dataset (OnlineRetail.csv) and
writes it back into an output file (arm_input.txt) which is used for association rule mining in the next phase.

- **AssociationRules.cpp**

Performs the main mining task using Apriori algorithm and then uses a rule generation algorithm which chooses 
valid association rules based on the minimum confidence threshold.

- **Visualization.R**

Creates a visualization in form of a bar plot showing the k-frequent itemsets for the given support count.


- **run_arm.sh**

Serves as the driver for the whole association rule mining module running the preprocessing script and the
actual mining program. The program takes in the size, minimum support count value and minimum confidence threshold
as parameters which are passed onto the respective programs accordingly.

## How To Execute

- Copy the folders in the home folder
- Open terminal and execute run_arm.sh by command ./run_arm.sh <size> <min_sup_count> <min_conf>

