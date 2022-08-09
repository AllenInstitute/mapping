#generate ggplot figures for presentation of error rates

library(ggplot2)

setwd("/allen/programs/celltypes/workgroups/rnaseqanalysis/clare_morris/results/dataframes")
errors <- read.csv("ggplot_error_rates.csv")
errors <- read.csv("class_error_rates.csv")
str(errors)

ggplot(errors, aes(x = Num.of.genes, y = Cluster.Error.Rate, group = Map.Algorithm)) +
  geom_line(aes(linetype=Map.Algorithm)) + geom_point(aes(shape=Map.Algorithm)) + facet_wrap(~Data, ncol=3)

ggplot(errors, aes(x = Num.of.genes, y = Subclass.Error.Rate, group = Map.Algorithm)) +
  geom_line(aes(linetype=Map.Algorithm)) + geom_point(aes(shape=Map.Algorithm)) + facet_wrap(~Data, ncol=3)

ggplot(errors, aes(x = Num.of.genes, y = Neighborhood.Error.Rate)) +
  geom_bar()+ facet_wrap(~Data, ncol=3)

ggplot(errors, aes(x = Algorithm, y = Cluster.Error)) +
  geom_bar()+ facet_wrap(~Class, ncol=3)

ggplot(errors, aes(fill=Algorithm, y=Cluster.Error, x=Class)) + 
  geom_bar(position="dodge", stat="identity")

ggplot(errors, aes(fill=Algorithm, y=Subclass.Error, x=Class)) + 
  geom_bar(position="dodge", stat="identity")

ggplot(errors, aes(fill=Algorithm, y=Neighborhood.Error, x=Class)) + 
  geom_bar(position="dodge", stat="identity")
