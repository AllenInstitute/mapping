### USER FRIENDLY NOTEBOOK TO INPUT A LARGE DATASET AND HAVE IT RUN IN SUBSETS ON THE 500 GB NODES ###


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
my_alg <- "HKNN"

#enter the path to the directory you want to save results to
my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/Batch_mapping_jobs"

#if desired, enter the size of each subset; default is 10,000 cells per iteration
#10,000 cells per iteration can run on the small 500GB nodes
my_sub_size <- 10000

#if desired, enter the number of genes you want to use to identify each cluster
#default is 15
my_top.n.genes <- 15

#run function

run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, 
	sub_size = my_sub_size, top.n.genes = my_top.n.genes)
