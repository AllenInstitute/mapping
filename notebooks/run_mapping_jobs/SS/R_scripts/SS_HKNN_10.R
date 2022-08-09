#debug the SS 10 gene HKNN code: run FULL
### USER FRIENDLY NOTEBOOK TO INPUT A LARGE DATASET AND HAVE IT RUN IN SUBSETS ON THE 500 GB NODES ###

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

#enter the path to the directory you want to save results to
my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/marker_genes_HKNN_objects/SS/5_debugged"

run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, top.n.genes = 5, start = 3, end =4, MI_FN =  "FB_top5_pct0.9train.list.HANN_marker_index.rda")

#enter the path to the directory you want to save results to
my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/marker_genes_HKNN_objects/SS/10_debugged"

run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, top.n.genes = 10, start = 3, end =4, MI_FN =  "FB_top10_pct0.9train.list.HANN_marker_index.rda")

my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/marker_genes_HKNN_objects/SS/20_debugged"

run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, top.n.genes = 20, start = 3, end= 4, MI_FN =  "FB_top20_pct0.9train.list.HANN_marker_index.rda")

