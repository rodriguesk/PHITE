#!/usr/bin/Rscript

#analyze CFmethylation data
#standalone script to run noninteractively

print("starting")
print(.libPaths())
#setwd("/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full")
#export LD_LIBRARY_PATH=/home/user/myproject/envs/default/lib
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/
  
#.libPaths("/home/kameronr/R/x86_64-pc-linux-gnu-library/4.1")

#print(.libPaths())

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

library(magrittr)
library(tidyverse)
library(ggrepel)
library(parallel)

# BiocManager::install("methylKit", force=TRUE )
library(methylKit)
library(ggbeeswarm)

#analysis guide
#https://compgenomr.github.io/book/data-filtering-and-exploratory-analysis.html

#https://bioconductor.riken.jp/packages/3.9/bioc/vignettes/methylKit/inst/doc/methylKit.html


path <- "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/"

coverage_files <- list.files(path, full.names=TRUE)[grep("CpG_report",list.files(path, full.names=TRUE))]

sample_file_path <- "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/expt_sample_descriptions.csv"
sample_sheet <- readr::read_csv(file = sample_file_path)

sample_sheet$file_path <- paste0(path,"/",sample_sheet$File, ".sorted.CpG_report.txt.gz")

#fix the sample sheet (correct for wrong index labels)
sample_corrections <- read.csv(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/NovaSeq_SampleList_20220502_correct_20230111.csv",header = TRUE,sep = ",", stringsAsFactors = FALSE)
sample_corrections <- sample_corrections %>% dplyr::select(sample_old, sample_corrected)

sample_sheet$id <- sample_sheet$File %>% str_extract(string = ., pattern = "S\\d+")

corrected_sample_sheet <- sample_sheet %>% dplyr::select(-c(expt_sample_id, participant_id, exercise_program, condition_id, week, condition)) %>% left_join(x = ., y = sample_corrections, by=c("id"="sample_old")) %>% left_join(x = ., y = sample_sheet %>% dplyr::select(c(id, expt_sample_id, participant_id, exercise_program, condition_id, week, condition)), by=c("sample_corrected"="id")) %>% dplyr::select(-sample_corrected)

sample_sheet <- corrected_sample_sheet



#D3a_0hr_D2_S3_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.bam.sorted.CpG_report.txt.gz

# simple_names <- sample_order <- str_match(string = coverage_files, pattern = "//(.*_.*)_(S.*)")[,2]

# sample_annotations <- data.frame(file_path=coverage_files, condition=simple_names, stringsAsFactors = FALSE)
# sample_annotations <- sample_annotations %>% mutate(stimulation_duration_hr = str_match(string = simple_names, pattern = ".*_(.*h)")[,2])
# sample_annotations$stimulation_duration_hr <- gsub(pattern = "h", replacement = "", x = sample_annotations$stimulation_duration_hr )
# sample_annotations <- sample_annotations %>% mutate(genotype = str_match(string = simple_names, pattern = "(D3a|WT|Tet)_(.*h)")[,2])
# sample_annotations <- sample_annotations %>% mutate(no_stimulation_control = grepl(pattern = "circ",x = simple_names))
# sample_annotations$genotype <- gsub(pattern = "Tet", replacement = "Tet2_KO", x = sample_annotations$genotype)
# sample_annotations$genotype <- gsub(pattern = "D3a", replacement = "Dnmt3a_KO", x = sample_annotations$genotype)
# sample_annotations <- sample_annotations %>% mutate(sample_id = str_match(string = coverage_files, pattern = "_(S.*)_(R.*)")[,2])

# sample_annotations <- sample_annotations %>% mutate(condition_id = paste0(genotype, "_",stimulation_duration_hr,"h_",no_stimulation_control))

sample_order <- sample_sheet %>% arrange(as.numeric(week)) %>% pull(file_path)

ordered_filter_to_just_samples_to_analyze <- sample_order

# samples_for_analysis_df <- sample_annotations %>% filter(!is.na(condition) & sample_id != "S14") %>% arrange(as.numeric(stimulation_duration_hr))
# samples_for_analysis_df <- sample_annotations %>% filter(!is.na(condition) & sample_id != "S14" & sample_id != "S13") %>% arrange(as.numeric(stimulation_duration_hr))

samples_for_analysis_df <- sample_sheet



# samples_for_analysis_df$sample <- paste0( samples_for_analysis_df$condition, "_", samples_for_analysis_df$sample_id)

file.list <- list(samples_for_analysis_df$file_path)

myobj <- methRead(as.list(samples_for_analysis_df$file_path),
                  sample.id=as.list(samples_for_analysis_df$expt_sample_id),
                  assembly="GRCh38",
                  pipeline="bismarkCytosineReport",
                  treatment=as.numeric(as.factor(samples_for_analysis_df$condition_id)),
                  context="CpG",
                  mincov = 3)

saveRDS(object = myobj, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/min_3_coverage_correct.rds")

#myobj <- readRDS(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/min_3_coverage_correct.rds")


tiles_500_5_3 <- tileMethylCounts(myobj, win.size=500, step.size=500, cov.bases = 5, mc.cores=16)
saveRDS(object = tiles_500_5_3, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_500_5_3_correct.rds")

#tiles_500_5_3 <- readRDS(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_500_5_3_correct.rds")


tiles_500_5_3.filt_30 <- filterByCoverage(tiles_500_5_3,
                                          lo.count=30,
                                          lo.perc=NULL,
                                          hi.count=NULL,
                                          hi.perc=99.9)


tiles_500_5_3.filt_30.norm <- normalizeCoverage(tiles_500_5_3.filt_30, method = "median")


meth <- unite(tiles_500_5_3.filt_30.norm, destrand=FALSE)

saveRDS(object = meth, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_500_5_3.filt_30.norm_united_correct.rds")

#meth <- readRDS(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_500_5_3.filt_30.norm_united_correct.rds")

print("done")










