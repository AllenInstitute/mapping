#running the odd jobs, typically endings, that got missed by the sbatch scripts. 

#load in the required function
source("/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/code/subset_large_mapping.R")

#load in your dataset
load("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/ForeBrain/norm.SS.rda")
#take note of the name of your data

#enter the variable name for your dataset (no quotation marks): 
my_data <- qdat

#enter a NAME you want your data files to display for ID purposes: 
#ex: "10Xv3", "SS", "10Xv2", etc.
my_naming <- "SS"

#enter the mapping algorithm you are using
#either "HKNN" or "FLAT"
my_alg <- "HKNN"

my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/marker_genes_HKNN_objects/SS/10"

run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 16, end = 16, top.n.genes = 10)

my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/marker_genes_HKNN_objects/SS/50"

run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 16, end = 16, top.n.genes = 50)

