#CF_DNA_methylation project PCA

.libPaths(c("/scg/apps/software/r/4.2.2/","/scg/apps/software/r/4.2.2/lib","/scg/apps/software/r/4.2.2/lib64/R/library","/home/kameronr/R/4.2.2","/home/kameronr/micromamba/lib/R/library","/oak/stanford/groups/smontgom/kameronr/r4.2.2/lib/R/library"))
.libPaths("/oak/stanford/groups/smontgom/kameronr/r4.2.2/lib/R/library")
# /home/kameronr/smontgom/kameronr/r4.2.2/lib/R/include
# .libPaths()


.libPaths(c("/home/kameronr/R/4.2.2","/home/kameronr/micromamba/lib/R/library","/oak/stanford/groups/smontgom/kameronr/r4.2.2/lib/R/library","/scg/apps/software/r/4.2.2/lib","/scg/apps/software/r/4.2.2/lib64/R/library"))

.libPaths("/oak/stanford/groups/smontgom/kameronr/r4.2.2/lib/R/library")
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")

library(magrittr)
library(tidyverse)
library(ggrepel)
library(parallel)

# BiocManager::install("methylKit", force=TRUE)
library(methylKit)
library(ggbeeswarm)
library(methylKit)
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

write.csv(x = sample_sheet, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/sample_sheet_for_publication?.csv")

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

saveRDS(object = myobj, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/min_3_coverage.rds")

myobj <- readRDS(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/min_3_coverage_correct.rds")


# myobj <- methRead(as.list(samples_for_analysis_df$file_path),
#                   sample.id=as.list(samples_for_analysis_df$expt_sample_id),
#                   assembly="GRCh38",
#                   pipeline="bismarkCytosineReport",
#                   treatment=as.numeric(as.factor(samples_for_analysis_df$condition_id)),
#                   context="CpG",
#                   mincov = 1)
# 
# saveRDS(object = myobj, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/min_1_coverage.rds")


# tiles_1000_20_1 <- tileMethylCounts(myobj, win.size=1000, step.size=1000, cov.bases = 20, mc.cores=8)
# saveRDS(object = tiles_1000_20, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_1000_20_1.rds")

tiles_500_5_3 <- tileMethylCounts(myobj, win.size=500, step.size=500, cov.bases = 5, mc.cores=16)
saveRDS(object = tiles_500_5_3, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_500_5_3.rds")

tiles_500_5_3 <- readRDS(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_500_5_3_correct.rds")


tiles_500_5_3.filt_30 <- filterByCoverage(tiles_500_5_3,
                               lo.count=30,
                               lo.perc=NULL,
                               hi.count=NULL,
                               hi.perc=99.9)


tiles_500_5_3.filt_30.norm <- normalizeCoverage(tiles_500_5_3.filt_30, method = "median")


meth <- unite(tiles_500_5_3.filt_30.norm, destrand=FALSE)

saveRDS(object = meth, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_500_5_3.filt_30.norm_united.rds")

meth <- readRDS(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_500_5_3.filt_30.norm_united_correct.rds")



mat <- getData(meth)
mat <- mat[ rowSums(is.na(mat))==0, ] 
meth.mat <- mat[, meth@numCs.index]/
  (mat[,meth@numCs.index] + mat[,meth@numTs.index] )                                      
names(meth.mat) <- meth@sample.ids

rows_sd <- rowSds(as.matrix(meth.mat), useNames=TRUE)
#sum(rows_sd > 0.25)
# sum(rows_sd > 0.1) #6279
# sum(rows_sd > 0.22) #72
# sum(rows_sd > 0) #98497

sd.threshold <- 0.1
#sd.threshold <- 0

meth.mat2 <- meth.mat[ rowSds(as.matrix(meth.mat), useNames=TRUE) > sd.threshold,]
x.pr <- prcomp(t(meth.mat2))
# loads <- x.pr$rotation
# treatment <- pooled.meth@treatment
# sample.ids <- pooled.meth@sample.ids
# my.cols <- rainbow(length(unique(treatment)), start=1, end=0.6)
pca_data <- as.data.frame(x.pr$x[,c("PC1","PC2")])
pca_data$sample_old <-  rownames(pca_data) # %>% gsub(pattern = "\\.1", replacement = "", x = .)

pca_data <- pca_data %>% left_join(x = ., y = sample_sheet %>% dplyr::select(-c(participant_id, exercise_program, condition_id, week, condition)) %>% left_join(x = ., y = sample_corrections, by=c("id"="sample_old")) %>% left_join(x = ., y = sample_sheet %>% dplyr::select(c(id, expt_sample_id, participant_id, exercise_program, condition_id, week, condition)), by=c("sample_corrected"="id")) %>% dplyr::select(-sample_corrected) %>% dplyr::select(c(expt_sample_id.x, expt_sample_id.y, exercise_program)), by = c("sample_old"="expt_sample_id.x"))

pca_data$sample <- pca_data$expt_sample_id.y

pca_data$condition_id <- samples_for_analysis_df$condition_id

# pca_data$id <- paste0(samples_for_analysis_df$sample_id,"_", samples_for_analysis_df$condition)
pca_data$id <- samples_for_analysis_df$expt_sample_id
prepost <- rep(0, length(samples_for_analysis_df$condition_id))
prepost[grep(pattern = "pre",samples_for_analysis_df$condition_id)] <- "before"
prepost[grep(pattern = "h0",samples_for_analysis_df$condition_id)] <- "after"
pca_data$prepost <- prepost
pc1_var <- round(x = summary(x.pr)$importance[2] * 100, 1)
pc2_var <-  round(x = summary(x.pr)$importance[5] * 100, 1)


pca_data <- pca_data %>% mutate(condition_id2 = case_when(
  condition_id == "w0pre" ~ "W0, before",
  condition_id == "w0h0" ~ "W0, after",
  condition_id == "w12pre" ~ "W12, before",
  condition_id == "w12h0" ~ "W12, after",
  condition_id == "w16rst" ~ "W16, rest"
))

pca_data$condition_id2 <- factor(x = pca_data$condition_id2, levels = c("W0, before","W0, after","W12, before","W12, after","W16, rest"))

ggplot(data = pca_data, mapping = aes(x=PC1, y=PC2, color=condition_id)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(values=c("tomato",  "steelblue1", "firebrick", "royalblue",  "black"))

ggplot(data = pca_data, mapping = aes(x=PC1, y=PC2, color=condition_id, shape=exercise_program)) + geom_point(size=4) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(values=c("tomato",  "steelblue1", "firebrick", "royalblue",  "black"))

ggplot(data = pca_data, mapping = aes(x=PC1, y=PC2, color=condition_id2, shape=exercise_program)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "black")) + theme(text = element_text(size=20))




pca_data2 <- pca_data %>% separate(data = ., col = id, sep = "_", into=c("participant"), extra = "drop")

pca_data3 <- pca_data2 %>% left_join(x = ., y = sample_sheet %>% dplyr::select(expt_sample_id, week), by=c("sample"="expt_sample_id"))

pca_data3 <- pca_data3 %>% arrange(participant, week, desc(prepost))



#does PC1 correlate to the amount of cell free DNA in the sample?
#does PC1 correlate to the amount of neutrophil proportion of origin fof the cell free DNA? 
#does the diff_PC1 correlate at all with the diff in amount of cell free DNA in the samples?
#does the diff_PC1 correlate at all with the diff in neutrophil proportion?

pca_data4 <- pca_data3 %>% left_join(x = ., y = celfie_data, by=c("sample"="sample"))
pca_data4 <- pca_data4 %>% left_join(x = ., y = amounts, by = c("sample"="sample"))


pca_data4 <- pca_data4 %>% arrange(participant.x, week.x, desc(prepost)) %>% mutate(timepoint_after_value_PC1 = lead(PC1), timepoint_after_value_PC2 = lead(PC2), timepoint_after_value_neutrophil = lead(neutrophil), timepoint_after_value_cfDNA_amount = lead(Sample.Total.cfDNA.ng.from.1ml.plasma)) 

pca_data4 <- pca_data4 %>% mutate(diff_PC1 = timepoint_after_value_PC1 - PC1, diff_PC2 =  timepoint_after_value_PC2 - PC2, diff_neutrophil = timepoint_after_value_neutrophil - neutrophil, fc_neutrophil = (timepoint_after_value_neutrophil - neutrophil)/neutrophil, diff_cfDNA_amount = timepoint_after_value_cfDNA_amount - Sample.Total.cfDNA.ng.from.1ml.plasma, fc_cfDNA_amount = (timepoint_after_value_cfDNA_amount - Sample.Total.cfDNA.ng.from.1ml.plasma)/Sample.Total.cfDNA.ng.from.1ml.plasma )

pca_data4 <- pca_data4 %>% arrange(participant.x, desc(prepost),  week.x,) %>% mutate(same_condition_after_value_PC1 = lead(PC1), same_condition_after_value_neutrophil = lead(neutrophil), same_condition_after_value_cfDNA_amount = lead(Sample.Total.cfDNA.ng.from.1ml.plasma)) 


ggplot(data = pca_data4 %>% filter(prepost %in% c("before","after")), mapping = aes(x= prepost, y= diff_PC1, shape=exercise_program)) + geom_point(size=5)

pca_data4 %>% filter(prepost == "before") %>% group_by(exercise_program) %>% summarize(average = mean(diff_PC1), sd = sd(diff_PC1))
#program A isn't very different from program B in terms of PC1


ggplot(data = pca_data4, mapping = aes(x=PC1, y=Sample.T)) + geom_point()
ggplot(data = pca_data4, mapping = aes(x=PC1, y=Sample.Total.cfDNA.ng.from.1ml.plasma)) + geom_point()

#PC1 seems to be capturing neutrophil amount and not cell free DNA amount... exercise intensity appears to have some affect how much DNA is in the plasma, but not the percent of neutrophils that make up that DNA? but if it's mainly neutrophils that create the DNA then shouldn't it be both are correlated? it's just because 2 participants have very very high amount of cell free DNA that occurs every time they exercise and they are both in group B. but otherwise the other people in group B look very much like group A...

ggplot(data = pca_data4 %>% filter(prepost == "before"),mapping = aes(x=diff_PC1, y=diff_cfDNA_amount) ) + geom_point()
ggplot(data = pca_data4 %>% filter(prepost == "before"),mapping = aes(x=diff_PC1, y=fc_cfDNA_amount) ) + geom_point()

ggplot(data = pca_data4 %>% filter(prepost == "before"),mapping = aes(x=diff_PC1, y=diff_neutrophil) ) + geom_point()
ggplot(data = pca_data4 %>% filter(prepost == "before"),mapping = aes(x=diff_PC1, y=log(fc_neutrophil)) ) + geom_point() #pretty well correlated

ggplot(data = pca_data4, mapping = aes(x=PC1, y=neutrophil, group = condition, color = condition, shape = exercise_program) ) + geom_point(size=4)
ggplot(data = pca_data4, mapping = aes(x=PC1, y=Sample.Total.cfDNA.ng.from.1ml.plasma, group = condition, color = condition, shape = exercise_program) ) + geom_point(size=4)


#not really any results for these
ggplot(data = pca_data4 %>% filter(prepost == "before"),mapping = aes(x=diff_PC2, y=diff_cfDNA_amount) ) + geom_point()
ggplot(data = pca_data4 %>% filter(prepost == "before"),mapping = aes(x=diff_PC2, y=fc_cfDNA_amount) ) + geom_point()

ggplot(data = pca_data4 %>% filter(prepost == "before"),mapping = aes(x=diff_PC2, y=diff_neutrophil) ) + geom_point()
ggplot(data = pca_data4 %>% filter(prepost == "before"),mapping = aes(x=diff_PC2, y=log(fc_neutrophil)) ) + geom_point() #pretty well correlated

ggplot(data = pca_data4, mapping = aes(x=PC2, y=neutrophil, group = condition, color = condition, shape = exercise_program) ) + geom_point(size=4)
ggplot(data = pca_data4, mapping = aes(x=PC2, y=Sample.Total.cfDNA.ng.from.1ml.plasma, group = condition, color = condition, shape = exercise_program) ) + geom_point(size=4)


cor.test(x=pca_data4$PC1,y=pca_data4$neutrophil)

#The percent neutrophil in the samples correspond strongly with PC1.
#Spearman correlation is 0.908 with p-value < 2.2e-16
#Pearson correlation is 0.848 with p-value = 9.409e-15




#connect points from same individual in the PCA
ggplot(data = pca_data3, mapping = aes(x=PC1, y=PC2, color=condition_id, group=participant)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(values=c("tomato",  "steelblue1", "firebrick", "royalblue",  "black"))+geom_line()

ggplot(data = pca_data3, mapping = aes(x=PC1, y=PC2, color=condition_id, group=interaction(participant,week))) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(values=c("tomato",  "steelblue1", "firebrick", "royalblue",  "black"))+geom_line()

ggplot(data = pca_data3, mapping = aes(x=PC1, y=PC2, color=condition_id, group=participant)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(values=c("tomato",  "steelblue1", "firebrick", "royalblue",  "black"))+geom_path()

ggplot(data = pca_data3, mapping = aes(x=PC1, y=PC2, color=condition_id, group=participant)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(values=c("tomato",  "steelblue1", "firebrick", "royalblue",  "black"))+geom_path()

ggplot(data = pca_data3 %>% filter(participant %in% c("PH138", "PH119")), mapping = aes(x=PC1, y=PC2, color=condition_id, group=participant)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(values=c("tomato",  "steelblue1", "firebrick", "royalblue",  "black"))+geom_path()





pca_data3 <- pca_data3 %>% arrange(participant, week, desc(prepost))

# pca_data3 %>% View()
pca_data3 <- pca_data3 %>% dplyr::select(PC1, PC2, sample_old, condition_id2) %>% separate(sample_old, into = c("participant", "exercise_program", "condition_id"), sep = "_", remove = FALSE) %>%  separate(condition_id2, into = c("week", "prepost2"), sep = ", ", remove = FALSE) %>% mutate(week = gsub(pattern = "W", replacement="", x=week))

ggplot(data = pca_data3, mapping = aes(x=PC1, y=PC2, color=condition_id2, shape=exercise_program, group=interaction(participant,week))) + geom_point(size=5, alpha=1) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "black"))+geom_line(alpha=0.45) + theme(text = element_text(size=20))

#this is the publication figure below. save it as pdf!

ggplot(data = pca_data3, mapping = aes(x=PC1, y=PC2, group=interaction(participant,week))) + 
  geom_point(size=5.5, alpha=0.8, aes(fill=condition_id2, shape=exercise_program)) + 
  xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + 
  theme_classic() + 
  theme(text = element_text(size=20), legend.position = c(.9, .85), legend.box.background = element_rect(color="black", size=0.3), legend.box.margin = margin(6, 6, 6, 6)) + 
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=participant), linewidth=0.04)


#+ scale_colour_manual(values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "black"))

pca_figure <- ggplot(data = pca_data3, mapping = aes(x=PC1, y=PC2, group=interaction(participant,week))) + 
  geom_point(size=5.5, alpha=0.8, aes(fill=condition_id2, shape=exercise_program)) + 
  xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + 
  theme_classic() + 
  theme(text = element_text(size=20), legend.position = c(.9, .85), legend.box.background = element_rect(color="black", size=0.3), legend.box.margin = margin(6, 6, 6, 6)) + 
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) #+
  #geom_line(mapping = aes(group=participant), linewidth=0.04)

pca_figure
write.csv(x = pca_data3, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/pca_cf_dna_methylation_pca.csv")

ggsave(filename = "pca_cf_dna_methylation_pca.pdf", plot = pca_figure, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "pca_cf_dna_methylation_pca.png", plot = pca_figure, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "pca_cf_dna_methylation_pca2.pdf", plot = pca_figure, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)
ggsave(filename = "pca_cf_dna_methylation_pca2.png", plot = pca_figure, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)



ggplot(data = pca_data3, mapping = aes(x=PC1, y=PC2, group=interaction(participant,week))) + 
  geom_point(size=5, alpha=0.8, aes(fill=condition_id2, shape=exercise_program)) + 
  xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + 
  theme_classic() + 
  theme(text = element_text(size=20), legend.position = c(.9, .85), legend.box.background = element_rect(color="black", size=0.3), legend.box.margin = margin(6, 6, 6, 6)) + 
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "black"),guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21)))+
  geom_line(alpha=0.45)
#+ scale_colour_manual(values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "black"))

ggplot(data = pca_data3, mapping = aes(x=PC1, y=PC2, group=participant)) + 
  geom_point(size=5, alpha=0.8, aes(fill=condition_id2, shape=exercise_program)) + 
  xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + 
  theme_classic() + 
  theme(text = element_text(size=20), legend.position = c(.9, .85), legend.box.background = element_rect(color="black", size=0.3), legend.box.margin = margin(6, 6, 6, 6)) + 
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "black"),guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21)))+
  geom_line(alpha=0.45)
#+ scale_colour_manual(values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "black"))

ggplot(data = pca_data3, mapping = aes(x=PC1, y=PC2, group=interaction(participant, prepost))) + 
  geom_point(size=5, alpha=0.8, aes(fill=condition_id2, shape=exercise_program)) + 
  xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + 
  theme_classic() + 
  theme(text = element_text(size=20), legend.position = c(.9, .85), legend.box.background = element_rect(color="black", size=0.3), legend.box.margin = margin(6, 6, 6, 6)) + 
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "black"),guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21)))+
  geom_line(alpha=0.45)



ggplot(data = pca_data3, mapping = aes(x=condition_id2, y=PC1, group=interaction(participant, prepost))) + 
  geom_point(size=5, alpha=0.8, aes(fill=condition_id2, shape=exercise_program)) + 
  xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + 
  theme_classic() + 
  theme(text = element_text(size=20), legend.position = c(.9, .85), legend.box.background = element_rect(color="black", size=0.3), legend.box.margin = margin(6, 6, 6, 6)) + 
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "black"),guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21)))+
  geom_line(alpha=0.45)+
  geom_boxplot()

ggplot(data = pca_data3, mapping = aes(x=condition_id2, y=PC1))+
  geom_boxplot()

#plot the distribution of the difference W0 before to W0 after compared to W12 before to W12 after.
ggplot(data = pca_data4, mapping = aes(x=week.y, y=diff_PC1))+
  geom_boxplot()

ggplot(data = pca_data4 %>% filter(prepost=="before"), mapping = aes(x=week.y, y=diff_PC1, group=interaction(participant.y, prepost))) + 
  geom_point(size=5, alpha=0.8, aes(fill=condition_id2, shape=exercise_program)) + 
  xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + 
  theme_classic() + 
  theme(text = element_text(size=20), legend.position = c(.9, .85), legend.box.background = element_rect(color="black", size=0.3), legend.box.margin = margin(6, 6, 6, 6)) + 
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "black"),guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21)))+
  geom_line(alpha=0.45)

(pca_data4 %>% filter(prepost=="before", week.x==12) %>% pull(diff_PC1)) - (pca_data4 %>% filter(prepost=="before", week.x==0) %>% pull(diff_PC1)) 

(pca_data4 %>% filter(prepost=="before", week.x==12) %>% pull(diff_PC1)) - (pca_data4 %>% filter(prepost=="before", week.x==0) %>% pull(diff_PC1)) 

t.test((pca_data4 %>% filter(prepost=="before", week.x==0) %>% pull(diff_PC1)), (pca_data4 %>% filter(prepost=="before", week.x==12) %>% pull(diff_PC1)), paired=TRUE)

pca_data4 %>% filter(prepost == "before", week.x==0) %>% pull(PC1)
pca_data4 %>% filter(prepost == "before", week.x==0) %>% pull(participant.x)

pca_data4 %>% filter(prepost == "before", week.x==12) %>% pull(PC1)
pca_data4 %>% filter(prepost == "before", week.x==12) %>% pull(participant.x)


t.test(pca_data4 %>% filter(prepost == "before", week.x==0) %>% pull(PC1), pca_data4 %>% filter(prepost == "before", week.x==12) %>% pull(PC1), paired=TRUE)
#p-value = 0.1438

pca_data4 %>% filter(prepost == "after", week.x==0) %>% pull(PC1)
pca_data4 %>% filter(prepost == "after", week.x==12) %>% pull(PC1)
pca_data4 %>% filter(prepost == "after", week.x==0) %>% pull(participant.x)
pca_data4 %>% filter(prepost == "after", week.x==12) %>% pull(participant.x)

t.test(pca_data4 %>% filter(prepost == "after", week.x==0) %>% pull(PC1), pca_data4 %>% filter(prepost == "after", week.x==12) %>% pull(PC1), paired=TRUE)
#p-value = 0.937


t.test(pca_data4 %>% filter(prepost == "before", week.x==0) %>% pull(neutrophil), pca_data4 %>% filter(prepost == "before", week.x==12) %>% pull(neutrophil), paired=TRUE)
#p-value = 0.03197

t.test(pca_data4 %>% filter(prepost == "after", week.x==0) %>% pull(neutrophil), pca_data4 %>% filter(prepost == "after", week.x==12) %>% pull(neutrophil), paired=TRUE)
#p-value = 0.1543

#plot the training effect in neutrophil cf DNA proportion for before exercise.
ggplot(data = pca_data4 %>% filter( prepost %in% c("before")), mapping = aes(x = week.y, y = neutrophil, group=interaction(participant.y, prepost)))+
  geom_point(size=5, alpha=0.8, aes(fill=condition_id2, shape=exercise_program)) + 
  xlab("week") + ylab("neutrophil (%)") + 
  theme_classic() + 
  theme(text = element_text(size=20), legend.position = c(.9, .85), legend.box.background = element_rect(color="black", size=0.3), legend.box.margin = margin(6, 6, 6, 6)) + 
  scale_fill_manual(name = "condition", values=c("steelblue1",  "royalblue"),guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21)))+
  geom_line(alpha=0.45)

ggplot(data = pca_data4 %>% filter( prepost %in% c("before")), mapping = aes(x = week.y, y = log(neutrophil), group=interaction(participant.y, prepost)))+
  geom_point(size=5, alpha=0.8, aes(fill=condition_id2, shape=exercise_program)) + 
  xlab("week") + ylab("neutrophil (log %)") + 
  theme_classic() + 
  theme(text = element_text(size=20), legend.position = c(.9, .85), legend.box.background = element_rect(color="black", size=0.3), legend.box.margin = margin(6, 6, 6, 6)) + 
  scale_fill_manual(name = "condition", values=c("steelblue1",  "royalblue"),guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21)))+
  geom_line(alpha=0.45)


ggplot(data = pca_data4 %>% filter( prepost %in% c("after")), mapping = aes(x = week.y, y = neutrophil, group=interaction(participant.y, prepost)))+
  geom_point(size=5, alpha=0.8, aes(fill=condition_id2, shape=exercise_program)) + 
  xlab("week") + ylab("neutrophil (%)") + 
  theme_classic() + 
  theme(text = element_text(size=20), legend.position = c(.9, .85), legend.box.background = element_rect(color="black", size=0.3), legend.box.margin = margin(6, 6, 6, 6)) + 
  scale_fill_manual(name = "condition", values=c("tomato",  "firebrick"),guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21)))+
  geom_line(alpha=0.45)



#neutrophil counts 
ggplot(data = pca_data4, mapping = aes(x = week.y, y = neutrophil, group=interaction(participant.y, prepost)))+
  geom_point(size=5, alpha=0.8, aes(fill=condition_id2, shape=exercise_program)) + 
  xlab("week") + ylab("neutrophil (%)") + 
  theme_classic() + 
  theme(text = element_text(size=20), legend.position = c(.9, .85), legend.box.background = element_rect(color="black", size=0.3), legend.box.margin = margin(6, 6, 6, 6)) + 
  scale_fill_manual(name = "condition", values=c("steelblue1","tomato", "royalblue", "firebrick","black"),guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21)))+
  geom_line(alpha=0.45)


t.test(pca_data4 %>% filter(prepost == "before", week.x==0) %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma), pca_data4 %>% filter(prepost == "before", week.x==12) %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma), paired=TRUE)
#p-value = 0.1291

t.test(pca_data4 %>% filter(prepost == "after", week.x==0) %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma), pca_data4 %>% filter(prepost == "after", week.x==12) %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma), paired=TRUE)
#p-value = 0.1111

t.test(pca_data4 %>% filter(prepost == "before", week.x==0) %>% pull(neutrophil), pca_data4 %>% filter(prepost == "before", week.x==12) %>% pull(neutrophil), paired=TRUE)
#p-value = 0.03197

t.test(pca_data4 %>% filter(prepost == "after", week.x==0) %>% pull(neutrophil), pca_data4 %>% filter(prepost == "after", week.x==12) %>% pull(neutrophil), paired=TRUE)
#p-value = 0.1543

t.test((pca_data4 %>% filter(prepost == "before", week.x==0) %>% pull(fc_cfDNA_amount)), (pca_data4 %>% filter(prepost == "before", week.x==12) %>% pull(fc_cfDNA_amount)), paired=TRUE )
#p-valuee = 0.5406

t.test((pca_data4 %>% filter(prepost == "before", week.x==0) %>% pull(diff_cfDNA_amount)), (pca_data4 %>% filter(prepost == "before", week.x==12) %>% pull(diff_cfDNA_amount)), paired=TRUE )
#p-value = 0.1379

#no training effect for cell free DNA amounts

#but is there a difference in cell free DNA amounts at all for any of the condition comparisons between program A participants and program B participants?
#week 0 before exercise (A) vs week 0 before exercise (B)
#week 12 before exercise (A) vs week 12 before exercise (B)
#week 0 and 12 before exercise (A) vs week 0 and 12 before exercise (B)

t.test(
  (pca_data4 %>% filter(prepost == "before", week.x==0, program=="A") %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma)),
(pca_data4 %>% filter(prepost == "before", week.x==0, program=="B") %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma)),
paired=FALSE
) #p-value=0.1153

t.test(
(pca_data4 %>% filter(prepost == "after", week.x==0, program=="A") %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma)),
(pca_data4 %>% filter(prepost == "after", week.x==0, program=="B") %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma)),
paired=FALSE
) #p-value=0.15


t.test(
  (pca_data4 %>% filter(prepost == "after", week.x %in% c(0,12), program=="A") %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma)),
  (pca_data4 %>% filter(prepost == "after", week.x %in% c(0,12), program=="B") %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma)),
  paired=FALSE
) #p-value=0.05831


t.test(
(pca_data4 %>% filter(prepost == "before", week.x==12, program=="A") %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma)),
(pca_data4 %>% filter(prepost == "before", week.x==12, program=="B") %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma)),
paired=FALSE
) #p-value=0.4725

t.test(
(pca_data4 %>% filter(prepost == "after", week.x==12, program=="A") %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma)),
(pca_data4 %>% filter(prepost == "after", week.x==12, program=="B") %>% pull(Sample.Total.cfDNA.ng.from.1ml.plasma)),
paired=FALSE
) #p-value=0.2334

t.test(
(pca_data4 %>% filter(prepost == "before", week.x==0, program=="A") %>% pull(diff_cfDNA_amount)),
(pca_data4 %>% filter(prepost == "before", week.x==0, program=="B") %>% pull(diff_cfDNA_amount)),
paired=FALSE
) #p-value=0.157

t.test(
(pca_data4 %>% filter(prepost == "before", week.x==12, program=="A") %>% pull(diff_cfDNA_amount)),
(pca_data4 %>% filter(prepost == "before", week.x==12, program=="B") %>% pull(diff_cfDNA_amount)),
paired=FALSE
) #p-value=0.2488


t.test(
(pca_data4 %>% filter(prepost == "before", week.x %in% c(0,12), program=="A") %>% pull(diff_cfDNA_amount)),
(pca_data4 %>% filter(prepost == "before", week.x %in% c(0,12), program=="B") %>% pull(diff_cfDNA_amount)),
paired=FALSE
) #p-value=0.06416


t.test(
(pca_data4 %>% filter(prepost == "before", week.x==0, program=="A") %>% pull(fc_cfDNA_amount)),
(pca_data4 %>% filter(prepost == "before", week.x==0, program=="B") %>% pull(fc_cfDNA_amount)),
paired=FALSE
) #p-value=0.2243
t.test(
(pca_data4 %>% filter(prepost == "before", week.x==12, program=="A") %>% pull(fc_cfDNA_amount)),
(pca_data4 %>% filter(prepost == "before", week.x==12, program=="B") %>% pull(fc_cfDNA_amount)),
paired=FALSE
) #p-value=0.3506
t.test(
(pca_data4 %>% filter(prepost == "before", week.x %in% c(0,12), program=="A") %>% pull(fc_cfDNA_amount)),
(pca_data4 %>% filter(prepost == "before", week.x %in% c(0,12), program=="B") %>% pull(fc_cfDNA_amount)),
paired=FALSE
) #p-value=0.09527


#many comparisons to show differences in exercise programs A vs B were very near to being significant... need larger sample size. Also might be able to show difference if we could normalize or take into account the physical phenotype data.




ggplot(data= pca_data4, mapping = aes(x=interaction(exercise,week.x), y=diff_PC1))+
  geom_point()

pca_data4 %>% filter(prepost %in% c("before")) %>% group_by(week.x) %>% ggplot(data = ., mapping = aes(x=interaction(week.x, prepost), y=diff_PC1)) + geom_point() + geom_boxplot()

pca_data4 %>% filter(prepost %in% c("before")) %>% group_by(week.x) %>% filter(week.x==0) %>% pull(diff_PC1)
pca_data4 %>% filter(prepost %in% c("before")) %>% group_by(week.x) %>% filter(week.x==12) %>% pull(diff_PC1)

t.test(pca_data4 %>% filter(prepost %in% c("before")) %>% group_by(week.x) %>% filter(week.x==0) %>% pull(diff_PC1), pca_data4 %>% filter(prepost %in% c("before")) %>% group_by(week.x) %>% filter(week.x==12) %>% pull(diff_PC1), paired=TRUE)
#p-value = 0.07261


pca_data4 %>% filter(prepost %in% c("before", "after")) %>% ggplot(data = ., mapping = aes(x=prepost, y=timepoint_after_value_PC1-PC1)) + geom_point() + geom_boxplot()

pca_data4 %>% filter(prepost %in% c("before", "after"))  %>% View()

pca_data4 %>% filter(prepost %in% c("before", "after")) %>% ggplot(data = ., mapping = aes(x=prepost, y=timepoint_after_value_neutrophil-neutrophil)) + geom_point() + geom_boxplot()


# ggplot(data = pca_data3, mapping = aes(x=PC1, y=PC2, group=interaction(participant,week), fill=condition_id2)) + geom_point(size=5, alpha=1, aes(fill=condition_id2, shape=exercise_program)) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + theme(text = element_text(size=20)) + scale_fill_manual(name="condition",values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "black")) + scale_shape_manual(values=c(21,24)) +  guides(fill = guide_legend(override.aes = list(shape = 21)))#+ scale_colour_manual(values=c("steelblue1",  "tomato", "royalblue", "firebrick",  "black"))

#+guides(fill = guide_legend(override.aes = list(shape = 21)))

#+scale_color_identity(guide = 'legend')
#+guides(fill="legend")
#guide = guide_legend(override.aes = list(size = 3,alpha = 1)





sd.threshold <- 0
sd.threshold <- 0.15

meth.mat2 <- meth.mat[ rowSds(as.matrix(meth.mat)) > sd.threshold,]
meth.mat2 <- meth.mat2[,sample_sheet %>% filter(condition_id != "w16rst") %>% pull(expt_sample_id)]
x.pr <- prcomp(t(meth.mat2))
# loads <- x.pr$rotation
# treatment <- pooled.meth@treatment
# sample.ids <- pooled.meth@sample.ids
# my.cols <- rainbow(length(unique(treatment)), start=1, end=0.6)
pca_data <- as.data.frame(x.pr$x[,c("PC1","PC2")])
pca_data$sample <-  rownames(pca_data) # %>% gsub(pattern = "\\.1", replacement = "", x = .)
pca_data$condition_id <-   samples_for_analysis_df %>% filter(condition_id != "w16rst") %>% pull(condition_id)

# pca_data$id <- paste0(samples_for_analysis_df$sample_id,"_", samples_for_analysis_df$condition)
pca_data$id <- samples_for_analysis_df %>% filter(condition_id != "w16rst") %>% pull(expt_sample_id)
prepost <- rep(0, length(pca_data$condition_id))
prepost[grep(pattern = "pre",pca_data$condition_id)] <- "before"
prepost[grep(pattern = "h0",pca_data$condition_id)] <- "after"
pca_data$prepost <- prepost
pc1_var <- round(x = summary(x.pr)$importance[2] * 100, 1)
pc2_var <-  round(x = summary(x.pr)$importance[5] * 100, 1)

ggplot(data = pca_data %>% filter(condition_id != "w16rst") , mapping = aes(x=PC1, y=PC2, group=prepost, color=prepost)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(values=c("red","blue"))







# jpeg("biplot.jpg")
pdf(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/PCA_tiles_500_5_3.filt_30.norm_united.pdf", width = 20, height = 10)

ggplot(data = pca_data %>% filter(condition_id != "w16rst"), mapping = aes(x=PC1, y=PC2, label=id, group=condition_id, color=condition_id)) + geom_point(size=5) + geom_text_repel(max.overlaps=30) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic()

ggplot(data = pca_data , mapping = aes(x=PC1, y=PC2, label=id, group=condition_id, color=condition_id)) + geom_point(size=5) + geom_text_repel(max.overlaps=30) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic()

ggplot(data = pca_data , mapping = aes(x=PC1, y=PC2, group=condition_id, color=condition_id)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic()

ggplot(data = pca_data %>% filter(condition_id != "w16rst") , mapping = aes(x=PC1, y=PC2, group=condition_id, color=condition_id)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic()

ggplot(data = pca_data %>% filter(condition_id != "w16rst") , mapping = aes(x=PC1, y=PC2, group=prepost, color=prepost)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic()

# ggplot(data = pca_data, mapping = aes(x=PC1, y=PC2, group=condition_id)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(group=prepost, values=setNames(c( "steelblue1", "tomato", "royalblue", "firebrick", "black"), c("w0pre", "w0h0", "w12pre", "w12h0", "w16rst")))

# ggplot(data = pca_data, mapping = aes(x=PC1, y=PC2, group=condition_id, color=condition_id)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(group=prepost, values=setNames(c( "steelblue1", "tomato", "royalblue", "firebrick", "black"), c("w0pre", "w0h0", "w12pre", "w12h0", "w16rst")))

ggplot(data = pca_data, mapping = aes(x=PC1, y=PC2, color=condition_id)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(values=c( "steelblue1", "tomato", "royalblue", "firebrick", "black"))

ggplot(data = pca_data %>% filter(condition_id != "w16rst") , mapping = aes(x=PC1, y=PC2, group=prepost, color=prepost)) + geom_point(size=5) + xlab(paste0("PC1 ( ", pc1_var, "% variance explained )")) + ylab(paste0("PC2 ( ", pc2_var, "% variance explained )")) + theme_classic() + scale_colour_manual(values=c("red","blue"))



dev.off()












#differential cell free DNA methylation analysis... paired tests for more power! only test, before and after
library(lme4)
library(lmerTest)
#https://www.rensvandeschoot.com/tutorials/lme4/

# interceptonlymodel <- lmer(formula = popular ~ 1 + (1|class),
#                            data    = popular2data) #to run the model

#the paired t-test’s analog in the linear modeling framework is the linear mixed model with varying intercepts.
#https://vasishth.github.io/Freq_CogSci/from-the-paired-t-test-to-the-linear-mixed-model.html


#organize the data into mvalues for each participant
#then fit to mixed linear model




# lmer(y ~ cond + (1 | subj), dat))
library(methylKit)
meth <- readRDS(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_500_5_3.filt_30.norm_united_correct.rds")


mat <- methylKit::getData(meth)
mat <- mat[ rowSums(is.na(mat))==0, ] 
meth.mat <- mat[, meth@numCs.index]/
  (mat[,meth@numCs.index] + mat[,meth@numTs.index] )                                      
names(meth.mat) <- meth@sample.ids



rows_sd <- rowSds(as.matrix(meth.mat))

hist(rows_sd)
data.frame(sd=rows_sd) %>% ggplot(data = ., mapping = aes(x=sd)) + geom_histogram(bins = 50) + theme_classic() + xlim(c(0,0.15))

data.frame(sd=rows_sd) %>% filter(sd > 0.025) %>% ggplot(data = ., mapping = aes(x=sd)) + geom_histogram(bins = 50) + theme_classic() + xlim(c(0,0.15))

#sum(rows_sd > 0.25)
# sum(rows_sd > 0.1) #6279
# sum(rows_sd > 0.22) #72
# sum(rows_sd > 0) #98497

#standard deviation filter because 80% of DNA methylation doesn't vary between cell types
sd.threshold <- 0.1

# sd.threshold <- 0.025

#or maybe do filtering later?

#sd.threshold <- 0

meth.mat2 <- meth.mat[ rowSds(as.matrix(meth.mat)) > sd.threshold,]

descriptions <-  methylKit::getData(meth)[ rowSds(as.matrix(meth.mat)) > sd.threshold,c("chr","start","end")]

#log2(beta)/(1-beta)

#add some value to avoid log(0) and subtract some value to avoid log(infinity)? just add 0.00000001 if 0 and subtract 0.00000001 if 1 ???
#find where values are 0.
#can do this with a different function other than adding small value and subtracting small value...
#meth.mat2[meth.mat2 == 0] <- 0.00000001
#meth.mat2[meth.mat2 == 1] <- 1-0.00000001
meth.mat2_df <- as.data.frame(meth.mat2)
meth.mat2_df$row_names <- rownames(meth.mat2)
meth.mat2_longform <- meth.mat2_df %>% pivot_longer(data = ., cols = colnames(meth.mat2_df)[1:50], names_to = "sample", values_to = "meth" )
meth.mat2_longform$meth_bounded <- (meth.mat2_longform$meth * (length(meth.mat2_longform$meth) - 1) + 0.5) / length(meth.mat2_longform$meth)  
meth_mat2_bounded_df <- meth.mat2_longform %>% pivot_wider(data = ., id_cols = "row_names", names_from = "sample", values_from = "meth_bounded") %>% as.data.frame()
rownames(meth_mat2_bounded_df) <- meth_mat2_bounded_df$row_names
meth_mat2_bounded <- meth_mat2_bounded_df %>% select(-c("row_names")) %>% as.matrix()

meth.mat3 <- log2(meth_mat2_bounded/(1-meth_mat2_bounded))
names(meth.mat3) <- meth@sample.ids

meth.mat_beta_values <- meth.mat2


#make data longform format?
meth.mat4 <- cbind(meth.mat3, descriptions) 
meth.mat4_longform <- meth.mat4 %>% pivot_longer(data = ., cols = colnames(meth.mat4)[1:50], names_to = "sample", values_to = "M_value")
#merge with participant information
meth.mat4_longform2 <- meth.mat4_longform %>% left_join(x = ., y = sample_sheet[,c("expt_sample_id","participant_id", "week", "condition_id", "condition", "exercise_program")], by=c("sample"="expt_sample_id"))


meth.mat_beta_values2 <- cbind(meth.mat_beta_values, descriptions) 
meth.mat_beta_values3_longform <- meth.mat_beta_values2 %>% pivot_longer(data = ., cols = colnames(meth.mat_beta_values2)[1:50], names_to = "sample", values_to = "b_value")
#merge with participant information
meth.mat_beta_values3_longform2 <- meth.mat_beta_values3_longform %>% left_join(x = ., y = sample_sheet[,c("expt_sample_id","participant_id", "week", "condition_id", "condition", "exercise_program")], by=c("sample"="expt_sample_id"))


#Replace NaN & Inf with NA ???
#df[is.na(df) | df=="Inf"] = NA

#or keep values as beta values instead of m values?

#add 1 to avoid log(0) ? seems best to me? or just add 0.00000001 if 0 and subtract 0.00000001 if 1 ???




#now fit to mixed linear model
#http://www2.compute.dtu.dk/courses/02930/SummerschoolMaterialWeb/Readingmaterial/MixedModels-TuesdayandFriday/Packageandtutorialmaterial/lmerTestTutorial.pdf
#https://jontalle.web.engr.illinois.edu/MISC/lme4/bw_LME_tutorial.pdf
#https://cran.r-project.org/web/packages/lme4/vignettes/lmer.pdf

#make relevant variables into factors:
meth.mat4_longform2$participant_id <- factor(meth.mat4_longform2$participant_id)
meth.mat4_longform2$week <- factor(meth.mat4_longform2$week)
meth.mat4_longform2$condition <- factor(x=meth.mat4_longform2$condition, levels = c("pre_exercise", "post_exercise"))
meth.mat4_longform2$region <- paste0(meth.mat4_longform2$chr, "_",meth.mat4_longform2$start,"_", meth.mat4_longform2$end)
# meth.mat4_longform2$region <- as.character(meth.mat4_longform2$region)
#remove the rest data 
meth.mat4_longform2_nonrest <- meth.mat4_longform2 %>% filter(week != "16")

#make relevant variables into factors:
meth.mat_beta_values3_longform2$participant_id <- factor(meth.mat_beta_values3_longform2$participant_id)
meth.mat_beta_values3_longform2$week <- factor(meth.mat_beta_values3_longform2$week)
meth.mat_beta_values3_longform2$condition <- factor(x=meth.mat_beta_values3_longform2$condition, levels = c("pre_exercise", "post_exercise"))
meth.mat_beta_values3_longform2$region <- paste0(meth.mat_beta_values3_longform2$chr, "_",meth.mat_beta_values3_longform2$start,"_", meth.mat_beta_values3_longform2$end)
# meth.mat4_longform2$region <- as.character(meth.mat4_longform2$region)
#remove the rest data 
meth.mat_beta_values3_longform2_nonrest <- meth.mat_beta_values3_longform2 %>% filter(week != "16")


meth.mat4_longform2 <- meth.mat4_longform2 %>% mutate(condition_id = case_when(
  week == "0" & condition == "pre_exercise" & exercise_program == "A" ~ "w0_pre_A",
  week == "0" & condition == "pre_exercise" & exercise_program == "B" ~ "w0_pre_B",
  week == "0" & condition == "post_exercise" & exercise_program == "A" ~ "w0_post_A",
  week == "0" & condition == "post_exercise" & exercise_program == "B" ~ "w0_post_B",
  week == "12" & condition == "pre_exercise" & exercise_program == "A" ~ "w12_pre_A",
  week == "12" & condition == "pre_exercise" & exercise_program == "B" ~ "w12_pre_B",
  week == "12" & condition == "post_exercise" & exercise_program == "A" ~ "w12_post_A",
  week == "12" & condition == "post_exercise" & exercise_program == "B" ~ "w12_post_B",
  week == "16" & exercise_program == "A" ~ "w16_rest_A",
  week == "16" & exercise_program == "B" ~ "w16_rest_B"
))

meth.mat4_longform2$condition_id <- factor(meth.mat4_longform2$condition_id, levels = c("w0_pre_A",	"w0_pre_B", "w0_post_A", "w0_post_B", "w12_pre_A", "w12_pre_B", "w12_post_A", "w12_post_B", "w16_rest_A", "w16_rest_B"))





# lmer0 <- lmer(M_value~condition+(1|participant_id)+(1|week), data=meth.mat4_longform2_nonrest)
lmer0 <- lmer(M_value ~ condition + (1|participant_id), data=meth.mat4_longform2_nonrest %>% filter(region == "chr1_189001_189500"))
lmer0 <- lmer(M_value~condition+(1|participant_id), data=meth.mat4_longform2_nonrest %>% filter(region == "chr1_834501_835000"))
lmer0 <- lmer(M_value~condition+(1|participant_id), data=meth.mat4_longform2_nonrest %>% filter(region == "chr1_191501_192000"))

lmer0 <- lmer(M_value ~ condition + (1|participant_id), data=meth.mat4_longform2_nonrest %>% filter(region == "chr1_189001_189500"), REML=FALSE)
lmer0 <- lmer(M_value ~ condition + week + exercise_program + (1|participant_id), data=meth.mat4_longform2_nonrest %>% filter(region == "chr1_189001_189500"))

lmer0 <- lmer(M_value ~ condition + (1|participant_id), data=meth.mat4_longform2_nonrest %>% filter(region == "chr1_189001_189500"), REML=FALSE)
lmer0 <- lmer(M_value ~ condition + (1+condition|participant_id), data=meth.mat4_longform2_nonrest %>% filter(region == "chr1_189001_189500"), REML=FALSE)


summary(lmer0)


library(ggbeeswarm)
ggplot(data = meth.mat4_longform2_nonrest %>% filter(region == "chr1_189001_189500"), mapping = aes(x= condition, y = M_value, color=week)) + geom_beeswarm()
ggplot(data = meth.mat4_longform2_nonrest %>% filter(region == "chr1_834501_835000"), mapping = aes(x= condition, y = M_value)) + geom_beeswarm()
ggplot(data = meth.mat4_longform2_nonrest %>% filter(region == "chr1_191501_192000"), mapping = aes(x= condition, y = M_value)) + geom_beeswarm()
ggplot(data = meth.mat4_longform2_nonrest %>% filter(region == "chr1_189001_189500"), mapping = aes(x= condition, y = M_value)) + geom_beeswarm()
ggplot(data = meth.mat4_longform2_nonrest %>% filter(region == "chr1_189001_189500"), mapping = aes(x= condition, y = M_value)) + geom_beeswarm()

meth.mat4_longform2_nonrest %>% filter(chr == "chrY")

#https://m-clark.github.io/posts/2019-10-20-big-mixed-models/
#https://rstudio-pubs-static.s3.amazonaws.com/14602_548fb8c68e82402bab53ef718f9a606b.html

f_lmer_mc = function(data, calls, mc.cores) {
  require(parallel)
  if (is.data.frame(data)) 
    data = replicate(length(calls), data, simplify = F)
  for (i in 1:length(data)) attr(data[[i]], "cll") = calls[i]
  m.list = mclapply(data, function(i) eval(parse(text = attr(i, "cll"))), 
                    mc.cores = mc.cores)
  return(m.list)
}


#for when to use REML http://users.stat.umn.edu/~gary/classes/5303/handouts/REML.pdf


#is the t-test 2 sided?
library(lme4)
library(emmeans)

# run_tests <- function(genome_region, data){
#   require(lme4)
#   model <- lmer(M_value ~ condition + (1|participant_id), data=meth.mat4_longform2_nonrest %>% filter(region == genome_region), REML=TRUE)
#   result <- summary(model)
#   metrics <- c(genome_region,result$coefficients["conditionpre_exercise",])
#   
#   final <- data.frame(region=genome_region, estimate=result$coefficients["conditionpre_exercise",1], std_error = result$coefficients["conditionpre_exercise",2], df = result$coefficients["conditionpre_exercise",3], t_value = result$coefficients["conditionpre_exercise",4], p_value = result$coefficients["conditionpre_exercise",5])
#   return(final) 
# }


w0_pre_A <- c(1,0,0,0,0,0,0,0,0,0)
w0_pre_B <- c(0,1,0,0,0,0,0,0,0,0)
w0_post_A <- c(0,0,1,0,0,0,0,0,0,0)
w0_post_B <- c(0,0,0,1,0,0,0,0,0,0)
w12_pre_A <- c(0,0,0,0,1,0,0,0,0,0)
w12_pre_B <- c(0,0,0,0,0,1,0,0,0,0)
w12_post_A <- c(0,0,0,0,0,0,1,0,0,0)
w12_post_B <- c(0,0,0,0,0,0,0,1,0,0)
w16_rest_A <- c(0,0,0,0,0,0,0,0,1,0)
w16_rest_B <- c(0,0,0,0,0,0,0,0,0,1)
w0_pre <- (w0_pre_A + w0_pre_B)/2
w0_post <- (w0_post_A + w0_post_B)/2
w12_pre <- (w12_pre_A + w12_pre_B)/2
w12_post <- (w12_post_A + w12_post_B)/2
w16_rest <- (w16_rest_A + w16_rest_B)/2
pre_overall <- (w0_pre + w12_pre)/2
post_overall <- (w0_post + w12_post)/2
w0_overall <- (w0_pre + w0_post)/2
w12_overall <- (w12_pre + w12_post)/2
pre_A <- (w0_pre_A + w12_pre_A)/2
post_A <- (w0_post_A + w12_post_A)/2
pre_B <- (w0_pre_B + w12_pre_B)/2
post_B <- (w0_post_B + w12_post_B)/2
A_overall <- (pre_A + post_A + w16_rest_A)/3
B_overall <- (pre_B + post_B + w16_rest_B)/3


run_tests <- function(genome_region, data){
  require(lme4)
  model <- lmer(M_value ~ condition_id + (1|participant_id), data = meth.mat4_longform2 %>% filter(region == genome_region), REML=TRUE)
  model.emm <- emmeans(model, ~ condition_id)
  
  result_df <- emmeans::contrast(model.emm, method = list(
    "w0_post - w0_pre" = w0_post - w0_pre, 
    "w12_post - w12_pre" = w12_post - w12_pre, 
    "post - pre" = post_overall - pre_overall, 
    "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
    "w12_pre - w0_pre" = w12_pre - w0_pre, 
    "w12_post - w0_post" = w12_post - w0_post ,
    "w16_rest - w12_pre" = w16_rest - w12_pre,
    "w16_rest - w0_pre" = w16_rest - w0_pre,
    "w16_rest - pre_overall" = w16_rest - pre_overall, 
    "post_B - post_A" = post_B - post_A,
    "pre_B - pre_A" = pre_B - pre_A,
    "B_overall - A_overall" = A_overall - B_overall,
    "(post_B - pre_B) - (post_A - pre_A)" =  (post_B - pre_B) - (post_A - pre_A)
  )) %>% as.data.frame()
  result_df$region <- genome_region
  #result_df$p.value2 <- result_df$p.value %>% round(3)

  return(result_df) 
}



test1 <- lapply(X = head(unique(meth.mat4_longform2_nonrest$region)), FUN = function(a){run_tests(genome_region=a, data=meth.mat4_longform2)})
#lapply(test1, summary)
#test_results <- lapply(test1, summary)
#test_results[[1]]$coefficients["conditionpre_exercise",""]
test_summary <- do.call(rbind, test1) 

test1.1 <- run_tests(genome_region="chr17_59396501_59397000", data=meth.mat4_longform2)

library(parallel)

test2 <- mclapply(X = unique(meth.mat4_longform2$region)[1:1000], FUN = function(a){run_tests(genome_region=a, data=meth.mat4_longform2)}, mc.cores = 12)
test2_summary <- do.call(rbind, test2)


models <- mclapply(X = unique(meth.mat4_longform2$region), FUN = function(a){run_tests(genome_region=a, data=meth.mat4_longform2)}, mc.cores = 12)
model_results <- do.call(rbind, models) 
saveRDS(object = model_results, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/PCA_tiles_500_5_3.filt_30.norm_united_correct_sd_filt_0.1_lmer_results_REML_true.rds")

# saveRDS(object = model_results, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/PCA_tiles_500_5_3.filt_30.norm_united_correct_sd_filt_0.025_lmer_results_REML_true.rds")

model_results <- readRDS(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/PCA_tiles_500_5_3.filt_30.norm_united_correct_sd_filt_0.1_lmer_results_REML_true.rds")

# model_results <- readRDS(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/PCA_tiles_500_5_3.filt_30.norm_united_correct_sd_filt_0.025_lmer_results_REML_true.rds")



model_results %>% filter(p.value < 0.05) %>% pull(contrast) %>% table()
#multiple test correct each contrast separately.

model_results %>% group_by(contrast) %>% pull(p.value)

contrast_list <- model_results$contrast %>% unique()
contrast1 <- model_results %>% filter(contrast == contrast_list[1]) %>% add_column(adj.p.value = p.adjust(p = model_results %>% filter(contrast == contrast_list[1]) %>% pull(p.value), method = "BH"))
contrast2 <- model_results %>% filter(contrast == contrast_list[2]) %>% add_column(adj.p.value = p.adjust(p = model_results %>% filter(contrast == contrast_list[2]) %>% pull(p.value), method = "BH"))
contrast3 <- model_results %>% filter(contrast == contrast_list[3]) %>% add_column(adj.p.value = p.adjust(p = model_results %>% filter(contrast == contrast_list[3]) %>% pull(p.value), method = "BH"))
contrast4 <- model_results %>% filter(contrast == contrast_list[4]) %>% add_column(adj.p.value = p.adjust(p = model_results %>% filter(contrast == contrast_list[4]) %>% pull(p.value), method = "BH"))
contrast5 <- model_results %>% filter(contrast == contrast_list[5]) %>% add_column(adj.p.value = p.adjust(p = model_results %>% filter(contrast == contrast_list[5]) %>% pull(p.value), method = "BH"))
contrast6 <- model_results %>% filter(contrast == contrast_list[6]) %>% add_column(adj.p.value = p.adjust(p = model_results %>% filter(contrast == contrast_list[6]) %>% pull(p.value), method = "BH"))
contrast7 <- model_results %>% filter(contrast == contrast_list[7]) %>% add_column(adj.p.value = p.adjust(p = model_results %>% filter(contrast == contrast_list[7]) %>% pull(p.value), method = "BH"))
contrast8 <- model_results %>% filter(contrast == contrast_list[8]) %>% add_column(adj.p.value = p.adjust(p = model_results %>% filter(contrast == contrast_list[8]) %>% pull(p.value), method = "BH"))
contrast9 <- model_results %>% filter(contrast == contrast_list[9]) %>% add_column(adj.p.value = p.adjust(p = model_results %>% filter(contrast == contrast_list[9]) %>% pull(p.value), method = "BH"))
contrast10 <- model_results %>% filter(contrast == contrast_list[10]) %>% add_column(adj.p.value = p.adjust(p = model_results %>% filter(contrast == contrast_list[10]) %>% pull(p.value), method = "BH"))
contrast11 <- model_results %>% filter(contrast == contrast_list[11]) %>% add_column(adj.p.value = p.adjust(p = model_results %>% filter(contrast == contrast_list[11]) %>% pull(p.value), method = "BH"))
contrast12 <- model_results %>% filter(contrast == contrast_list[12]) %>% add_column(adj.p.value = p.adjust(p = model_results %>% filter(contrast == contrast_list[12]) %>% pull(p.value), method = "BH"))
contrast13 <- model_results %>% filter(contrast == contrast_list[13]) %>% add_column(adj.p.value = p.adjust(p = model_results %>% filter(contrast == contrast_list[13]) %>% pull(p.value), method = "BH"))

model_results2 <- do.call("rbind", list(contrast1, contrast2, contrast3, contrast4, contrast5, contrast6, contrast7, contrast8, contrast9, contrast10, contrast11, contrast12, contrast13))


saveRDS(object = model_results2, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/PCA_tiles_500_5_3.filt_30.norm_united_correct_sd_filt_0.1_lmer_results_REML_true.rds")

# saveRDS(object = model_results2, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/PCA_tiles_500_5_3.filt_30.norm_united_correct_sd_filt_0.025_lmer_results_REML_true.rds")

model_results2 <- readRDS(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/PCA_tiles_500_5_3.filt_30.norm_united_correct_sd_filt_0.1_lmer_results_REML_true.rds")

# model_results <- readRDS(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/PCA_tiles_500_5_3.filt_30.norm_united_correct_sd_filt_0.025_lmer_results_REML_true.rds")





model_results2 %>% filter(p.value < 0.05) %>% pull(contrast) %>% table()
model_results2 %>% filter(adj.p.value < 0.05) %>% pull(contrast) %>% table()
model_results2 %>% pull(contrast) %>% unique()
model_results2 %>% filter(adj.p.value < 0.05, contrast == "post_B - post_A")
model_results2 %>% filter(p.value < 0.05, contrast == "post_B - post_A") %>% arrange(p.value)


model_results2 %>% filter(p.value < 0.05, contrast == "post - pre", estimate > 0) %>% tally()
model_results2 %>% filter(p.value < 0.05, contrast == "post - pre", estimate < 0) %>% tally()

model_results2 %>% filter(adj.p.value < 0.05, contrast == "post - pre", estimate < -4 | estimate >2) %>% arrange(p.value) %>% View()
model_results2 %>% filter(adj.p.value < 0.05, contrast == "post - pre", estimate > 2) %>% arrange(p.value) %>% View()

model_results2 %>% filter(adj.p.value < 0.05, contrast == "post - pre", estimate > 2) %>% arrange(p.value) %>% View()


model_results2  %>% filter(adj.p.value < 0.05, contrast == "post - pre", estimate < 0) %>% mutate(estimate_percent = -1*(2^estimate)/(2^estimate + 1)) %>% ggplot(data = ., mapping = aes(x=estimate_percent)) + geom_histogram(bins = 50) + theme_classic(base_size = 14) 
model_results2  %>% filter(adj.p.value < 0.05, contrast == "post - pre", estimate > 0) %>% mutate(estimate_percent = 1*(2^estimate)/(2^estimate + 1)) %>% ggplot(data = ., mapping = aes(x=estimate_percent)) + geom_histogram(bins = 50) + theme_classic(base_size = 14) 


model_results2  %>% filter(adj.p.value < 0.05, contrast == "post - pre", estimate < 0) %>% mutate(estimate_percent = -1*(2^estimate)/(2^estimate + 1)) %>% rbind(., model_results2  %>% filter(adj.p.value < 0.05, contrast == "post - pre", estimate > 0) %>% mutate(estimate_percent = 1*(2^estimate)/(2^estimate + 1)) ) %>% ggplot(data = ., mapping = aes(x=100*estimate_percent)) + geom_histogram(bins = 50) + theme_classic(base_size = 14) + xlim(c(-100,100)) + xlab("methylation change (%)")
  

model_results2 %>% filter(p.value < 0.05, contrast == "post - pre") %>% arrange(p.value) %>% ggplot(data = ., mapping = aes(x=estimate)) + geom_histogram(bins = 50) + theme_classic() + xlim(c(0,0.15))
model_results2 %>% filter(p.value < 0.05, contrast == "post - pre") %>% arrange(p.value) %>% ggplot(data = ., mapping = aes(x=estimate)) + geom_histogram(bins = 50) + theme_classic() + xlim(c(-4,4))

model_results2 %>% filter(p.value < 0.05, contrast == "post - pre") %>% arrange(p.value) %>% ggplot(data = ., mapping = aes(x=estimate)) + geom_histogram(bins = 50) + theme_classic(base_size = 14) 






ggplot(data = meth.mat4_longform2_nonrest %>% filter(region == "chr1_189001_189500"), mapping = aes(x= condition, y = M_value, color=week)) + geom_beeswarm()
ggplot(data = meth.mat4_longform2_nonrest %>% filter(region == "chr1_191501_192000"), mapping = aes(x= condition, y = M_value, color=week)) + geom_beeswarm()
ggplot(data = meth.mat4_longform2_nonrest %>% filter(region == "chr1_605001_605500"), mapping = aes(x= condition, y = M_value, color=week)) + geom_beeswarm()
ggplot(data = meth.mat4_longform2_nonrest %>% filter(region == "chr1_605501_606000"), mapping = aes(x= condition, y = M_value, color=week)) + geom_beeswarm()
ggplot(data = meth.mat4_longform2_nonrest %>% filter(region == "chr1_634001_634500"), mapping = aes(x= condition, y = M_value, color=week)) + geom_beeswarm()
ggplot(data = meth.mat4_longform2_nonrest %>% filter(region == "chr1_834501_835000"), mapping = aes(x= condition, y = M_value, color=week)) + geom_beeswarm()



model_results$padj <- p.adjust(p = model_results$p_value, method = "BH")
model_results$estimate <- model_results$estimate*-1 

ggplot(data = meth.mat4_longform2_nonrest %>% filter(region == "chr3_39146001_39146500"), mapping = aes(x= condition, y = M_value, color=week)) + geom_beeswarm() + ggtitle("chr3:39146001-39146500") + theme_classic()

results_all <- model_results %>% left_join(x = ., y = meth.mat4_longform2_nonrest[,c("chr", "start","end", "region")] %>% unique(), by=c("region"="region"))


#background regions are all that were united by Methylseq.
background <- methylKit::getData(meth)[,c("chr","start","end")]
targets_all <- results_all %>% filter(padj<0.05) %>% dplyr::select(chr,start,end)
targets_up <- results_all %>% filter(padj<0.05, estimate > 0) %>% dplyr::select(chr,start,end)
targets_down <- results_all %>% filter(padj<0.05, estimate < 0) %>% dplyr::select(chr,start,end)

targets_all_details <- results_all %>% filter(padj<0.05) 
targets_up_details <- results_all %>% filter(padj<0.05, estimate > 0) 
targets_down_details <- results_all %>% filter(padj<0.05, estimate < 0)

ggplot(data = meth.mat4_longform2_nonrest %>% filter(region == "chr1_634001_634500"), mapping = aes(x= condition, y = M_value, color=week)) + geom_beeswarm() + ggtitle("chr3:39146001-39146500") + theme_classic()
ggplot(data = meth.mat_beta_values3_longform2_nonrest %>% filter(region == "chr1_634001_634500"), mapping = aes(x= condition, y = b_value, color=week)) + geom_beeswarm() + ggtitle("chr3:39146001-39146500") + theme_classic()


ggplot(data = meth.mat_beta_values3_longform2_nonrest %>% filter(region == "chr17_62573001_62573500"), mapping = aes(x= condition, y = b_value, color=week)) + geom_beeswarm() + ggtitle("chr17_62573001_62573500") + theme_classic()
ggplot(data = meth.mat_beta_values3_longform2_nonrest %>% filter(region == "chr4_109970001_109970500"), mapping = aes(x= condition, y = b_value, color=week)) + geom_beeswarm() + ggtitle("chr4_109970001_109970500") + theme_classic()



write.table(x = background, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_500_5_3.filt_30.norm_united_sd_background.bed", sep="\t", row.names = FALSE, quote = FALSE)

write.table(x = targets_all, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_500_5_3.filt_30.norm_united_sd_filt_0.1_lmer_results_REML_true_padj_sig_all.bed", sep="\t", row.names = FALSE, quote = FALSE)

write.table(x = targets_up, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_500_5_3.filt_30.norm_united_sd_filt_0.1_lmer_results_REML_true_padj_sig_up.bed", sep="\t", row.names = FALSE, quote = FALSE)

write.table(x = targets_down, file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/tiles_500_5_3.filt_30.norm_united_sd_filt_0.1_lmer_results_REML_true_padj_sig_down.bed", sep="\t", row.names = FALSE, quote = FALSE)




















































































