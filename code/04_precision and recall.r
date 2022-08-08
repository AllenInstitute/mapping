#precision and recall

#precision: true selected / total selected

#recall: true selected / total true

#ie; at neighbor level: 
#precision = true GABA identified as GABA / all things classified as GABA
#recall = true GABA identified as GABA / all the true GABAS in the dataset

#run on "combined_df" from running the confidence analysis script. 
#do not run before confidence analysis script

#load combined_df
load("combined.df")

#THIS RUNS AT SUBCLASS LEVEL: CAN ALSO SPECIFY 'true_neighbor_label' or 'true_cluster_label'
iter <- (unique(combined_df$true_subclass_label))

variables <- c("Subclass","Precision","Recall")

output <- matrix(ncol=length(variables), nrow=length(iter))

for(i in 1:(length(iter))) {
  output[i,1] <- iter[i] 
  
  #precision
  pred_as_group <- (combined_df[combined_df$pred_subclass_label==iter[i],])
  true_within_pred <- pred_as_group[pred_as_group$true_subclass_label==iter[i],]
  
  precision <- nrow(true_within_pred)/nrow(pred_as_group)
  output[i,2] <- precision
  
  print(paste0("Precision for ", iter[i]," subclass is ",precision))
  
  #recall
  true_in_data <- combined_df[combined_df$true_subclass_label==iter[i],]
  true_identified <- true_in_data[true_in_data$pred_subclass_label==iter[i],]
  
  recall <- nrow(true_identified)/nrow(true_in_data)
  print(paste0("Recall for ", iter[i]," subclass is ",recall))
  output[i,3] <- recall
}

output
output <- data.frame(output)
names(output)[1] <- 'Subclass'
names(output)[2] <- 'Precision'
names(output)[3] <- 'Recall'

new.output <- output[,1:2]
new.output$Measurement <- 'Precision'
new.output$value <- new.output$Precision
keep <- c("Subclass","Measurement","value")
new.output <- new.output[keep]

re.output <- output[,c(1,3)]
re.output$Measurement <- 'Recall'
re.output$value <- re.output$Recall
re.output <- re.output[keep]


final_df <- rbind(new.output, re.output)
final_df$value <- as.numeric(final_df$value)
final_df$Algorithm <- "Flat" #INPUT_NAME_OF_ALGORITHM

final_df_flat  <- final_df #SAVE UNDER ANOTHER NAME


#RUN THE ABOVE SCRIPT FOR ALL THE OBJECTS YOU WANT TO COMBINE
all_dat <- rbind(final_df_flat, final_df) #LIST OF OBJECTS YOU ARE COMBINING


recall<- 
  ggplot(data=all_dat[all_dat$Measurement=="Recall",], aes(x=Subclass, y=value)) +
  geom_bar(aes(fill = Algorithm), stat="identity", position = 'dodge')  +
  theme_light() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 5)) +
  ggtitle("All data: Recall") + scale_fill_brewer(palette = "Set1")

pre<-ggplot(data=all_dat[all_dat$Measurement=="Precision",], aes(x=Subclass, y=value)) +
  geom_bar(aes(fill = Algorithm), stat="identity", position = 'dodge')  +
  theme_light() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 5)) +
  ggtitle("All data: Precision") + scale_fill_brewer(palette = "Set2")


