
source("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/hmapping/HKNN_util.R")

TaxDir = "/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/Taxonomies/AIT9.0_mouse"

for (top.n.genes in c(15)) {
   FN = paste0("FB_top", top.n.genes, "_pct0.9train.list.HANN_marker_index.rda")
   filename = file.path(TaxDir, FN)
   load(filename)
   train.list = update_select.markers_cl.dat (train.list)
   save(train.list, file=filename)
}
