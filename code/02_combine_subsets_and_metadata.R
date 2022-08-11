#combined subsetted mapping results into one file
#NAMES_VECTOR should be a vector containing the names of the subset files as STRINGS!!!
#data_name is a string that you want to use to identify your combined mapping results dataframe

#this also adds meta data to the combined object


combine_subsets_and_metadata <- function(NAMES_VECTOR, data_name) {
 
  num <- length(NAMES_VECTOR)
  
  #the first part is the fencepost;
  
  first_obj <- get(NAMES_VECTOR[1])
  combined_df <- first_obj$best.map.df
  
  for(f in 2:num) {
    #point to correct file
    name <- NAMES_VECTOR[f]
    print(name)
    current_obj <- get(name)
    
    #store the mapped clusterings
    current_df <- current_obj$best.map.df
    
    combined_df = rbind(combined_df, current_df)
  }
  
  
  load("//allen/programs/celltypes/workgroups/rnaseqanalysis/yzizhen/joint_analysis/forebrain_new/cl.clean.rda")
  
  rownames(combined_df) <- combined_df$sample_id
  rownames(cl.df.clean) <- cl.df.clean$cl 
  
  combined_df$true_cluster = cl.clean[combined_df$sample_id]
  
  combined_df$pred_cluster_label = cl.df.clean[combined_df$best.cl,2]
  combined_df$true_cluster_label = cl.df.clean[combined_df$true_cluster, 2]
  combined_df$cluster_correctness = as.factor((combined_df$true_cluster_label == combined_df$pred_cluster_label))
  combined_df$pred_subclass_label = cl.df.clean[combined_df$best.cl,7]
  combined_df$true_subclass_label = cl.df.clean[combined_df$true_cluster,7]
  combined_df$subclass_correctness = as.factor((combined_df$true_subclass_label == combined_df$pred_subclass_label))
  combined_df$class_label = cl.df.clean[combined_df$best.cl,6]
  combined_df$pred_neighbor_label = cl.df.clean[combined_df$best.cl, 16]
  combined_df$true_neighbor_label = cl.df.clean[combined_df$true_cluster,16]
  combined_df$neighbor_correctness = as.factor((combined_df$true_neighbor_label == combined_df$pred_neighbor_label))
  
  classes <- unique(combined_df$class_label)
  
  combined_df <- na.omit(combined_df)
  
  save(combined_df, file = paste0(data_name,"combined_df.rda"))
  
}