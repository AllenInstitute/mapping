WBDIR    = "/allen/programs/celltypes/workgroups/rnaseqanalysis/yzizhen/10X_analysis/wholebrain_v3"
load(file.path(WBDIR, "select.genes.rda"))
load("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/ForeBrain/norm.10Xv2.rda")
common = intersect(rownames(qdat), select.genes)

source("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/HKNN_util.R")
setwd("/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/new_train_lists")

for (pct in c(0.9)) {
  for (n in c(1,2)) {
    print(paste(pct, n))
    if (!file.exists(paste0("train.list_top", n, "_pct", pct, ".rda"))) {
      train.list = build_train_list_FB( pre.train.list=NA, 
                                        query.genes = common,
                                        FBDIR = "/allen/programs/celltypes/workgroups/rnaseqanalysis/yzizhen/joint_analysis/forebrain_new",
                                        TaxDir = "/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/Taxonomies/AIT9.0_mouse",
                                        prefix = paste0("FB_top", n, "_pct", pct), 
                                        div_thr=3,
                                        subsample_pct=pct,
                                        top.n.genes=n) 
      save(train.list, file=paste0("train.list_top", n, "_pct", pct, ".rda"))
    }
  }
}
