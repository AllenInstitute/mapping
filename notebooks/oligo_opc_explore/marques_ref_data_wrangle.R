#get cluster labels onto the map result object. 

#load in map result object
map_result_marques_as_ref <- readRDS("/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/notebooks/external_data/map_result_marques_as_ref.RDS")

#create object of best map df
results <- map_result_marques_as_ref$best.map.df
cell_names <- results$sample_id

## Load clustering data
samp.dat = readRDS("/allen/programs/celltypes/workgroups/rnaseqanalysis/Kelly/Aging_RNA_16roi_V3/data_oligo-opc/samp.dat.rds")
samp.sub <- samp.dat[,c("sample_id","cl")]

#match allen clustering labels to cells in mapped object
results$allen_cl = samp.sub$cl[match(results$sample_id, samp.sub$sample_id)]



group = readRDS("/allen/programs/celltypes/workgroups/rnaseqanalysis/Kelly/Aging_RNA_16roi_V3/data_oligo-opc/group_labels.rds")
group$allen_cl = group$cl

library(dplyr)
results = left_join(results, group, by = "allen_cl")


#now proceed to plots


results$allen_cl <- as.character(results$allen_cl)
write.csv(results, "marques_as_ref_with_cluster_labels.csv")

results %>%
  #filter(group.name == c("Oligo","OPC","Transition")) %>%
  ggplot()+       # reference to data
  geom_bar(                 # geometry - a shape
    aes(x= allen_cl,   # aesthetics - x, y, and color values
        fill=best.cl),
    position = "fill"
  ) + 
  theme_classic()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  facet_wrap(~group.name, scales = "free_x", ncol = 1)






results %>%
  ggplot()+       # reference to data
  geom_bar(                 # geometry - a shape
    aes(x= best.cl,   # aesthetics - x, y, and color values
        fill=allen_cl),
    position = "fill"
  )

ggplot(results) + 
  geom_bar(aes(x = allen_cl, fill = best.cl, position="fill", stat="identity"))

