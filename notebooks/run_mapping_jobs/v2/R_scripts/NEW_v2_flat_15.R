#running the v3 flat genes

#load in the required function
source("/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/code/subset_large_mapping.R")

#load in your dataset
load("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/ForeBrain/norm.10Xv2.rda")
#take note of the name of your data

#enter the variable name for your dataset (no quotation marks): 
my_data <- qdat

#enter a NAME you want your data files to display for ID purposes: 
#ex: "10Xv3", "SS", "10Xv2", etc.
my_naming <- "10Xv2"

#enter the mapping algorithm you are using
#either "HKNN" or "FLAT"
my_alg <- "FLAT"

my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/control_flat_objects/v2/new_run"


run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 30, end = 30, top.n.genes = 15)
run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 0, end = 19, top.n.genes = 15)


rm(qdat)
rm(my_data)

my_naming <- "SS"
load("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/ForeBrain/norm.SS.rda")
my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/control_flat_objects/SS"
my_data <- qdat


run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 30, end = 30, top.n.genes = 15)
