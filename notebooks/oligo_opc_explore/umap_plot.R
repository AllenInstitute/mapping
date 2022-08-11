#refer to Kelly's folder on oligo-opc data for more information and r objects:

#path: "/allen/programs/celltypes/workgroups/rnaseqanalysis/Kelly/Aging_RNA_16roi_V3/data_oligo-opc"

library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(scrattch.hicat)

setwd("/allen/programs/celltypes/workgroups/rnaseqanalysis/Kelly/Aging_RNA_16roi_V3///")

## set io paths
ipath = "./data_oligo-opc//"
opath = "./data_oligo-opc//"
# uniqueid = "2022-08-01"
umap.fn = "umap_2d_k20-d0.5_2022-08-01.csv"

################################
## Load UMAP
################################
## My data
umap.path = paste0(ipath, umap.fn)
# samp.dat.filtered = readRDS(file.path(ipath, "samp.dat.rds"))
load("samp.dat.filtered_clusterQCfilter.20220801.rda")
load("broad.roi.key.rda")
load("./prelim_cluster_objects/cl.df_U19.max.2022-08-01.rda")
umap.rna = read.csv(umap.path)
colnames(umap.rna) = c("sample_id","rna.x","rna.y")

## Filter samp.dat
samp.dat.select = samp.dat.filtered[grepl("Oligo|OPC", samp.dat.filtered$max.subclass.U19),]


## Merge things
umap.anno = left_join(umap.rna, samp.dat.select)
umap.anno = left_join(umap.anno, broad.key)
head(umap.anno)



## Train.cl.df
# load("//allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/Taxonomies/AIT10.0_mouse/train.cl.df.rda")
train.cl.df = read.csv("cl.df_wb10x_joint_cl5283_0801.csv")

################################
## Plot UMAP
################################
## Set some universal plotting parameters
tmp.size = 0.3
tmp.alpha = 0.3


## Colors
tmp = unique(train.cl.df[,c("class_color", "class_id_label")])
col.class = as.character(tmp$class_color)
names(col.class) = tmp$class_label

tmp = unique(train.cl.df[,c("subclass_color", "subclass_id_label")])
col.subclass = as.character(tmp$subclass_color)
names(col.subclass) = tmp$subclass_label

col.broi = brewer.pal(6, "Set1")
names(col.broi) = unique(broad.key$broad_roi)


## Basic meta data
# g = umap.anno %>%
#   ggplot(aes(x = rna.x, y = rna.y)) + 
#   geom_point(aes(col = max.class.U19), alpha = 0.25, size = tmp.size) + 
#   scale_color_manual(values = col.class)+
#   guides(colour = guide_legend(override.aes = list(size=4, alpha = tmp.alpha))) +
#   ggtitle("max.class.U19") +theme(plot.title = element_text(face = "bold")) +
#   theme_void()#+  theme(legend.position = "none")
# 
# ggsave(g, filename = file.path(opath, "max.class.U19.png"), width = 7, height = 6.5)


g = umap.anno %>%
  ggplot(aes(x = rna.x, y = rna.y)) + 
  geom_point(aes(col = max.subclass.U19), alpha = 0.25, size = tmp.size) + 
  scale_color_manual(values = col.subclass)+
  guides(colour = guide_legend(override.aes = list(size=4, alpha = tmp.alpha))) +
  ggtitle("keep") +theme(plot.title = element_text(face = "bold")) +
  theme_void() +  theme(legend.position = "none")

ggsave(g, filename = file.path(opath, "max.subclass.U19.png"), width = 7, height = 6.5)


tmp = umap.anno[,c("rna.x", "rna.y")]
row.names(tmp) = umap.anno$sample_id
tmp.cl = umap.anno$cl
names(tmp.cl) = umap.anno$sample_id
cl.center <- get_RD_cl_center(tmp, tmp.cl)

g = umap.anno %>%
  ggplot(aes(x = rna.x, y = rna.y)) + 
  geom_point(aes(col = as.factor(cl)), alpha = 0.1, size = tmp.size) + 
  # scale_color_manual(values = col.cl)+
  # xlim(5,15)+
  guides(colour = guide_legend(override.aes = list(size=4, alpha = 1), title = "Cluster")) +
  annotate(geom="text", x=cl.center[,1], y=cl.center[,2], label = row.names(cl.center), color="black") +
  ggtitle("Cluster") +theme(plot.title = element_text(face = "bold")) +
  theme_void()

ggsave(g, filename = file.path(opath, "cluster_with_labels.png"), width = 9, height = 6.5)



g = umap.anno[sample(row.names(umap.anno)),] %>%
  ggplot(aes(x = rna.x, y = rna.y)) + 
  geom_point(aes(col = age_cat), alpha = 0.25, size = tmp.size) + 
  scale_color_manual(values = c("olivedrab", "grey"))+
  guides(colour = guide_legend(override.aes = list(size=4, alpha = tmp.alpha))) +
  ggtitle("keep") +theme(plot.title = element_text(face = "bold")) +
  theme_void()#+  theme(legend.position = "none")

ggsave(g, filename = file.path(opath, "age_cat.png"), width = 7, height = 6.5)


g = umap.anno[sample(row.names(umap.anno)),] %>%
  ggplot(aes(x = rna.x, y = rna.y)) + 
  geom_point(aes(col = broad_roi), alpha = 0.25, size = tmp.size) + 
  scale_color_manual(values = col.broi)+
  guides(colour = guide_legend(override.aes = list(size=4, alpha = tmp.alpha))) +
  ggtitle("keep") +theme(plot.title = element_text(face = "bold")) +
  theme_void()#+  theme(legend.position = "none")

ggsave(g, filename = file.path(opath, "broad_roi.png"), width = 7, height = 6.5)



g = umap.anno[sample(row.names(umap.anno)),] %>%
  ggplot(aes(x = rna.x, y = rna.y)) + 
  geom_point(aes(col = sex), alpha = 0.25, size = tmp.size) + 
  # scale_color_manual(values = col.broi)+
  guides(colour = guide_legend(override.aes = list(size=4, alpha = tmp.alpha))) +
  ggtitle("sex") +theme(plot.title = element_text(face = "bold")) +
  theme_void()#+  theme(legend.position = "none")

ggsave(g, filename = file.path(opath, "sex.png"), width = 7, height = 6.5)


## QC metrics

g = umap.anno[sample(row.names(umap.anno)),] %>%
  ggplot(aes(x = rna.x, y = rna.y)) + 
  geom_point(aes(col = med.gc), alpha = 0.25, size = tmp.size) + 
  # scale_color_manual(values = col.broi)+
  scale_colour_gradient(low = "grey", high = "red", na.value = NA)+
  # guides(colour = guide_legend(override.aes = list(size=4, alpha = tmp.alpha))) +
  ggtitle("keep") +theme(plot.title = element_text(face = "bold")) +
  theme_void()#+  theme(legend.position = "none")

ggsave(g, filename = file.path(opath, "cluster_med_gc.png"), width = 7, height = 6.5)


g = umap.anno[sample(row.names(umap.anno)),] %>%
  ggplot(aes(x = rna.x, y = rna.y)) + 
  geom_point(aes(col = med.qc), alpha = 0.25, size = tmp.size) + 
  # scale_color_manual(values = col.broi)+
  scale_colour_gradient(low = "grey", high = "red", na.value = NA)+
  # guides(colour = guide_legend(override.aes = list(size=4, alpha = tmp.alpha))) +
  ggtitle("keep") +theme(plot.title = element_text(face = "bold")) +
  theme_void()#+  theme(legend.position = "none")

ggsave(g, filename = file.path(opath, "cluster_med_qc.png"), width = 7, height = 6.5)



g = umap.anno[sample(row.names(umap.anno)),] %>%
  ggplot(aes(x = rna.x, y = rna.y)) + 
  geom_point(aes(col = doublet_score), alpha = 0.25, size = tmp.size) + 
  # scale_color_manual(values = col.broi)+
  scale_colour_gradient(low = "grey", high = "red", na.value = NA)+
  # guides(colour = guide_legend(override.aes = list(size=4, alpha = tmp.alpha))) +
  ggtitle("keep") +theme(plot.title = element_text(face = "bold")) +
  theme_void()#+  theme(legend.position = "none")

ggsave(g, filename = file.path(opath, "doublet_score.png"), width = 7, height = 6.5)


g = umap.anno %>%
  ggplot(aes(x = rna.x, y = rna.y)) + 
  geom_point(aes(col = library_prep), alpha = 0.25, size = tmp.size) + 
  # scale_color_manual(values = library_prep)+
  guides(colour = guide_legend(override.aes = list(size=4, alpha = tmp.alpha))) +
  ggtitle("keep") +theme(plot.title = element_text(face = "bold")) +
  theme_void() +  theme(legend.position = "none")

ggsave(g, filename = file.path(opath, "library_prep.png"), width = 7, height = 6.5)


g = umap.anno %>%
  ggplot(aes(x = rna.x, y = rna.y)) + 
  geom_point(aes(col = facs_population_plan), alpha = 0.25, size = tmp.size) + 
  # scale_color_manual(values = library_prep)+
  guides(colour = guide_legend(override.aes = list(size=4, alpha = tmp.alpha))) +
  ggtitle("FACSPP") +theme(plot.title = element_text(face = "bold")) +
  theme_void() +  theme(legend.position = "none")

ggsave(g, filename = file.path(opath, "facs_population_plan.png"), width = 7, height = 6.5)





################################
## Additional LQ clusters by donor
################################
cl.df.select = umap.anno %>% group_by(cl) %>% summarize(max.donor.prop = (max(table(library_prep)) / n()))

cl.keep = cl.df.select$cl[cl.df.select$max.donor.prop < 0.9]

saveRDS(cl.keep, file = file.path(opath, "cl.keep.rds"))
