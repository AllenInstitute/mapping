#code to create correlation plots for an object. 

#you must run this AFTER 02 and input your combined_DF as the first parameter. 

create_corr_plots <- function(combined_dataframe, data_name) {
  
  library(ggplot2)
   
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
  
  
}
