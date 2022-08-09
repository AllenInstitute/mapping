#script to run flat mapping for 3, 4 top n genes
#on v2, v3, and SS data. 

library(scrattch.hicat)
library(bigstatsr)
library(dplyr)
library(doMC)
library(foreach)

source("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/HKNN_util.R")
source("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/map_knn_k.R")

#qdat: v2 data
load("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/ForeBrain/norm.10Xv2.rda")

#"Y:\allen\programs\celltypes\workgroups\rnaseqanalysis\shiny\Taxonomies\AIT9.0_mouse\FB_top3_pct0.9train.list.HANN_marker_index.rda"
#load in top 3 train object
load("/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/Taxonomies/AIT9.0_mouse/FB_top3_pct0.9train.list.HANN_marker_index.rda)
top3.train <- train.list
rm(train.list)

flatmap.result.top3.v2 <- map_cells_knn_bs(topk=1, qdat, iter=50, top3.train$cl.dat, method="cor")
save(flatmap.result.top3.v2, file = "flatmap.result.top3.v2.rda")

load("/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/Taxonomies/AIT9.0_mouse/FB_top4_pct0.9train.list.HANN_marker_index.rda")
top4.train <- train.list
rm(train.list)

flatmap.result.top4.v2 <- map_cells_knn_bs(topk=1, qdat, iter=50, top4.train$cl.dat, method="cor")
save(flatmap.result.top4.v2, file = "flatmap.result.top4.v2.rda")

#now onto v3 data
load("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/ForeBrain/norm.10Xv3.rda")

flatmap.result.top3.v3 <- map_cells_knn_bs(topk=1, qdat, iter=50, top3.train$cl.dat, method="cor")
save(flatmap.result.top3.v3, file = "flatmap.result.top3.v3.rda")

#change to top 4 train object
flatmap.result.top4.v3 <- map_cells_knn_bs(topk=1, qdat, iter=50, top4.train$cl.dat, method="cor")
save(flatmap.result.top4.v3, file = "flatmap.result.top4.v3.rda")


#now to SS data
load("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/ForeBrain/norm.SS.rda")

flatmap.result.top3.SS <- map_cells_knn_bs(topk=1, qdat, iter=50, top3.train$cl.dat, method="cor")
save(flatmap.result.top3.SS, file = "flatmap.result.top3.SS.rda")

#change to top 4 train object
flatmap.result.top4.SS <- map_cells_knn_bs(topk=1, qdat, iter=50, top4.train$cl.dat, method="cor")
save(flatmap.result.top4.SS, file = "flatmap.result.top4.SS.rda")

#done