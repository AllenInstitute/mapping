#flat mapping: v3 data 
#why
#running part 7 and onwards

### USER FRIENDLY NOTEBOOK TO INPUT A LARGE DATASET AND HAVE IT RUN IN SUBSETS ON THE 500 GB NODES ###

#this edition: run the v3 flat map data with default (15 genes)

#load in the required function
source("/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/code/subset_large_mapping.R")

#load in your dataset
setwd("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/ForeBrain")
load("norm.10Xv3.rda")
#take note of the name of your data

#enter the variable name for your dataset (no quotation marks): 
my_data <- qdat

#enter a NAME you want your data files to display for ID purposes: 
#ex: "10Xv3", "SS", "10Xv2", etc.
my_naming <- "10Xv3"

#enter the mapping algorithm you are using
#either "HKNN" or "FLAT"
my_alg <- "FLAT"

#enter the path to the directory you want to save results to
my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/control_flat_objects/v3"

#run flat control function
run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 29, end = 29)


