library(dplyr)
source("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/hmapping/HKNN_util.R")
#run_mapping_HKNN <- function( query.dat, 
#                               Taxonomy="AIT10.0_mouse", prefix="", TaxFN=NA, newbuild=FALSE, 
#                               iter=100, mc.cores=7, blocksize=50000, method="cor", 
#                               topk=1, subsample_pct=0.8, top.n.genes=15, rm.clusters=NA, 
#                               flag.serial=FALSE, flag.parallel.tmp=FALSE, flag.fuzzy=FALSE)

# load the query data
load("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/ForeBrain/norm.SS.rda")

# mapping with AIT9.0_mouse  (forebrain integrated taxonomy)
mapped= run_mapping_HKNN( qdat,                     # query data
                          Taxonomy="AIT9.0_mouse",  # taxonomy
                          prefix="SS" )             # prefix for your run
save(mapped, file="mapped.ForeBrain.rda")

# mapping with AIT10.0_mouse (wholebrain 10Xv3 taxonomy)
mapped= run_mapping_HKNN( qdat,                      # query data
                          Taxonomy="AIT10.0_mouse",  # taxonomy
                          prefix="SS" )              # prefix for your run
save(mapped, file="mapped.WholeBrfain.rda")



##############################################################
# for Clare
# mapping with specific taxonomy file
library(dplyr)
source("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/hmapping/HKNN_util.R")
# load the query data
load("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/ForeBrain/norm.SS.rda")

#run subset 50,000
mapped= run_mapping_HKNN( qdat[, 1:5000],                     # query data
                          Taxonomy="AIT9.0_mouse",  # taxonomy
                          iter=20,
                          prefix="SS", top.n.genes = 5)             # prefix for your run
save(mapped, file="mapped.ForeBrain.FromALL.top5.rda")
mapped= run_mapping_HKNN( qdat[, 1:5000],                     # query data
                          Taxonomy="AIT9.0_mouse",  # taxonomy
                          iter=20,
                          prefix="SS", top.n.genes = 20)             # prefix for your run
save(mapped, file="mapped.ForeBrain.FromALL.top20.rda")
