#confusion matrices generation script
#will create 3 matrices: cluster, subclass, neighbor. 
#use this script after generating confidence analysis df. That is the input

generate_confusion <- function (combined_df, data_name) {
  
  library(corrplot)
  
  #create neighbor corrplot
  cM = table(combined_df$pred_neighbor_label, combined_df$true_neighbor_label)
  
  cM_1 <- cM
  iter <- length(unique(combined_df$true_neighbor_label))
  
  for(i in 1:iter) {
    row_total <- sum(cM[i,])
    print(row_total)
    cM_1[i,] <- (cM[i,] / row_total)
  }
  pcM = as.matrix(cM_1)
  
  pcM[pcM == 0] = NA
  neighbor_corrplot <- corrplot(pcM, method = 'color', is.corr = F, na.label = " ",
                                tl.col = "black",
                                col=colorRampPalette(c("white","lightblue","darkblue"))(100))
  
  
  #create subclass corrplot
  cM = table(combined_df$pred_subclass_label,combined_df$true_subclass_label)
  cM_1 <- cM
  iter <- length(unique(combined_df$true_subclass_label))
  
  for(i in 1:iter) {
    row_total <- sum(cM[i,])
    cM_1[i,] <- (cM[i,] / row_total)
  }
  pcM = as.matrix(cM_1)
  
  pcM[pcM == 0] = NA
  subclass_corrplot <- corrplot(pcM, method = 'color', is.corr = F, na.label = " ",
                                tl.col = "black", title = paste0(data_name, "_subclass_level"), tl.cex = 0.3,
                                col=colorRampPalette(c("white","lightblue","darkblue"))(100))
  
  #create cluster corrplot
  cM = table(combined_df$pred_cluster_label,combined_df$true_cluster_label)
  cM_1 <- cM
  iter <- length(unique(combined_df$true_cluster_label))
  
  for(i in 1:iter) {
    row_total <- sum(cM[i,])
    cM_1[i,] <- (cM[i,] / row_total)
  }
  pcM = as.matrix(cM_1)
  
  pcM[pcM == 0] = NA
  cluster_corrplot <- corrplot(pcM, method = 'color', is.corr = F, na.label = " ",
                                tl.col = "black", title = paste0(data_name, "_cluster_level"), tl.cex = 0.1,
                               col=colorRampPalette(c("white","lightblue","darkblue"))(100))
  
  png(filename = paste0(data_name, "_neighbor_confusion.png"), width = 1000, height = 1000)
  print(neighbor_corrplot)
  dev.off()
  
  png(filename = paste0(data_name, "subclass_confusion.png"), width = 1000, height = 1000)
  print(subclass_corrplot)
  dev.off()
  
  png(filename = paste0(data_name, "cluster_confusion.png"), width = 1000, height = 1000)
  print(cluster_corrplot)
  dev.off()
  
  }
