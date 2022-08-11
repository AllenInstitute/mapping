library(ggplot2)
library(gridExtra)
library(dplyr)

ipath = "./data_oligo-opc//"
opath = "./data_oligo-opc//"

load("prelim_cluster_objects/cl.df_U19.max.2022-08-01.rda")
cl.keep = readRDS(file.path(ipath, "cl.keep.rds"))
load("samp.dat.filtered_clusterQCfilter.20220801.rda")
load("broad.roi.key.rda")
samp.dat.filtered = left_join(samp.dat.filtered, broad.key)
group = readRDS("./data_oligo-opc/group_labels.rds")
group$cl = as.integer(as.character(group$cl))

samp.dat.select = samp.dat.filtered[samp.dat.filtered$cl %in% cl.keep,]
samp.dat.select = left_join(samp.dat.select, group)



samp.dat.select.test <- samp.dat.select[na.omit(samp.dat.select$Group),]

global.age.prop = sum(samp.dat.select$age_cat == "aged") / nrow(samp.dat.select)
global.sex.prop = sum(samp.dat.select$sex == "M") / nrow(samp.dat.select)

col.broi = brewer.pal(6, "Set1")
names(col.broi) = unique(broad.key$broad_roi)

col.roi = c(brewer.pal(9, "Set1"), brewer.pal(8, "Set2"))
names(col.roi) = unique(broad.key$roi)



##add in infer cell type
samp.dat.select = left_join(samp.dat.select, X5genes_cl_to_type_key)

## Bar plots
p00 = samp.dat.select %>%
  ggplot(aes(x = reorder(cl_celltype, age_prop), fill = max.subclass.U19)) +
  geom_bar(position = "fill", stat = "count") +
  # scale_y_log10() +
  # scale_fill_manual(values=col.subclass) +
  # facet_wrap(~subclass_label, scales = "free", ncol = 1) +
  scale_y_log10()+
  xlab("Subclass")+
  theme_classic()+  
  theme(axis.text.x = element_text(angle = 45, hjust = 1))#+  theme(legend.position = "none")

p0 = samp.dat.select %>%
  ggplot(aes(x = reorder(cl_celltype, age_prop), fill = Group)) +
  geom_bar(position = "fill", stat = "count") +
  # scale_y_log10() +
  # scale_fill_manual(values=col.subclass) +
  # facet_wrap(~subclass_label, scales = "free", ncol = 1) +
  scale_y_log10()+
  xlab("Group")+
  theme_classic()+  
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+  theme(legend.position = "right")

p1 = samp.dat.select %>%
  ggplot(aes(x = reorder(cl_celltype, age_prop), fill = as.factor(cl), color = as.factor(cl))) +
  geom_bar(stat = "count") +
  # scale_y_log10() +
  # scale_fill_manual(values=sample_cols) +
  # facet_wrap(~subclass_label, scales = "free", ncol = 1) +
  scale_y_log10()+
  xlab("Number of Cells")+
  theme_classic()+  
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+  theme(legend.position = "right")

p2 = filt_ggplot_dat %>%
  ggplot(aes(x = reorder(inferred_celltype, age_prop), fill = age_cat)) +
  geom_bar(position = "fill", stat = "count") +
  scale_fill_manual(values = c("olivedrab", "grey"))+
  geom_hline(yintercept = global.age.prop, lty = 2, color = "black")+
  # facet_wrap(~subclass_label, scales = "free", ncol = 1) +
  xlab("Age")+
  theme_classic()+  
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+  theme(legend.position = "right")

p3 = samp.dat.filtered %>%
  ggplot(aes(x = reorder(inferred_celltype, age_prop), fill = broad_roi)) +
  geom_bar(position = "fill", stat = "count") +
  scale_fill_manual(values=col.broi) +
  # facet_wrap(~subclass_label, scales = "free", ncol = 1) +
  xlab("Broad region")+
  theme_classic()+  
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+  theme(legend.position = "right")

p4 = samp.alt %>%
  ggplot(aes(x = reorder(cl_celltype, age_prop), fill = sex)) +
  geom_bar(position = "fill", stat = "count") +
  scale_fill_manual(values=c("indian red", "sky blue")) +
  # facet_wrap(~subclass_label, scales = "free", ncol = 1) +
  geom_hline(yintercept = global.sex.prop, lty = 2, color = "black")+
  xlab("Sex")+
  theme_classic()+  
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+  theme(legend.position = "right")

p5 = samp.dat.select %>%
  ggplot(aes(x = reorder(cl, age_prop), fill = library_prep, color = library_prep)) +
  geom_bar(position = "fill", stat = "count") +
  # scale_fill_manual(values=sample_cols) +
  # facet_wrap(~subclass_label, scales = "free", ncol = 1) +
  xlab("Donor")+
  theme_classic()+  
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+  theme(legend.position = "none")

p6 = samp.dat.select %>%
  ggplot(aes(x = reorder(cl, age_prop), fill = facs_population_plan, color = facs_population_plan)) +
  geom_bar(position = "fill", stat = "count") +
  # scale_fill_manual(values=sample_cols) +
  # facet_wrap(~subclass_label, scales = "free", ncol = 1) +
  xlab("FACSPP")+
  theme_classic()+  
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+  theme(legend.position = "none")

p7 = samp.dat.select %>%
  ggplot(aes(x = reorder(cl, age_prop), fill = roi)) +
  scale_fill_manual(values=col.roi) +
  geom_bar(position = "fill", stat = "count") +
  # scale_fill_manual(values=sample_cols) +
  # facet_wrap(~subclass_label, scales = "free", ncol = 1) +
  xlab("FACSPP")+
  theme_classic()+  
  theme(axis.text.x = element_text(angle = 45, hjust = 1))#+  theme(legend.position = "none")



grid.arrange(p0, p1, p2, p3, p4, p5, p6, ncol = 1)

grid.arrange(p2, p3, p7, ncol = 1)

tmp = samp.dat.select[samp.dat.select$cl == "6566",]
table(tmp$library_prep)[table(tmp$library_prep) > 0]
table(tmp$facs_population_plan)
table(tmp$full_genotype)

