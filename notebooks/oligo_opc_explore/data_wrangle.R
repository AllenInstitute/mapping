library(scattch.hicat)
library(scrattch.bigcat)

## Load data
norm.dat = readRDS("/allen/programs/celltypes/workgroups/rnaseqanalysis/Kelly/Aging_RNA_16roi_V3/data_oligo-opc/norm.dat.rds")
samp.dat = readRDS("/allen/programs/celltypes/workgroups/rnaseqanalysis/Kelly/Aging_RNA_16roi_V3/data_oligo-opc/samp.dat.rds")

## Create cluster object
cl = samp.dat$cl
names(cl) = samp.dat$sample_id


## Subsample because dataset is too large
select.cells = sample_cells(cl, 300)

cl.select = cl[select.cells]

## Get cl medians
cl.dat = get_cl_medians(norm.dat[,select.cells], cl.select)

cl.dat[1:5,1:5]


# using the required library
library(data.table)
setDT(cpm.data)
sparsify(cpm.data)
test_sparse <- Matrix(cpm.data, sparse = TRUE)


## Find common genes between query and ref
common.genes = intersect(row.names(cpm.data), row.names(cl.dat))

cl.dat.opc <- cl.dat[common.genes,]
external.opc <- cpm.data[common.genes,]

saveRDS(cl.dat.opc, file = "cl.dat.opc.RDS")
saveRDS(external.opc, file = "external.opc.RDS")

#find common genes using top n gene lists
common.genes.5 <- intersect(row.names(cpm.data), marker.genes.05) #insert your gene list 
cl.dat.opc_5gene <- cl.dat.opc[common.genes.5,]

common.genes.20 <- intersect(row.names(cpm.data), marker.genes.20) #insert your gene list
cl.dat.opc_20gene <- cl.dat.opc[common.genes.20,]


## Annotations
head(sample.name.conversion)
head(new.anno[,c("Sample_title", "inferred_cell_type")])
head(colnames(cpm.data2))
head((sample.name.conversion$Sample_title))
length(intersect(make.names(sample.name.conversion$Sample_title), colnames(cpm.data2)))
