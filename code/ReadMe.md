#ReadMe code folder

This folder contains functions that you can use to help run flat or HKNN mapping on the Forebrain data, and then analyze the accuracy. 

Proceed in order of 00 to 04. The first function runs by subsetting the dataset into groups of 10,000 cells as we previously had issues runing large datasets at one time on HPC nodes. The function will then produce results in parts, and this is used in 01_analyze_map_results.R. 

I recommend running the mapping function by submitting a batch job on a 500G HPC node.

Be sure to double check the working directory before running these functions. 