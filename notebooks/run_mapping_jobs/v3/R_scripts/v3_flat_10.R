#running the v3 flat genes

#load in the required function
source("/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/code/subset_large_mapping.R")

#load in your dataset
load("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/ForeBrain/norm.10Xv3.rda")
#take note of the name of your data

#enter the variable name for your dataset (no quotation marks): 
my_data <- qdat

#enter a NAME you want your data files to display for ID purposes: 
#ex: "10Xv3", "SS", "10Xv2", etc.
my_naming <- "10Xv3"

#enter the mapping algorithm you are using
#either "HKNN" or "FLAT"
my_alg <- "FLAT"


my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/marker_genes_flat_objects/v3/5_debugged"

run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 30, end = 31, top.n.genes = 5)


my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/marker_genes_flat_objects/v3/10_debugged"

run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 30, end = 31, top.n.genes = 10)
run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 1, end = 26, top.n.genes = 10)

my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/marker_genes_flat_objects/v3/20_debugged"

run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 30, end = 31, top.n.genes = 20)
run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 1, end = 26, top.n.genes = 20)