#function to analyze ANY mapping results! 
#NAMES_VECTOR should be a vector containing the names of the subset files as STRINGS!!!
#data_name is a string that you want to use to identify your results--it will be put in the name of the results csv produced. 

enter_results <- function(NAMES_VECTOR, data_name) {
  library(dplyr)
  print(data_name)
  num <- length(NAMES_VECTOR)
  print(num)
  
  #create df to store results
  results <- data.frame("Part" = 1:num, "Cluster_True" = integer(num), "Cluster_False" = integer(num),
                        "Subclass_True" = integer(num), "Subclass_False" <- integer(num))
  print(results)
  
  #load in the correct clustering: 
  #it will load in cl.clean, a factor with all the correct clusters. 
  load("//allen/programs/celltypes/workgroups/rnaseqanalysis/yzizhen/joint_analysis/forebrain_new/cl.clean.rda")
  
  for(f in 1:num) {
    #point to correct file
    name <- NAMES_VECTOR[f]
    print(name)
    current_obj <- get(name)
    
    #store the mapped clusterings
    predicted_cluster_num <- current_obj[["best.map.df"]]$best.cl
    
    filtered.clean <- cl.clean[current_obj[["best.map.df"]]$sample_id]
    
    #establish counts
    cluster_correct <- 0
    cluster_wrong <- 0
    subclass_correct <- 0
    subclass_wrong <- 0
    
    #compare mapped clusters to real clusters
    for(j in 1:(length(filtered.clean))) {
      
      id <- current_obj[["best.map.df"]][["sample_id"]][j]
      
      if(!is.na(as.character(filtered.clean[id]))) {
        
        if((as.character(filtered.clean[id])) == predicted_cluster_num[j]) {
          
          cluster_correct <- cluster_correct + 1
          subclass_correct <- subclass_correct + 1
    
        } else {
          
          cluster_wrong <- cluster_wrong + 1
          print(paste0("wrong. predicted: ", predicted_cluster_num[j], " actual: ", as.character(filtered.clean[id])))
       
          key_row <- cl.df.clean %>% dplyr::filter(cl == as.numeric(as.character(filtered.clean[id])))
          key_subclass <- key_row$subclass_label[1]
          
          predicted_row <- cl.df.clean %>% dplyr::filter(cl == as.numeric(predicted_cluster_num[j]))
          predicted_subclass <- predicted_row$subclass_label[1]
          
          if(key_subclass == predicted_subclass) {
            subclass_correct <- subclass_correct + 1
          } else {
            subclass_wrong <- subclass_wrong + 1
          }
        }
      } else {
        print("could not find sample ID in cl.clean")
      }
    }
    print("done with the 10000 iterations for this part.")
    results$Cluster_True[f] <- cluster_correct
    results$Cluster_False[f] <- cluster_wrong
    results$Subclass_True[f] <- subclass_correct
    results$Subclass_False[f] <- subclass_wrong
    print(results)
  }
  
  
  #save results
  results$X.Subclass_False.....integer.num. <- NULL
  write.csv(results, paste0(data_name, "_results.csv"))
  
  #calculate total binary test error rate: 
  total_false <- sum(results$False)
  total_sum <- (sum(results$True)) + total_false
  print(data_name)
  print("error rate:")
  print(total_false/total_sum)
  
  return(results)
}
