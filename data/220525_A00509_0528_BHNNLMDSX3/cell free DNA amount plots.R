#plot of amount of cell free DNA for each participant's samples of 1mL plasma.

library(magrittr)
library(tidyverse)

amounts_path <- "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/cf_DNA_amounts.csv"

amounts <- read.csv(file = amounts_path, header = TRUE, sep = ",", stringsAsFactors = FALSE)

#amounts %>% str_match(string = "https://news.stanford.edu/press-releases/2018/11/28/reflections-california-wildfires/", pattern ="^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\\?([^#]*))?(#(.*))?")[,5]


strsplit(x = amounts$Total.cfDNA.amount.from.1ml.plasma., split = "-")
amounts <- separate(data = amounts, col = Total.cfDNA.amount.from.1ml.plasma., into = c("participant","condition"), sep = "-" ) %>% separate(data = ., col = condition, into = c("group", "condition"), sep=" ")

amounts$condition <- amounts$condition %>% gsub(pattern = "wk", replacement = "w", x = .)
amounts$condition <- factor(amounts$condition, levels = c("w0pre", "w0h0", "w12pre", "w12h0", "w16rst"))


amounts$condition.group <- paste0(amounts$condition,"_",amounts$group)
amounts$condition.group <- factor(paste0(amounts$condition,"_",amounts$group), levels = c("w0pre_A", "w0h0_A", "w12pre_A", "w12h0_A", "w16rst_A", "w0pre_B", "w0h0_B", "w12pre_B", "w12h0_B", "w16rst_B"))

#typo correction
amounts[10,"condition"] <- "w16rst"

#make a group that combines the exercise timepoints
amounts <- amounts %>% mutate(exercise = case_when(
  condition == "w16rst" ~ "rest",
  condition == "w0pre" ~ "before",
  condition == "w12pre" ~ "before",
  condition == "w0h0" ~ "after",
  condition == "w12h0" ~ "after"
))

amounts <- amounts %>% mutate(condition_id2 = case_when(
  condition == "w0pre" ~ "W0, before",
  condition == "w0h0" ~ "W0, after",
  condition == "w12pre" ~ "W12, before",
  condition == "w12h0" ~ "W12, after",
  condition == "w16rst" ~ "W16, rest"
))

amounts$condition_id2 <- factor(amounts$condition_id2, levels = c("W0, before", "W0, after", "W12, before", "W12, after", "W16, rest"))


amounts$exercise <- factor(x = amounts$exercise, levels = c("before","after","rest"))

amounts$sample <- paste0(amounts$participant,"_",amounts$group, "_",amounts$condition)

amounts$group <- factor(x = amounts$group, levels= c("A", "B"))


amounts$exercise
amounts$condition
amounts$condition.group
amounts$group
amounts$condition_id2

ggplot(data = amounts, mapping = aes(x=exercise, y=log(Sample.Total.cfDNA.ng.from.1ml.plasma), fill=exercise)) + geom_boxplot() + geom_beeswarm()  + theme_classic()

ggplot(data = amounts, mapping = aes(x=condition, y=Sample.Total.cfDNA.ng.from.1ml.plasma, fill=condition)) + geom_boxplot() + geom_point() + theme_classic()

ggplot(data = amounts, mapping = aes(x=condition.group, y=Sample.Total.cfDNA.ng.from.1ml.plasma, fill=condition)) + geom_boxplot() + geom_point() + theme_classic()
#does appear to be some evidence of exercise intensity specific effects.



hist(amounts$Sample.Total.cfDNA.ng.from.1ml.plasma)
hist(log(amounts$Sample.Total.cfDNA.ng.from.1ml.plasma))


ggplot(data = amounts, mapping = aes(x=condition.group, y=Sample.Total.cfDNA.ng.from.1ml.plasma), group = condition.group) + 
  xlab("condition") +
  ylab("Total cfDNA amount in 1mL (ng)") +
  geom_boxplot(mapping = aes(fill=condition_id2)) + 
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=group)) + 
  theme_classic() +
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21)))


#connect the lines 
#https://datavizpyr.com/how-to-connect-data-points-on-boxplot-with-lines/
ggplot(data = amounts, mapping = aes(x=condition.group, y=log(Sample.Total.cfDNA.ng.from.1ml.plasma)), group = condition.group) + 
  xlab("condition") +
  ylab("Total cfDNA amount in 1mL ( log(ng) )") +
  geom_boxplot(mapping = aes(fill=condition_id2)) + 
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=group)) + 
  theme_classic() +
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) 


ggplot(data = amounts, mapping = aes(x=condition.group, y=log(Sample.Total.cfDNA.ng.from.1ml.plasma)), group = condition.group) + 
  xlab("condition") +
  ylab("Total cfDNA amount in 1mL ( log(ng) )") +
  geom_boxplot(mapping = aes(fill=condition_id2), outlier.shape = NA) + 
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=group)) + 
  theme_classic() +
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=participant), linewidth=0.05)
  #geom_line(mapping = aes(group=participant), linewidth=0.2)


ggplot(data = amounts, mapping = aes(x=condition.group, y=log(Sample.Total.cfDNA.ng.from.1ml.plasma)), group = condition.group) + 
  xlab("condition") +
  ylab("Total cfDNA amount in 1mL ( log(ng) )") +
  geom_boxplot(mapping = aes(fill=condition_id2)) + 
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=group)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=participant), linewidth=0.05)
#geom_line(mapping = aes(group=participant), linewidth=0.2)




#make figures similar to PCA data colors and shapes.
amounts_figure <- ggplot(data = amounts, mapping = aes(x=condition.group, y=log(Sample.Total.cfDNA.ng.from.1ml.plasma)), group = condition.group) + 
  xlab("condition") +
  ylab("Total cfDNA amount in 1mL ( log(ng) )") +
  geom_boxplot(mapping = aes(fill=condition_id2)) + 
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=group)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=participant), linewidth=0.05)
#geom_line(mapping = aes(group=participant), linewidth=0.2)

ggsave(filename = "amounts_cf_dna_methylation_plot.pdf", plot = amounts_figure, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_plot.png", plot = amounts_figure, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_plot2.pdf", plot = amounts_figure, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_plot2.png", plot = amounts_figure, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)

amounts_figure_no_log_no_legend <- ggplot(data = amounts, mapping = aes(x=condition.group, y=Sample.Total.cfDNA.ng.from.1ml.plasma), group = condition.group) + 
  xlab("condition") +
  ylab("Total cfDNA amount in 1mL (ng)") +
  geom_boxplot(mapping = aes(fill=condition_id2)) + 
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=group)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=participant), linewidth=0.05) +
  theme(legend.position = "none")
#geom_line(mapping = aes(group=participant), linewidth=0.2)

ggsave(filename = "amounts_cf_dna_methylation_no_log_no_legend_plot.pdf", plot = amounts_figure_no_log_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_no_log_no_legend_plot.png", plot = amounts_figure_no_log_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_no_log_no_legend_plot2.pdf", plot = amounts_figure_no_log_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_no_log_no_legend_plot2.png", plot = amounts_figure_no_log_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)


amounts_figure_no_log_no_legend <- ggplot(data = amounts, mapping = aes(x=condition.group, y=Sample.Total.cfDNA.ng.from.1ml.plasma), group = condition.group) + 
  xlab("condition") +
  ylab("Total cfDNA amount in 1mL (ng)") +
  geom_boxplot(mapping = aes(fill=condition_id2), outlier.shape = NA) + 
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=group)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=participant), linewidth=0.05) +
  theme(legend.position = "none")
#geom_line(mapping = aes(group=participant), linewidth=0.2)

ggsave(filename = "amounts_cf_dna_methylation_no_log_no_legend_plot.pdf", plot = amounts_figure_no_log_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_no_log_no_legend_plot.png", plot = amounts_figure_no_log_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_no_log_no_legend_plot2.pdf", plot = amounts_figure_no_log_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_no_log_no_legend_plot2.png", plot = amounts_figure_no_log_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)


amounts_figure_no_legend <- ggplot(data = amounts, mapping = aes(x=condition.group, y=log(Sample.Total.cfDNA.ng.from.1ml.plasma)), group = condition.group) + 
  xlab("condition") +
  ylab("Total cfDNA amount in 1mL ( log(ng) )") +
  geom_boxplot(mapping = aes(fill=condition_id2), outlier.shape = NA) + 
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=group)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=participant), linewidth=0.05) +
  theme(legend.position = "none")
#geom_line(mapping = aes(group=participant), linewidth=0.2)

ggsave(filename = "amounts_cf_dna_methylation_no_legend_plot.pdf", plot = amounts_figure_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_no_legend_plot.png", plot = amounts_figure_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_no_legend_plot2.pdf", plot = amounts_figure_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_no_legend_plot2.png", plot = amounts_figure_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)


amounts_figure_programs_overlaid <- ggplot(data = amounts, mapping = aes(x=condition, y=log(Sample.Total.cfDNA.ng.from.1ml.plasma)), group = condition) + 
  xlab("condition") +
  ylab("Total cfDNA amount in 1mL ( log(ng) )") +
  geom_boxplot(mapping = aes(fill=condition_id2), outlier.shape = NA) + 
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=group)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=participant), linewidth=0.05) 

ggsave(filename = "amounts_cf_dna_methylation_programs_overlaid_plot.pdf", plot = amounts_figure_programs_overlaid, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_programs_overlaid_plot.png", plot = amounts_figure_programs_overlaid, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_programs_overlaid_plot2.pdf", plot = amounts_figure_programs_overlaid, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_programs_overlaid_plot2.png", plot = amounts_figure_programs_overlaid, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)


amounts_figure_programs_overlaid_no_legend <- ggplot(data = amounts, mapping = aes(x=condition, y=log(Sample.Total.cfDNA.ng.from.1ml.plasma)), group = condition) + 
  xlab("condition") +
  ylab("Total cfDNA amount in 1mL ( log(ng) )") +
  geom_boxplot(mapping = aes(fill=condition_id2), outlier.shape = NA) + 
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=group)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=participant), linewidth=0.05) +
  theme(legend.position = "none")

ggsave(filename = "amounts_cf_dna_methylation_programs_overlaid_no_legend_plot.pdf", plot = amounts_figure_programs_overlaid_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_programs_overlaid_no_legend_plot.png", plot = amounts_figure_programs_overlaid_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12, height = 12, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_programs_overlaid_no_legend_plot2.pdf", plot = amounts_figure_programs_overlaid_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)
ggsave(filename = "amounts_cf_dna_methylation_programs_overlaid_no_legend_plot2.png", plot = amounts_figure_programs_overlaid_no_legend, path = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full", width = 12.5, height = 9.5, dpi = 600)




ggplot(data = amounts, mapping = aes(x=condition, y=log(Sample.Total.cfDNA.ng.from.1ml.plasma)), group = condition) + 
  xlab("condition") +
  ylab("Total cfDNA amount in 1mL ( log(ng) )") +
  geom_boxplot(mapping = aes(fill=condition_id2), outlier.shape = NA) + 
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=group)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=participant), linewidth=0.05) +
  theme(legend.position = "none")

ggplot(data = amounts, mapping = aes(x=condition, y=log(Sample.Total.cfDNA.ng.from.1ml.plasma)), group = condition) + 
  xlab("condition") +
  ylab("Total cfDNA amount in 1mL ( log(ng) )") +
  geom_boxplot(mapping = aes(fill=condition_id2), outlier.shape = NA) + 
  stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=group)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=participant), linewidth=0.05) +
  theme(legend.position = "none")

ggplot(data = amounts, mapping = aes(x=condition.group, y=log(Sample.Total.cfDNA.ng.from.1ml.plasma)), group = condition.group) + 
  xlab("condition") +
  ylab("Total cfDNA amount in 1mL ( log(ng) )") +
  geom_boxplot(mapping = aes(fill=condition_id2), outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=group)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=participant), linewidth=0.05) +
  theme(legend.position = "none")


#test if significant difference in exercise program A and B for total amount of cell free DNA
t.test(amounts %>% filter(group=="A",))


#clear that the 4 exercise familiarization sessions have likely had an affect on the participants???
#or maybe if they needed to take the IST multiple times to pass?



#test via LME model...
library(lme4)
library(emmeans)

w0_pre <- c(1,0,0,0,0)
w0_post <- c(0,1,0,0,0)
w12_pre <- c(0,0,1,0,0)
w12_post <- c(0,0,0,1,0)
w16_rest <- c(0,0,0,0,1)
pre <- c(1,0,1,0)
post <- c(0,1,0,1)
w0 <- c(1,1,0,0)
w12 <- c(0,0,1,1)
pre_overall = (w0_pre + w12_pre)/2
post_overall = (w0_post + w12_post)/2

amount_less_interaction2 <- lmer(formula = Sample.Total.cfDNA.ng.from.1ml.plasma ~ 0 + condition+ (1|participant), data = amounts, REML = FALSE)
cell_type.emm <- emmeans(amount_less_interaction2, ~ condition)
result_df <- emmeans::contrast(cell_type.emm, method = list(
  "w0_post - w0_pre" = w0_post - w0_pre, 
  "w12_post - w12_pre" = w12_post - w12_pre, 
  "post - pre" = post_overall - pre_overall, 
  "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
  "w12_pre - w0_pre" = w12_pre - w0_pre, 
  "w12_post - w0_post" = w12_post - w0_post,
  "w16_rest - w12_pre" = w16_rest - w12_pre,
  "w16_rest - w0_pre" = w16_rest - w0_pre 
)) %>% as.data.frame()
result_df$program <- "A and B"



amounts$exercise.group <- factor(x = paste0(amounts$exercise, "_", amounts$group), levels = c("before_A","after_A","rest_A","before_B","after_B","rest_B"))

before_A <- c(1,0,0,0,0,0)
after_A <- c(0,1,0,0,0,0)
rest_A <- c(0,0,1,0,0,0)
before_B <- c(0,0,0,1,0,0)
after_B <- c(0,0,0,0,1,0)
rest_B <- c(0,0,0,0,0,1)
before_overall <- (before_A + before_B)/2
after_overall <- (after_A + after_B)/2
A_overall <- (before_A + after_A + rest_A)/3
B_overall <- (before_B + after_B + rest_B)/3

amount_less_interaction2 <- lmer(formula = Sample.Total.cfDNA.ng.from.1ml.plasma ~ 0 + exercise.group + (1|participant), data = amounts, REML = FALSE)
cell_type.emm <- emmeans(amount_less_interaction2, ~ exercise.group)
result_df <- emmeans::contrast(cell_type.emm, method = list(
  "after_B - after_A" = after_B - after_A,
  "B_overall - A_overall" = A_overall - B_overall,
  "(after_B - before_B) - (after_A - before_A)" =  (after_B - before_B) - (after_A - before_A)
)) %>% as.data.frame()
result_df$measure <- "amounts"


#is program A exercised different than program B exercised?
amounts %>% filter(group=="A", exercise == "after") %>% 
t.test()





#read in physical phenotyping data
primary_outcomes <- readRDS(file = "/oak/stanford/groups/smontgom/kameronr/PHITE_phenotyping/primary_outcomes.RDS")
phenotyping_full <- readRDS(file = "/oak/stanford/groups/smontgom/kameronr/PHITE_phenotyping/stanford_phenotyping.RDS")

#phenotyping_full$p3_myofiber_data$

amounts

phenotyping_full$p3_1rm_data$pid
phenotyping_full$p3_1rm_data$time_point
phenotyping_full$p3_1rm_data$squat_max

phenotyping_full$p3_cytokine_data$pid
phenotyping_full$p3_cytokine_data$time_point
phenotyping_full$p3_cytokine_data$il6
phenotyping_full$p3_cytokine_data$demo_age
phenotyping_full$p3_cytokine_data$tnf_alpha
phenotyping_full$p3_cytokine_data$tnf_alpha
phenotyping_full$p3_cytokine_data$il12_p70





