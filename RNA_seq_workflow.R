# -------------------------------------------
## First we need to get the data
# this pulls airway smooth muscle cell data from GEO (NCBI's Gene Expression Omnibus)
# -------------------------------------------
suppressPackageStartupMessages( library( "GEOquery" ) )
suppressPackageStartupMessages( library( "airway" ) )
dir <- system.file("extdata",package="airway")
geofile <- file.path(dir, "GSE52778_series_matrix.txt")
gse <- getGEO(filename=geofile)
# -------------------------------------------
## File stored at:
## /tmp/RtmpfnHnCa/GPL11154.soft
# -------------------------------------------
## Columns are parsed and new column names and factor levels are added
# -------------------------------------------
pdata <- pData(gse)[,grepl("characteristics",names(pData(gse)))]
names(pdata) <- c("treatment","tissue","ercc_mix","cell","celltype")
pdataclean <- data.frame(treatment=sub("treatment: (.*)","\\1",pdata$treatment),
                         cell=sub("cell line: (.*)","\\1",pdata$cell),
                         row.names=rownames(pdata))
pdataclean$dex <- ifelse(grepl("Dex",pdataclean$treatment),"trt","untrt")
pdataclean$albut <- ifelse(grepl("Albut",pdataclean$treatment),"trt","untrt")
pdataclean$SampleName <- rownames(pdataclean)
pdataclean$treatment <- NULL
# -------------------------------------------
## Connect GEO sample info to the SRA (NCBI's Sequence Read Archive) run ID 
# -------------------------------------------
srafile <- file.path(dir, "SraRunInfo_SRP033351.csv")
srp <- read.csv(srafile)
srpsmall <- srp[,c("Run","avgLength","Experiment","Sample","BioSample","SampleName")]
# -------------------------------------------
## Merge the GEO and SRA data frames, keeping the subset of samples not treated with
## albuterol (not used in the publication)
# -------------------------------------------
coldata <- merge(pdataclean, srpsmall, by="SampleName")
rownames(coldata) <- coldata$Run
coldata <- coldata[coldata$albut == "untrt",]
coldata$albut <- NULL
coldata
# -------------------------------------------
## Save the sample data for future reference
# -------------------------------------------
write.csv(coldata, file="Documents/Data/R_practice/sample_table.csv")



