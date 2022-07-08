#streamlining the functions for mapping

source("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/HKNN_util.R")

run_large_mapping <- function(obj, naming, alg = c("HKNN", "FLAT"), path, sub_size = 10000, top.n.genes = 15, run_full = TRUE, start = 0, end = 10) {
  source("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/HKNN_util.R")


  #load libraries
  library(scrattch.hicat)
  
  if(alg == "FLAT") {
    library(bigstatsr)
    library(dplyr)
    library(doMC)
    library(foreach)
    
    source("/allen/programs/celltypes/workgroups/rnaseqanalysis/changkyul/Mapping_On_Taxonomy/map_knn_k.R")
    
    #load in training data
    TaxDir = "/allen/programs/celltypes/workgroups/rnaseqanalysis/shiny/Taxonomies/AIT9.0_mouse"
    load(file.path(TaxDir, "train.list.HANN_marker_index_3.rda"))
  }
  
  #directory for saving files
  #setwd(path)
  
  #establish number of iterations needed

  obj_size <- ncol(obj)
  print(obj_size)

  #determine if there is a remainder
  last <- obj_size %% sub_size
  loops <- obj_size %/% sub_size 
  if(run_full == FALSE) {
    if(end <= loops) {
      last <- 0
      loops <- end
    }
  }

  #run subsets
  if(start <= loops) {
  for(n in start:loops) {
    start <- ((n*sub_size)+1)
    print(start)
    end <- ((n+1)*sub_size)
    print(end)
    file_name <- paste0("mapped.", naming, ".", alg, ".part", n+1)
    print(file_name)
    
    sub_obj <- obj[,start:end]
   
    
      #run correct mapping algorithm
      if(alg == "HKNN"){
        current_obj <- run_mapping_HKNN(sub_obj,                     # query data
                                        Taxonomy="AIT9.0_mouse",  # taxonomy: forebrain 
                                        prefix="FB",              # prefix for your run
                                        mc.cores=10, iter=100, top.n.genes = top.n.genes)
      }
      if(alg == "FLAT") {
        current_obj <- map_cells_knn_bs(topk=1, sub_obj, iter=50, train.list$cl.dat, method="cor")
      }
      
      #save subset file
      save(current_obj, file=file.path(path, paste0(top.n.genes, "GENES_", file_name, ".rda")))
    
  }
  }
  
  #run mapping on remainder
  if(last != 0){
    
    r_start <- (loops*sub_size) + 1
    r_end <- obj_size
    file_name <- paste0("mapped.", naming, ".", alg, ".part", (loops+1))
    
    
      if(alg == "HKNN") {
        remainder_obj <- run_mapping_HKNN(obj[,r_start:r_end],                     # query data
                                          Taxonomy="AIT9.0_mouse",  # taxonomy: forebrain 
                                          prefix="FB",              # prefix for your run
                                          mc.cores=10, iter=100, top.n.genes = z )
      }
      if(alg == "FLAT") {
        remainder_obj <- map_cells_knn_bs(topk=1, obj[,r_start:r_end], iter=50, train.list$cl.dat, method="cor")
      }
      save(remainder_obj, file=file.path(path, paste0(top.n.genes, "GENES_", file_name, ".rda")))
    
  }
}

