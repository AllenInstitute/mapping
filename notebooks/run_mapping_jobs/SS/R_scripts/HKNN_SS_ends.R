#running the ending of the SS data marker gene HKNN because I realized it was running it with default top n genes (15)


#load in the required function
source("/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/code/subset_large_mapping_altered_hknn.R")

#load in your dataset
setwd("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/ForeBrain")
load("norm.SS.rda")
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
my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/marker_genes_HKNN_objects/SS/5"

run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 30, end = 30, top.n.genes = 5, MI_FN = "FB_top5_pct0.9train.list.HANN_marker_index.rda")

my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/marker_genes_HKNN_objects/SS/10"

run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 30, end = 30, top.n.genes = 10, MI_FN = "FB_top10_pct0.9train.list.HANN_marker_index.rda")

my_path <- "/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/marker_genes_HKNN_objects/SS/20"

run_large_mapping(obj = my_data, naming = my_naming, alg = my_alg, path = my_path, run_full = FALSE, start = 30, end = 30, top.n.genes = 20, MI_FN = "FB_top20_pct0.9train.list.HANN_marker_index.rda")
