#data exploration: hammond et al microglia
ClareUx4Lib <- "//allen/program/celltypes/rnaseqanalysis/clare_morris/R_tools/ux4_libs/"


# install the R anndata package
install.packages("anndata")


library(anndata)


marques_data_dir <- "/allen/programs/celltypes/workgroups/mct-t200/Cindy_analysis/Projects/TH/Ext_data_mapping/Marques_data/"
setwd(marques_data_dir)

load("/allen/programs/celltypes/workgroups/mct-t200/Cindy_analysis/Projects/TH/Ext_data_mapping/Marques_data/marques.RData")

#load in our data as the query obj: 

setwd("/allen/programs/celltypes/workgroups/rnaseqanalysis/Kelly/Aging_RNA_16roi_V3/data_oligo-opc")


source("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/map_knn.R")



source("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/HKNN_util.R")


train.list.opc <- build_train_index_bs(cl.dat.opc, iter = 100)
map.result.opc <- map_cells_knn_bs(test.dat = test_mat, iter = 100, cl.dat = cl.dat.opc, train.index.bs = train.list.opc)

save(map.result.opc, file = "flatmap_15_0.9_opc.rda")


#now, match cell ids with sample names. 


## Annotations
head(sample.name.conversion)
head(new.anno[,c("Sample_title", "inferred_cell_type")])
head(colnames(cpm.data2))
head((sample.name.conversion$Sample_title))
length(intersect(make.names(sample.name.conversion$Sample_title), colnames(cpm.data2)))

DF1 = map.result.opc_5[["best.map.df"]]
DF2 = new.anno[c("Sample.Name","Sample_title","inferred_cell_type")]
DF1$inferred_cell_type = DF2$inferred_cell_type[match(DF1$sample_id,DF2$Sample_title)]
DF1$Sample.Name = DF2$Sample.Name[match(DF1$sample_id,DF2$Sample_title)]


cluster_v_cellnames <- as.data.frame.matrix(table(DF1$inferred_cell_type,DF1$best.cl))

# plot graphs
library(ggplot2)



marq_colors <- c("grey",
                 "#67c53d","#f1d120","#175019","#7c7bbf","#9b5a5e","#6dbe9e",
                 "#2b7179","#27256e","#95c943","#13161d","#dc51ae","#ea1f20","#ffc330")


DF1 <- DF1[DF1$inferred_cell_type ==c("COP", "MFOL1", "MFOL2", "MOL1", "MOL2", "MOL3",
                                      "MOL4", "MOL5", "MOL6", "NFOL1", "NFOL2", "OPC", "PPR"),]

group = readRDS("/allen/programs/celltypes/workgroups/rnaseqanalysis/Kelly/Aging_RNA_16roi_V3/data_oligo-opc/group_labels.rds")
group$cl = as.character(group$cl)
DF1$cl = DF1$best.cl
DF1 = left_join(DF1, group, by = "cl")


na.omit(DF1[DF1$best.cl %in% as.character(cl.keep),]) %>%
  ggplot()+       # reference to data
  geom_bar(                 # geometry - a shape
    aes(x= best.cl,   # aesthetics - x, y, and color values
        fill=inferred_cell_type),
    position = "fill"
  ) + scale_fill_manual(values = marq_colors) +
  xlab("Mapped cluster")+
  ylab("Proportion of cells") +
  theme_classic()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  facet_wrap(~group.name, scales = "free_x", ncol = 1)

saveRDS(DF1, file = "data_for_ggplot.RDS")



#remove clusters that don't have a group name from cl.dat.opc: 


high_quality_clusters <- group$cl
cl.dat.opc_20 <- cl.dat.opc_20gene[,as.character(cl.keep)]
cl.dat.opc_5 <- cl.dat.opc_5gene[,as.character(cl.keep)]

save(cl.dat.opc_20, file = "cl.dat.opc20_filtered.RDS")

#then rerun mapping function 

train.list.opc <- build_train_index_bs(cl.dat.opc, iter = 100)
map.result.opc <- map_cells_knn_bs(test.dat = test_mat, iter = 100, cl.dat = cl.dat.opc, train.index.bs = train.list.opc)

save(map.result.opc, file = "FILTERED_flatmap_15_0.9_opc.rda")



#run using only 5 gene tops
train.list.opc <- build_train_index_bs(cl.dat.opc_5, iter = 100, sample.markers.prop = 0.9)
map.result.opc <- map_cells_knn_bs(test.dat = cpm.data, iter = 100, cl.dat = cl.dat.opc_5, train.index.bs = train.list.opc)

save(map.result.opc, file = "REALFILTERED_flatmap_5_0.9_opc.rda")


#run using only 20 gene tops
train.list.opc_20 <- build_train_index_bs(cl.dat.opc_20, iter = 100, sample.markers.prop = 0.9)
map.result.opc_20 <- map_cells_knn_bs(test.dat = cpm.data, iter = 100, cl.dat = cl.dat.opc_20, train.index.bs = train.list.opc_20)

save(map.result.opc_20, file = "REALFILTERED_flatmap_20_0.9_opc.rda")




#DF1_naomit has top 5 gene list scoring

oligo_cls <- unique(top5_obj$best.cl)

for(i in 1:length(oligo_cls)){
  max.celltype <- which.max(table(top5_obj$inferred_cell_type[top5_obj$best.cl == oligo_cls[i]]))
  print(paste0(names(max.celltype), " is the max celltype for cluster ",oligo_cls[i]))
}

