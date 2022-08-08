#code to create one combined dataframe for datasets and correlation plots for an object. 

create_corr_plots <- function(NAMES_VECTOR, data_name) {
  
  library(ggplot2)
  
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
  
 
   
  for(i in 1:length(classes)) {
  #generate plot
  cluster_plot_by_pred <- ggplot(data = combined_df[combined_df$class_label == classes[i],], aes(x=reorder(pred_cluster_label, -(avg.cor)), y=avg.cor), color = cluster_correctness) + 
    geom_boxplot(aes(fill=cluster_correctness), outlier.size = 0.2) + 
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 20)) +
    ggtitle(paste0(classes[i], "_by_predicted_cluster"))
  
  subclass_plot_by_pred <- ggplot(data = combined_df[combined_df$class_label == classes[i],], aes(x=reorder(pred_subclass_label, -(avg.cor)), y=avg.cor), color = subclass_correctness) + 
    geom_boxplot(aes(fill=subclass_correctness), outlier.size = 0.2) + 
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 20)) +
    ggtitle(paste0(classes[i], "_by_predicted_subclass")) 
  
  neighbor_plot_by_pred <- ggplot(data = combined_df[combined_df$class_label == classes[i],], aes(x=reorder(pred_neighbor_label, -(avg.cor)), y=avg.cor), color = neighbor_correctness) + 
    geom_boxplot(aes(fill=neighbor_correctness), outlier.size = 0.2) + 
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 20)) +
    ggtitle(classes[i], "_by_predicted_neighbor") 
  
  cluster_plot_by_true <- ggplot(data = combined_df[combined_df$class_label == classes[i],], aes(x= reorder(true_cluster_label, -(avg.cor)), y=avg.cor), color = cluster_correctness) + 
    geom_boxplot(aes(fill=cluster_correctness), outlier.size = 0.2) + 
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 20)) +
    ggtitle(paste0(classes[i], "_by_true_cluster")) 
  
  subclass_plot_by_true <- ggplot(data = combined_df[combined_df$class_label == classes[i],], aes(x= reorder(true_subclass_label, -(avg.cor)), y=avg.cor), color = subclass_correctness) + 
    geom_boxplot(aes(fill=subclass_correctness), outlier.size = 0.2) + 
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 20)) +
    ggtitle(paste0(classes[i], "_by_true_subclass"))
  
  neighbor_plot_by_true <- ggplot(data = combined_df[combined_df$class_label == classes[i],], aes(x= reorder(true_neighbor_label, -(avg.cor)), y=avg.cor), color = neighbor_correctness) + 
    geom_boxplot(aes(fill=neighbor_correctness), outlier.size = 0.2) + 
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 20)) +
    ggtitle(classes[i], "_by_true_neighbor") 
  
  png(filename = paste0(classes[i], "_by_predicted_cluster.png"), width = 10000, height = 1000)
  print(cluster_plot_by_pred)
  dev.off()
  
  png(filename = paste0(classes[i], "_by_predicted_subclass.png"), width = 3000, height = 1000)
  print(subclass_plot_by_pred)
  dev.off()
  
  png(filename = paste0(classes[i], "_by_predicted_neighbor.png"), width = 3000, height = 1000)
  print(neighbor_plot_by_pred)
  dev.off()
  
  png(filename = paste0(classes[i], "_by_true_cluster.png"), width = 10000, height = 1000)
  print(cluster_plot_by_true)
  dev.off()
  
  png(filename = paste0(classes[i], "_by_true_subclass.png"), width = 3000, height = 1000)
  print(subclass_plot_by_true)
  dev.off()
  
  png(filename = paste0(classes[i], "_by_true_neighbor.png"), width = 3000, height = 1000)
  print(neighbor_plot_by_true)
  dev.off()
  }
  
  full_neighbor_plot_by_pred <- ggplot(data = combined_df, aes(x= reorder(pred_neighbor_label, -(avg.cor)), y=avg.cor), color = neighbor_correctness) + 
    geom_boxplot(aes(fill=neighbor_correctness), outlier.size = 0.2) + 
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 20)) +
    ggtitle("Full Neighbor By Predicted")
  
  full_subclass_plot_by_pred <- ggplot(data = combined_df, aes(x= reorder(pred_subclass_label, -(avg.cor)), y=avg.cor), color = subclass_correctness) + 
    geom_boxplot(aes(fill=subclass_correctness), outlier.size = 0.2) + 
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 20)) +
    ggtitle("Full Neighbor By Predicted") 
  
  full_neighbor_plot_by_true <- ggplot(data = combined_df, aes(x= reorder(true_neighbor_label, -(avg.cor)), y=avg.cor), color = neighbor_correctness) + 
    geom_boxplot(aes(fill=neighbor_correctness), outlier.size = 0.2) + 
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 20)) +
    ggtitle("Full Neighbor By True") 
  
  full_subclass_plot_by_true <- ggplot(data = combined_df, aes(x= reorder(true_subclass_label, -(avg.cor)), y=avg.cor), colour = subclass_correctness) + 
    geom_boxplot(aes(fill=subclass_correctness), outlier.size = 0.2) + 
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 20)) +
    ggtitle("Full Subclass By True")
  
  png(filename = paste0("FULL_subclass_by_pred.png"), width = 3000, height = 1000)
  print(full_subclass_plot_by_pred)
  dev.off()
  
  png(filename = paste0("FULL_neighbor_by_pred.png"), width = 3000, height = 1000)
  print(full_neighbor_plot_by_pred)
  dev.off()
  
  png(filename = paste0("FULL_subclass_by_true.png"), width = 3000, height = 1000)
  print(full_subclass_plot_by_true)
  dev.off()
  
  png(filename = paste0("FULL_neighbor_by_true.png"), width = 3000, height = 1000)
  print(full_neighbor_plot_by_true)
  dev.off()
  
  save(combined_df, file = paste0(data_name,"combined_df.rda"))
  
}
