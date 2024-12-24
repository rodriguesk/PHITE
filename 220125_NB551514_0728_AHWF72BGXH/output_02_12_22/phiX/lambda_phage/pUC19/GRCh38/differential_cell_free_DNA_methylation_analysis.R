#script to compare baseline DNA CpG methylation in Dnmt3a KO BMDM and Tet2 KO BMDM to WT BMDM.
#hopefully find that there are not much differences in methylation without LPS stimulation

#differential methylation is 1st determined by fisher's exact test.
#differential regional methylation is performed another method using: ____ ??? (TO DO: find method from literature)


#path <- "/oak/stanford/groups/sjaiswal/kameronr/sjaiswal_old/maurertm/methylseq/Old_Hiseq/results/results_2_2_2022/active_motif_control/zymo_control/pUC19_control/genome_alignment"
#path <- "/oak/stanford/groups/smontgom/kameronr/methylseq/JG97/hiseq/usftp21.novogene.com/pipeline_output/genome_alignment"
path <- "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/220125_NB551514_0728_AHWF72BGXH/output_02_12_22/phiX/lambda_phage/pUC19/GRCh38/"


#coverage_files <- list.files(path, full.names=TRUE)[grep("bismark.cov",list.files(path, full.names=TRUE))]
coverage_files <- list.files(path, full.names=TRUE)[grep("CpG_report",list.files(path, full.names=TRUE))]
# sample identities below:
# A1: WT_0h
# A2: Dnmt3a_KO_0h
# A3: Tet2_KO_0h




#Two step solution: Use coverage2cytosine to convert .cov file to an intermediate file. Then a one-liner awk command or some other script to convert the intermediate file to a methRead input file.
#The reason for this two-step process is that .cov lacks strand information.
#The intermediate file contains CG sites not covered by any read and you should discard those in your script.


#https://nbis-workshop-epigenomics.readthedocs.io/en/latest/content/tutorials/methylationSeq/Seq_Tutorial.html#single-cpg-sites



library(limma)
library(tidyverse)

#library(rnbeads) 
#can't use rnbeads because it only supports differential methylation analysis with welch (t-test) and linear models.

#because I don't have replicates, I have to use contingency tables. https://www.bioinformatics.babraham.ac.uk/training/Methylation_Course/Differential%20Methylation%20lecture.pdf
#must use either fisher's exact test or chi squared test

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("methylKit")

library("methylKit")

file.list <- list(coverage_files[1], coverage_files[2], coverage_files[3], coverage_files[4])

#[1] "A1_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.bam.sorted.bismark.cov.gz"          
#[2] "A2_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.bam.sorted.bismark.cov.gz"          
#[3] "A3_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.bam.sorted.bismark.cov.gz"          
#[4] "Undetermined_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.bam.sorted.bismark.cov.gz"

# read the files to a methylRawList object: myobj
myobj <- methRead(file.list[1:4],
                  sample.id=list("S1_EM_preE","S2_EM_postE","S3_ACEEL_postE", "S4_ACEEL_postE"),
                  assembly="GRCh38",
                  pipeline="bismarkCytosineReport",
                  treatment=c(0,1,1,1),
                  context="CpG",
                  mincov = 10)

myobj2 <- methRead(file.list[1:4],
                   sample.id=list("S1_EM_preE","S2_EM_postE","S3_ACEEL_postE", "S4_ACEEL_postE"),
                   assembly="GRCh38",
                   pipeline="bismarkCytosineReport",
                   treatment=c(0,1,1,1),
                   context="CpG",
                   mincov = 0)

myobj3 <- methRead(file.list[1:2],
                   sample.id=list("S1_EM_preE","S2_EM_postE"),
                   assembly="hg38",
                   pipeline="bismarkCytosineReport",
                   treatment=c(0,1),
                   context="CpG",
                   mincov = 10)

#GRCm38

# my.methRaw=processBismarkAln( location = 
#                                 system.file("extdata",
#                                             "test.fastq_bismark.sorted.min.sam", 
#                                             package = "methylKit"),
#                               sample.id="test1", assembly="hg18", 
#                               read.context="CpG", save.folder=getwd())

#name of the alignment pipeline, it can be either "bismark", "bismarkCoverage", "bismarkCytosineReport"

# If bismark coverage files are used the function will not have the strand information,so beware of that fact.

# With pipeline='bismarkCytosineReport', the function expects cytosine report files from Bismark, which have chr,start, strand, number of cytosines (methylated bases) , number of thymines (unmethylated bases),context and trinucletide context format

?processBismarkAln



# Get a histogram of the methylation percentage per sample
# Here for sample 1
getMethylationStats(myobj[[1]], plot=TRUE, both.strands=FALSE)
getMethylationStats(myobj[[2]], plot=TRUE, both.strands=FALSE)
getMethylationStats(myobj[[3]], plot=TRUE, both.strands=FALSE)

getMethylationStats(myobj[[1]], plot=TRUE, both.strands=TRUE)
getMethylationStats(myobj[[2]], plot=TRUE, both.strands=TRUE)
getMethylationStats(myobj[[3]], plot=TRUE, both.strands=TRUE)
getMethylationStats(myobj[[4]], plot=TRUE, both.strands=TRUE)




# Get a histogram of the read coverage per sample
getCoverageStats(myobj[[1]], plot=TRUE, both.strands=FALSE)
# Get percentile data by setting plot=FALSE
getCoverageStats(myobj[[1]], plot=FALSE, both.strands=FALSE)

getMethylationStats(myobj2[[1]], plot=TRUE, both.strands=FALSE)
getMethylationStats(myobj2[[2]], plot=TRUE, both.strands=FALSE)
getMethylationStats(myobj2[[3]], plot=TRUE, both.strands=FALSE)

# Get a histogram of the read coverage per sample
getCoverageStats(myobj2[[1]], plot=TRUE, both.strands=FALSE)
# Get percentile data by setting plot=FALSE
getCoverageStats(myobj2[[1]], plot=FALSE, both.strands=FALSE)


myobj.filt <- filterByCoverage(myobj,
                               lo.count=10,
                               lo.perc=NULL,
                               hi.count=NULL,
                               hi.perc=99.9)

myobj.filt <- filterByCoverage(myobj3,
                               lo.count=10,
                               lo.perc=NULL,
                               hi.count=NULL,
                               hi.perc=99.9)


myobj.filt.norm <- normalizeCoverage(myobj.filt, method = "median")

#extract the bases that are covered by reads in all our samples
meth <- unite(myobj.filt.norm, destrand=FALSE)

#Further Filtering #see: https://nbis-workshop-epigenomics.readthedocs.io/en/latest/content/tutorials/methylationSeq/Seq_Tutorial.html#further-filtering

# get percent methylation matrix
pm=percMethylation(meth)

# calculate standard deviation of CpGs
sds=matrixStats::rowSds(pm)

# Visualize the distribution of the per-CpG standard deviation
# to determine a suitable cutoff
hist(sds, breaks = 100)

# keep only CpG with standard deviations larger than 2%
meth <- meth[sds > 2]

# This leaves us with this number of CpG sites
nrow(meth)

#remove known C -> T mutations
# this will need to be coded up still!



getCorrelation(meth,plot=TRUE)
clusterSamples(meth, dist="correlation", method="ward", plot=TRUE)

PCASamples(meth)


# Test for differential methylation... This might take a few minutes.
myDiff <- calculateDiffMeth(meth,
                            overdispersion = "MN",
                            adjust="BH")
myDiff[myDiff$qvalue<0.05]

# Simple volcano plot to get an overview of differential methylation
plot(myDiff$meth.diff, -log10(myDiff$qvalue))
abline(v=0)




# Overview of percentage hyper and hypo CpGs per chromosome.
myDiff15p<-diffMethPerChr(myDiff, meth.cutoff = 15)
# get hyper methylated bases
myDiff15p.hyper=getMethylDiff(myDiff,difference=15,qvalue=0.01,type="hyper")
#
# get hypo methylated bases
myDiff15p.hypo=getMethylDiff(myDiff,difference=15,qvalue=0.01,type="hypo")


if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("genomation")

library(genomation)

#https://code.google.com/archive/p/methylkit/
#gene.obj=readTranscriptFeatures(system.file("extdata", "refseq.hg18.bed.txt", package = "methylKit"))


#annotateWithGeneParts(as(myDiff15p,"GRanges"),gene.obj)


#https://bioconductor.org/packages/devel/bioc/vignettes/methylKit/inst/doc/methylKit.html

# First load the annotation data; i.e the coordinates of promoters, TSS, intron and exons
refseq_anot <- readTranscriptFeatures("/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/hg38_annotations_genes.bed")

# Annotate hypermethylated CpGs ("target") with promoter/exon/intron
# information ("feature"). This function operates on GRanges objects, so we # first coerce the methylKit object to GRanges.
myDiff15p.hyper.anot <- annotateWithGeneParts(target = as(myDiff15p.hyper,"GRanges"),feature = refseq_anot)
myDiff15p.hypo.anot <- annotateWithGeneParts(target = as(myDiff15p.hypo,"GRanges"),feature = refseq_anot)

# Summary of target set annotation
myDiff15p.hyper.anot
myDiff15p.hypo.anot


#refseq_anot <- readTranscriptFeatures("/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/hg38_annotations_CpGs.bed")

# View the distance to the nearest Transcription Start Site; the target.row column in the output indicates the row number in the initial target set
dist_tss <- getAssociationWithTSS(myDiff25p.hyper.anot)
head(dist_tss)

# See whether the differentially methylated CpGs are within promoters,introns or exons; the order is the same as the target set
getMembers(myDiff25p.hyper.anot)

# This can also be summarized for all differentially methylated CpGs
plotTargetAnnotation(myDiff25p.hyper.anot, main = "Differential Methylation Annotation")

# Load the CpG info
cpg_anot <- readFeatureFlank("/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/hg38_annotations_CpGs.bed", feature.flank.name = c("CpGi", "shores"), flank=2000)
diffCpGann <- annotateWithFeatureFlank(as(myDiff25p,"GRanges"), feature = cpg_anot$CpGi, flank = cpg_anot$shores, feature.name = "CpGi", flank.name = "shores")

# See whether the CpG in myDiff25p belong to a CpG Island or Shore
head(getMembers(diffCpGann))

# This can also be summarized for all differentially methylated CpGs
plotTargetAnnotation(diffCpGann, main = "Differential Methylation Annotation")






# Reconstruct original object, keeping a lower coverage this time
myobj_lowCov_preE_and_postE <- methRead(file.list[c(1,2)],
                                          sample.id=list("S1_EM_preE","S2_EM_postE"),
                                          assembly="hg38",
                                          pipeline="bismarkCytosineReport",
                                          treatment=c(0,1),
                                          mincov = 3)




# Group the counts
tiles_1000_10 <- tileMethylCounts(myobj_lowCov_preE_and_postE,win.size=500,step.size=500,cov.bases = 10)

tiles_500_10 <- tileMethylCounts(myobj_lowCov_preE_and_postE,win.size=500,step.size=500,cov.bases = 10)

tiles_500_5 <- tileMethylCounts(myobj_lowCov_preE_and_postE,win.size=500,step.size=500,cov.bases = 5)

tiles_100_3 <- tileMethylCounts(myobj_lowCov_preE_and_postE,win.size=100,step.size=500,cov.bases = 3)


# Inspect data
head(tiles[[1]])


#filterByCoverage
#normalizeCoverage
#unite



# Get a histogram of the methylation percentage per sample
# Here for sample 1
getMethylationStats(tiles_WT_and_Dnmt3a_KO[[1]], plot=TRUE, both.strands=FALSE)
getMethylationStats(tiles_WT_and_Dnmt3a_KO[[2]], plot=TRUE, both.strands=FALSE)

getMethylationStats(tiles_WT_and_Tet2_KO[[1]], plot=TRUE, both.strands=FALSE)
getMethylationStats(tiles_WT_and_Tet2_KO[[2]], plot=TRUE, both.strands=FALSE)


# Get a histogram of the read coverage per sample
getCoverageStats(tiles_WT_and_Dnmt3a_KO[[1]], plot=TRUE, both.strands=FALSE)
# Get percentile data by setting plot=FALSE
getCoverageStats(tiles_WT_and_Dnmt3a_KO[[1]], plot=FALSE, both.strands=FALSE)

getCoverageStats(tiles_WT_and_Dnmt3a_KO[[2]], plot=TRUE, both.strands=FALSE)
getCoverageStats(tiles_WT_and_Dnmt3a_KO[[2]], plot=FALSE, both.strands=FALSE)

# Get a histogram of the read coverage per sample
getCoverageStats(tiles_WT_and_Tet2_KO[[1]], plot=TRUE, both.strands=FALSE)
# Get percentile data by setting plot=FALSE
getCoverageStats(tiles_WT_and_Tet2_KO[[1]], plot=FALSE, both.strands=FALSE)

getCoverageStats(tiles_WT_and_Tet2_KO[[2]], plot=TRUE, both.strands=FALSE)
getCoverageStats(tiles_WT_and_Tet2_KO[[2]], plot=FALSE, both.strands=FALSE)


getMethylationStats(tiles_WT_and_Dnmt3a_KO[[1]], plot=TRUE, both.strands=FALSE)
getMethylationStats(tiles_WT_and_Dnmt3a_KO[[2]], plot=TRUE, both.strands=FALSE)

getMethylationStats(tiles_WT_and_Tet2_KO[[1]], plot=TRUE, both.strands=FALSE)
getMethylationStats(tiles_WT_and_Tet2_KO[[2]], plot=TRUE, both.strands=FALSE)


# Get a histogram of the read coverage per sample
getCoverageStats(tiles_WT_and_Dnmt3a_KO[[1]], plot=TRUE, both.strands=FALSE)
# Get percentile data by setting plot=FALSE
getCoverageStats(tiles_WT_and_Dnmt3a_KO[[1]], plot=FALSE, both.strands=FALSE)

# Get a histogram of the read coverage per sample
getCoverageStats(tiles_WT_and_Tet2_KO[[1]], plot=TRUE, both.strands=FALSE)
# Get percentile data by setting plot=FALSE
getCoverageStats(tiles_WT_and_Tet2_KO[[1]], plot=FALSE, both.strands=FALSE)


Dnmt3a_KO_obj.filt <- filterByCoverage(tiles_WT_and_Dnmt3a_KO,
                                       lo.count=10,
                                       lo.perc=NULL,
                                       hi.count=NULL,
                                       hi.perc=99.9)

Tet2_KO_obj.filt <- filterByCoverage(tiles_WT_and_Tet2_KO,
                                     lo.count=10,
                                     lo.perc=NULL,
                                     hi.count=NULL,
                                     hi.perc=99.9)


Dnmt3a_KO_obj.filt.norm <- normalizeCoverage(Dnmt3a_KO_obj.filt, method = "median")

Tet2_KO_obj.filt.norm <- normalizeCoverage(Tet2_KO_obj.filt, method = "median")

#extract the bases that are covered by reads in all our samples
meth_WT_and_Dnmt3a_KO <- unite(Dnmt3a_KO_obj.filt.norm, destrand=FALSE)
meth_WT_and_Tet2_KO <- unite(Tet2_KO_obj.filt.norm, destrand=FALSE)


#Further Filtering #see: https://nbis-workshop-epigenomics.readthedocs.io/en/latest/content/tutorials/methylationSeq/Seq_Tutorial.html#further-filtering

# get percent methylation matrix
pm_Dnmt3a_KO=percMethylation(meth_WT_and_Dnmt3a_KO)
pm_Tet2_KO=percMethylation(meth_WT_and_Tet2_KO)

# calculate standard deviation of CpGs
sds_Dnmt3a_KO=matrixStats::rowSds(pm_Dnmt3a_KO)
sds_Tet2_KO=matrixStats::rowSds(pm_Tet2_KO)

# Visualize the distribution of the per-CpG standard deviation
# to determine a suitable cutoff
hist(sds_Dnmt3a_KO, breaks = 100)
hist(sds_Tet2_KO, breaks = 100)

# keep only CpG with standard deviations larger than 2%
meth_WT_and_Dnmt3a_KO <- meth_WT_and_Dnmt3a_KO[sds_Dnmt3a_KO > 2]
meth_WT_and_Tet2_KO <- meth_WT_and_Tet2_KO[sds_Tet2_KO > 2]

# This leaves us with this number of tiles
nrow(meth_WT_and_Dnmt3a_KO) #844711
nrow(meth_WT_and_Tet2_KO) #744246

#remove known C -> T mutations
# this will need to be coded up still!



getCorrelation(meth_WT_and_Dnmt3a_KO,plot=TRUE)
#clusterSamples(meth_WT_and_Dnmt3a_KO, dist="correlation", method="ward", plot=TRUE)

getCorrelation(meth_WT_and_Tet2_KO,plot=TRUE)
#clusterSamples(meth_WT_and_Tet2_KO, dist="correlation", method="ward", plot=TRUE)


#PCASamples(meth)


# Test for differential methylation... This might take a few minutes.
Dnmt3a_KO_diff <- calculateDiffMeth(meth_WT_and_Dnmt3a_KO,
                                    overdispersion = "MN",
                                    adjust="BH")

Tet2_KO_diff <- calculateDiffMeth(meth_WT_and_Tet2_KO,
                                  overdispersion = "MN",
                                  adjust="BH")





Dnmt3a_KO_diff
Dnmt3a_KO_diff[Dnmt3a_KO_diff$qvalue<0.05]
Tet2_KO_diff
Tet2_KO_diff[Tet2_KO_diff$qvalue<0.05]

# Simple volcano plot to get an overview of differential methylation
plot(Dnmt3a_KO_diff$meth.diff, -log10(Dnmt3a_KO_diff$qvalue))
abline(v=0)

plot(Tet2_KO_diff$meth.diff, -log10(Tet2_KO_diff$qvalue))
abline(v=0)


# Overview of percentage hyper and hypo CpGs per chromosome.
diffMethPerChr(Dnmt3a_KO_diff)
diffMethPerChr(Tet2_KO_diff)




#end of analysis
