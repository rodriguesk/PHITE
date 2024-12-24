#analysis for publication

library(magrittr)
library(tidyverse)
library(ggbeeswarm)

# install.packages("nloptr")
library(nloptr)
# install.packages("lme4")
library(lme4)

celfie_data <- read.csv(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/celfie/celfie_output.csv",header = TRUE,sep = ",", stringsAsFactors = FALSE)

numeric_columns <- celfie_data %>% dplyr::select(-c("id","sample","week","program","timepoint")) %>% colnames() %>% as.vector()
celfie_data <- celfie_data %>% mutate_at(numeric_columns, as.numeric)

#strip "\xca" from anywhere in the data
celfie_data$sample <- gsub(pattern = "\xca", replacement = "", x = celfie_data$sample)

#fix sample labeling swap... if not already corrected...
#c("sample","week","program","timepoint")

# "PH119_A_w0pre" should be S25
#"PH119_A_w0h0" should be S24

#"PH138_B_w0pre" should be S20
#"PH138_B_w0h0" should be S19

# row_info_PH119_A_w0pre <- celfie_data %>% filter(sample=="PH119_A_w0pre") %>% dplyr::select(sample,week,program,timepoint) 
# row_info_PH119_A_w0h0 <- celfie_data %>% filter(sample=="PH119_A_w0h0") %>% dplyr::select(sample,week,program,timepoint) 
# row_info_PH138_B_w0pre <- celfie_data %>% filter(sample=="PH138_B_w0pre") %>% dplyr::select(sample,week,program,timepoint) 
# row_info_PH138_B_w0h0 <- celfie_data %>% filter(sample=="PH138_B_w0h0") %>% dplyr::select(sample,week,program,timepoint) 
# 
# celfie_data[which(celfie_data[,"id"]=="S25"),c("sample","week","program","timepoint")] <- row_info_PH119_A_w0pre
# celfie_data[which(celfie_data[,"id"]=="S24"),c("sample","week","program","timepoint")] <- row_info_PH119_A_w0h0
# celfie_data[which(celfie_data[,"id"]=="S20"),c("sample","week","program","timepoint")] <- row_info_PH138_B_w0pre
# celfie_data[which(celfie_data[,"id"]=="S19"),c("sample","week","program","timepoint")] <- row_info_PH138_B_w0h0

#fix sample labeling swap... if not already corrected...
sample_corrections <- read.csv(file = "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/NovaSeq_SampleList_20220502_correct_20230111.csv",header = TRUE,sep = ",", stringsAsFactors = FALSE)

corrected_celfie_data <- celfie_data %>% dplyr::select(-c(sample, week, program, timepoint)) %>% left_join(x = ., y = sample_corrections, by=c("id"="sample_old")) %>% left_join(x = ., y = celfie_data %>% dplyr::select(c(id, sample, week, program, timepoint)), by=c("sample_corrected"="id")) %>% dplyr::select(-sample_corrected)

celfie_data <- corrected_celfie_data

#check there's no typos
celfie_data$week %>% unique()
celfie_data$program %>% unique()
celfie_data$timepoint %>% unique()

#all 16w data should be rest samples
celfie_data %>% filter(week=="w16") %>% pull(timepoint) %>% unique()
#rest, pre

#all rest data should be at 16 wks only
celfie_data %>% filter(timepoint=="rest") %>% pull(week) %>% unique()
#w16, w12

#S28
celfie_data[which(celfie_data[,"id"]=="S28"),"timepoint"] <- "pre"

celfie_data[which(celfie_data[,"id"]=="S35"),"timepoint"] <- "rest"




celfie_data_longform <- celfie_data %>% pivot_longer(cols = dendritic:unknown1, names_to = "origin", values_to = "proportion")


# With automatic dodging
#ggplot(celfie_data_longform, aes(x=origin, y=proportion, color=factor(timepoint))) + geom_beeswarm(dodge.width=0.5)

celfie_data_longform$timepoint <- celfie_data_longform$timepoint %>% factor(x = ., levels=c("pre","post","rest"))
celfie_data_longform$group1 <- paste(celfie_data_longform$program, celfie_data_longform$timepoint, celfie_data_longform$origin, sep = "_")
#celfie_data_longform$group2 <- #

paste0(celfie_data_longform$origin,"_",celfie_data_longform$timepoint)
sort(paste0(celfie_data_longform$origin,"_",celfie_data_longform$timepoint))

make_names <- function(origin){
  names_list <- c(paste0(origin,"_","pre"), paste0(origin,"_","post"), paste0(origin,"_","rest"))
  return(names_list)
  }

levels_for_celfie_data <- lapply(X = unique(celfie_data_longform$origin), FUN = make_names) %>% unlist()

celfie_data_longform$group2 <- paste(celfie_data_longform$origin, celfie_data_longform$timepoint,  sep = "_") %>% factor(x = ., levels = levels_for_celfie_data)


celfie_data_longform$group3 <- paste(celfie_data_longform$origin, celfie_data_longform$week, celfie_data_longform$program, celfie_data_longform$timepoint, sep = "_") 

celfie_data_longform$group3 <- factor(celfie_data_longform$group3, levels = celfie_data_longform %>% arrange(origin, week, program, timepoint) %>% pull(group3) %>% unique())

celfie_data_longform$proportion_transform <- (celfie_data_longform$proportion * (length(celfie_data_longform$proportion) - 1) + 0.5) / length(celfie_data_longform$proportion)  

celfie_data_longform %>% filter(proportion_transform == 0)
celfie_data_longform %>% filter(proportion_transform == 1)

celfie_data_longform$participant <- celfie_data_longform$sample %>% sub(pattern = "_.*",replacement = "", x = .)

#logit transform
celfie_data_longform$proportion_logit <- log(celfie_data_longform$proportion_transform  / (1 - celfie_data_longform$proportion_transform ))

celfie_data_longform <- celfie_data_longform %>% mutate(exercise = case_when(
  timepoint == "pre" ~ FALSE,
  timepoint == "rest" ~ FALSE,
  timepoint == "post" ~ TRUE
)) 
  
celfie_data_longform <- celfie_data_longform %>% mutate(training = case_when(
  week == "w0" ~ "none",
  week == "w12" ~ "trained",
  week == "w16" ~ "detrained"
)) 

celfie_data_longform$condition <- paste0(celfie_data_longform$week, "_", celfie_data_longform$timepoint)
celfie_data_longform$condition <- factor(celfie_data_longform$condition, levels = c("w0_pre", "w0_post", "w12_pre", "w12_post", "w16_rest"))


ggplot(data = celfie_data_longform, mapping = aes(x=proportion_transform) )+ geom_histogram()
ggplot(data = celfie_data_longform, mapping = aes(x=proportion_logit) )+ geom_histogram()


library(betareg)
library(lme4)
library(lmerTest)

model.beta <- betareg(proportion_transform ~ origin, data=celfie_data_longform)

#library(lmtest)
full_interaction <- lmer(formula = proportion_logit ~ exercise * training * program + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)

less_interaction <- lmer(formula = proportion_logit ~ exercise * program + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)

less_interaction2 <- lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)

#model_3_nested <- lmer(formula = proportion_logit ~ exercise * training + (1|participant/program), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE) #model fails to converge!

simple_model <- lmer(formula = proportion_logit ~ exercise * program + training*program + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)

simple_model2 <- lmer(formula = proportion_logit ~ exercise + training + program + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)

simple_model3_no_program <- lmer(formula = proportion_logit ~ exercise + training + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)

simplest_model <- lmer(formula = proportion_logit ~ exercise + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)

simplest_model2 <- lmer(formula = proportion_logit ~ exercise + (exercise|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)

#other_model <- lmer(formula = proportion_logit ~ exercise * training  + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)


detailed_model <- lmer(formula = proportion_logit ~ exercise + training + exercise:training + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)
detailed_model2 <- lmer(formula = proportion_logit ~ 0 + exercise + training + exercise:training + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)


#test <- lmer(formula = proportion_logit ~ exercise:training + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)

#test2 <- lmer(formula = proportion_logit ~ exercise + training + exercise:training + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)

#anova(test2, less_interaction2)


test <- glmer(formula = proportion_transform ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), family = binomial("logit"))

summary(test)

anova(less_interaction2, test)

anova(full_interaction, less_interaction)
anova(simple_model, full_interaction)
anova(simple_model, less_interaction)
anova(simple_model, less_interaction2)

summary(full_interaction)
summary(less_interaction)
summary(less_interaction2)
summary(simple_model)
summary(simple_model2)
summary(simple_model3_no_program)


summary(simplest_model)
summary(simplest_model2)

anova(simplest_model, simplest_model)

anova(less_interaction, less_interaction2)
anova(full_interaction, less_interaction2)
anova(simple_model2, less_interaction2)

anova(simple_model3_no_program, less_interaction2)

anova(simplest_model, less_interaction2)

anova(less_interaction2, detailed_model)
anova(less_interaction2, detailed_model2)


#best model seems to be:
summary(less_interaction2)
summary(detailed_model)
summary(detailed_model2)

#or 
summary(simple_model3_no_program)
#or
summary(simplest_model)

#library(sjPlot)
#library(effects)
#library(emmeans) #emmeans and #emtrends
#library(psycho) #get_contrasts

#plot(allEffects(less_interaction2))
#plot_model(less_interaction2,type = "int")+theme_bw()  


#https://yury-zablotski.netlify.app/post/multiple-logistic-regression-with-interactions/#multiple-logistic-regression-with-higher-order-interactions

#https://www.google.com/search?q=lme4+visualize+predictors&oq=lme4+visualize+predictors&aqs=chrome..69i57j33i160.6595j0j7&sourceid=chrome&ie=UTF-8

#https://www.r-bloggers.com/2014/11/visualizing-generalized-linear-mixed-effects-models-part-2-rstats-lme4/
# install.packages("emmeans", dependencies = FALSE)
library(emmeans)
# install.packages("sjPlot", dependencies = FALSE)
library(sjPlot)
# sjp.glmer(less_interaction2,
#           type = "ri.pc",
#           show.se = TRUE)

summary(less_interaction2)

plot_model(less_interaction2)
plot_model(detailed_model)
plot_model(detailed_model2)



#https://mspeekenbrink.github.io/sdam-r-companion/linear-mixed-effects-models.html

#make categorical variables factors, with appropriate baseline level first
celfie_data_longform$exercise <- factor(celfie_data_longform$exercise, levels=c(FALSE,TRUE))
celfie_data_longform$training <- factor(celfie_data_longform$training, levels=c("none","trained","detrained"))
celfie_data_longform$participant <- factor(celfie_data_longform$participant)

#contrasts(anchoring$anchor) <- c(1/2, -1/2) # alphabetical order, so high before low
# define a lmer
#mod <- lme4::lmer(everest_feet ~ anchor + (1|referrer), data=anchoring)
test_model_plot <- lme4::lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)

summary(test_model_plot)

library(ggplot2)
tdat <- data.frame(predicted=predict(test_model_plot), residual = residuals(test_model_plot))
ggplot(tdat,aes(x=predicted,y=residual)) + geom_point() + geom_hline(yintercept=0, lty=3)

tdat <- data.frame(predicted=predict(test_model_plot), residual = residuals(test_model_plot), participant=celfie_data_longform %>% filter(origin=="neutrophil") %>% pull(participant), exercise=celfie_data_longform %>% filter(origin=="neutrophil") %>% pull(exercise), training=celfie_data_longform %>% filter(origin=="neutrophil") %>% pull(training))
ggplot(tdat,aes(x=predicted, y=residual, colour=participant, shape=training, fill=exercise)) + geom_point() + geom_hline(yintercept=0, lty=3)

ggplot(tdat,aes(x=residual)) + geom_histogram(bins=20, color="black")

#Q-Q plot
ggplot(tdat,aes(sample=residual)) + stat_qq() + stat_qq_line()



test_model_plot2 <- lme4::lmer(formula = proportion_logit ~ exercise * training + (exercise|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)
anova(test_model_plot,test_model_plot2)
summary(test_model_plot2)

# test_model_plot3 <- lme4::lmer(formula = proportion_logit ~ exercise * training + (1 + exercise||participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)
# anova(test_model_plot3,test_model_plot3)
# summary(test_model_plot3)

# install.packages("afex")
library(afex)
test_model_plot3 <- afex::lmer_alt(proportion_logit ~ exercise * training + (1 + exercise||participant), set_data_arg = TRUE, data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)
summary(test_model_plot3)

anova(test_model_plot2, test_model_plot3)
anova(test_model_plot, test_model_plot3)
#is it over fit, though?
#can't really know unless we had hold out data or did 5 fold or 10 fold cross validation.


celfie_data_longform_neutrophil <- celfie_data_longform %>% filter(origin == "neutrophil") %>% mutate(pred= predict(test_model_plot3))
ggplot(celfie_data_longform_neutrophil, aes(x=proportion_logit, y=pred, colour=participant, group=participant)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

ggplot(celfie_data_longform_neutrophil, aes(x=exercise, y=pred, colour=participant, group=participant)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

ggplot(celfie_data_longform_neutrophil, aes(x=training, y=pred, colour=participant, group=participant)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

ggplot(celfie_data_longform_neutrophil, aes(x=interaction(exercise,training), y=pred, colour=participant, group=participant)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")


#obtaining p-values with afex::mixed (uses pbkrtest and lmerTest in backend)
afmodg <- mixed(proportion_logit ~ exercise * training + (1 + exercise|participant), data=celfie_data_longform_neutrophil, check_contrasts = FALSE, test_intercept = TRUE, method="KR")
afmodg
summary(afmodg)

afmodg <- mixed(proportion_logit ~ exercise * training + (1 + exercise|participant), data=celfie_data_longform_neutrophil, check_contrasts = FALSE, test_intercept = FALSE, method="KR")
afmodg
summary(afmodg)


afmodg <- mixed(proportion_logit ~ exercise * training + (1 + exercise|participant), data=celfie_data_longform_neutrophil, check_contrasts = TRUE, test_intercept = TRUE, method="KR")
afmodg
summary(afmodg)
###???

afmodr <- mixed(proportion_logit ~ exercise * training + (1 + exercise||participant), data=celfie_data_longform_neutrophil, check_contrasts = FALSE, test_intercept = TRUE, method="KR")
afmodr
summary(afmodr)

afmodr <- mixed(proportion_logit ~ exercise * training + (1 + exercise||participant), data=celfie_data_longform_neutrophil, check_contrasts = TRUE, test_intercept = TRUE, method="KR")
afmodr
summary(afmodr)
###???

anova(afmodr$full_model, afmodg$full_model)




testing <- mixed(proportion_logit ~ exercise * training + (1|participant), data=celfie_data_longform_neutrophil, check_contrasts = FALSE, test_intercept = TRUE, method="KR")
testing
summary(testing)

library(boot)
inv.logit(testing$full_model@beta) #seems wrong?


lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "neutrophil"), aes(x=interaction(exercise, training), y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")
ggplot(celfie_data_longform %>% filter(origin == "neutrophil"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="endothelial"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "endothelial"), aes(x=interaction(exercise, training), y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")
ggplot(celfie_data_longform %>% filter(origin == "endothelial"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="unknown1"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "unknown1"), aes(x=interaction(exercise, training), y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")
ggplot(celfie_data_longform %>% filter(origin == "unknown1"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="erythroblast"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "erythroblast"), aes(x=interaction(exercise, training), y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")
ggplot(celfie_data_longform %>% filter(origin == "erythroblast"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="monocyte"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "monocyte"), aes(x=interaction(exercise, training), y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")
ggplot(celfie_data_longform %>% filter(origin == "monocyte"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="heart"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "heart"), aes(x=interaction(exercise, training), y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")
ggplot(celfie_data_longform %>% filter(origin == "heart"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="hepatocyte"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "hepatocyte"), aes(x=interaction(exercise, training), y=log(proportion), colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal") #just seems too noisy to trust!
ggplot(celfie_data_longform %>% filter(origin == "hepatocyte"), aes(x=interaction(exercise, training), y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal") #just seems too noisy!
#did the transformation skew the data? it seems like it... it seems like it might be leading to false positives?

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="megakaryocyte"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "megakaryocyte"), aes(x=interaction(exercise, training), y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")
ggplot(celfie_data_longform %>% filter(origin == "megakaryocyte"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")


lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="brain"), REML = FALSE) %>% summary() #almost significant for exercise



#not significant are below:

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="tcell"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "tcell"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="dendritic"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "dendritic"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="eosinophil"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "dendritic"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="macrophage"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "eosinophil"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="placenta"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "placenta"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="adipose"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "adipose"), aes(x=interaction(exercise, training), y=log(proportion), colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")
ggplot(celfie_data_longform %>% filter(origin == "adipose"), aes(x=interaction(exercise, training), y=log(proportion), colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")
#this seems wrong. it should be significant? clearly more likely to measure 0 adipose DNA when not exercised...?
#likely need deeper sequencing? 
celfie_data_longform %>% filter(origin == "adipose") %>% arrange(participant, week, exercise) %>% pull(proportion, exercise) 

#only need to drop PH137 w0 data and PH154 w12 data due to missing values (0)
celfie_data_longform_no_w16 <- celfie_data_longform %>% filter(week != "w16")
celfie_data_longform_no_w16$training <- factor(celfie_data_longform_no_w16$training, levels = c("none","trained"))
celfie_data_longform_no_w16$exercise <- factor(celfie_data_longform_no_w16$exercise, levels = c(FALSE,TRUE))

#lmer(formula = log(proportion) ~ exercise * training + (1|participant), data = celfie_data_longform_no_w16 %>% filter(origin=="adipose", participant != "PH137", participant != "PH154", week != "w16"), REML = FALSE) %>% summary()
small_data <- celfie_data_longform_no_w16 %>% filter(origin=="adipose", participant != "PH137", participant != "PH154", week != "w16")

#just bump everything up by as much as the smallest value?
smallest_value <- celfie_data_longform %>% filter(origin == "adipose", week %in% c("w0","w12"), proportion > 0) %>% pull(proportion) %>% min()
small_data <- celfie_data_longform %>% filter(origin == "adipose", week %in% c("w0","w12")) %>% mutate(proportion_raised = proportion + smallest_value) 

small_data <- small_data %>% mutate(log_proportion_raised = log(proportion_raised))

lmer(formula = log_proportion_raised ~ exercise * training + (1|participant), data = small_data, REML = FALSE) %>% summary()

lmer(formula = log_proportion_raised ~ 0 + exercise * training + (1|participant), data = small_data, REML = FALSE) %>% summary()
adipose <- lmer(formula = log_proportion_raised ~ 0 + exercise * training + (1|participant), data = small_data, REML = FALSE)
#Now exercise it very significant in the model!

lmer(formula = proportion_raised ~ 0 + exercise * training + (1|participant), data = small_data, REML = FALSE) %>% summary()

ggplot(small_data, aes(x=interaction(exercise, training), y=log_proportion_raised, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

#q-q plot to ensure regression residuals are normally distributed
tdat2 <- data.frame(predicted=predict(adipose), residual = residuals(adipose), participant=small_data %>% pull(participant), exercise=small_data %>% pull(exercise), training=small_data %>% pull(training))

ggplot(tdat2,aes(sample=residual)) + stat_qq() + stat_qq_line()
ggplot(tdat2, aes(x=residual)) + geom_histogram()
#residuals are normally distributed!
ggplot(small_data, aes(x=log_proportion_raised)) + geom_histogram(binwidth =2)
ggplot(small_data, aes(x=exercise, y=log_proportion_raised, group=participant)) + geom_point() + geom_line()
summary(adipose)
#is exercise significantly different than no exercise? or does the model just mean exercise is significantly different than 0 and no exercise is significantly different than 0?
#I think it just means that exercise and no exercise are significantly predictive in the model.
#how to extract the contrast?
library(contrast)
library(nlme)
adipose_lme_fit <- lme(log_proportion_raised ~ 0 + exercise * training, data = small_data, random = ~1|participant)
summary(adipose_lme_fit)
print(
  contrast(
    adipose_lme_fit, 
    list(exercise = "TRUE", training = "trained"),
    list(exercise = "FALSE", training = "trained")
  ),
  X = TRUE)  

print(
  contrast(
    adipose_lme_fit, 
    list(exercise = "TRUE", training = "none"),
    list(exercise = "FALSE", training = "none")
  ),
  X = TRUE)  

print(
  contrast(
    adipose_lme_fit, 
    list(exercise = "TRUE", training = c("trained","none")),
    list(exercise = "FALSE", training = c("trained","none")),
    type="average"
  ),
  X = TRUE)  




adipose_lme_fit2 <- lme(log_proportion_raised ~ exercise * training, data = small_data, random = ~1|participant)
summary(adipose_lme_fit2)
print(
  contrast(
    adipose_lme_fit2, 
    list(exercise = "TRUE", training = "trained"),
    list(exercise = "FALSE", training = "trained")
  ),
  X = TRUE)  

print(
  contrast(
    adipose_lme_fit2, 
    list(exercise = "TRUE", training = "none"),
    list(exercise = "FALSE", training = "none")
  ),
  X = TRUE)  

print(
  contrast(
    adipose_lme_fit2, 
    list(exercise = "TRUE", training = c("trained","none")),
    list(exercise = "FALSE", training = c("trained","none")),
    type="average"
  ),
  X = TRUE)  


#proportion_transform is not useful
adipose_lme_fit2 <- lme(log(proportion_transform) ~ 0 + exercise * training, data = small_data, random = ~1|participant)
summary(adipose_lme_fit2)
print(
  contrast(
    adipose_lme_fit2, 
    list(exercise = "TRUE", training = "trained"),
    list(exercise = "FALSE", training = "trained")
  ),
  X = TRUE)  

print(
  contrast(
    adipose_lme_fit2, 
    list(exercise = "TRUE", training = "none"),
    list(exercise = "FALSE", training = "none")
  ),
  X = TRUE)  

print(
  contrast(
    adipose_lme_fit2, 
    list(exercise = "TRUE", training = c("trained","none")),
    list(exercise = "FALSE", training = c("trained","none")),
    type="average"
  ),
  X = TRUE)  



#proportion_transform is not useful
adipose_lme_fit2 <- lme(log_proportion_raised ~ condition, data = small_data, random = ~1|participant)
summary(adipose_lme_fit2)
print(
  contrast(
    adipose_lme_fit2, 
    list(condition = "w0_pre"),
    list(condition = "w0_post")
  ),
  X = TRUE)  

print(
  contrast(
    adipose_lme_fit2, 
    list(condition = "w12_pre"),
    list(condition = "w12_post")
  ),
  X = TRUE)  

print(
  contrast(
    adipose_lme_fit2, 
    list(condition = c("w0_pre","w12_pre")),
    list(condition = c("w0_post","w12_post")),
    type="average"
  ),
  X = TRUE)  

#it's the same as having the multi parameter model with log proportion raised.


#proportion_transform is not useful
adipose_lme_fit2 <- lme(log_proportion_raised ~ 0 + condition, data = small_data, random = ~1|participant)
summary(adipose_lme_fit2)
print(
  contrast(
    adipose_lme_fit2, 
    list(condition = "w0_pre"),
    list(condition = "w0_post")
  ),
  X = TRUE)  

print(
  contrast(
    adipose_lme_fit2, 
    list(condition = "w12_pre"),
    list(condition = "w12_post")
  ),
  X = TRUE)  

print(
  contrast(
    adipose_lme_fit2, 
    list(condition = c("w0_pre","w12_pre")),
    list(condition = c("w0_post","w12_post")),
    type="average"
  ),
  X = TRUE)  

#it's the same as having the other model too.

#but should the data be transformed to begin with? or should be used generalized linear mixed models instead and provide better link function?
#is the untransformed data normally distributed?



#see how this type of different transformation and data processing affects the results for neutrophils
global_smallest_value <- celfie_data_longform %>% filter(week %in% c("w0","w12"), proportion > 0) %>% pull(proportion) %>% min()
celfie_data_longform <- celfie_data_longform %>% mutate(proportion_raised = proportion + global_smallest_value)
celfie_data_longform <- celfie_data_longform %>% mutate(log_proportion_raised = log(proportion_raised))

neutrophil_small_data <- celfie_data_longform %>% filter(origin == "neutrophil", week %in% c("w0","w12"))
neutrophil_lme_fit <- lme(proportion_raised ~ condition, data = neutrophil_small_data, random = ~1|participant)
summary(neutrophil_lme_fit)
neutrophil_lme_fit2 <- lme(log_proportion_raised ~ condition, data = neutrophil_small_data, random = ~1|participant)
summary(neutrophil_lme_fit2)
print(
  contrast(
    neutrophil_lme_fit2, 
    list(condition = c("w0_pre","w12_pre")),
    list(condition = c("w0_post","w12_post")),
    type="average"
  ),
  X = TRUE) 

neutrophil_lme_fit3 <- lme(log_proportion_raised ~ exercise * week, data = neutrophil_small_data, random = ~1|participant)
summary(neutrophil_lme_fit3)
print(
  contrast(
    neutrophil_lme_fit3, 
    list(exercise = "TRUE", week = "w0"),
    list(exercise = "TRUE", week = "w12")
  ),
  X = TRUE) 
print(
  contrast(
    neutrophil_lme_fit3, 
    list(exercise = "FALSE", week = "w0"),
    list(exercise = "FALSE", week = "w12")
  ),
  X = TRUE) 
#p-value = 0.024 (indicating a training effect exists before exercise for neutrophils)


#trying to extract the interaction effects...? trying below:
library(emmeans)
emm <- emmeans(object = neutrophil_lme_fit3, specs = ~ exercise*week)
emmip(emm, exercise ~ week) #this plot shows the training effect clearly for neutrophils.
#does it make the interaction effect significant for exercise response?
icon <- contrast(emm, interaction = "consec")
coef(icon)

emm <- emmeans(object = less_interaction2, specs = ~ exercise * training)
emmip(emm, exercise ~ training) #this plot shows the training effect clearly for neutrophils.
#does it make the interaction effect significant for exercise response?
icon <- emmeans::contrast(emm, interaction = "consec")
icon
coef(icon)
#p-value = 0.0595 so not significant. 



emmeans::emtrends(less_interaction2, proportion_logit ~ training, var = "exercise")

neutrophil_small_data$training <- factor(neutrophil_small_data$training, levels = c("none","trained"))
less_interaction2_test <- lmer(formula = log_proportion_raised ~ exercise * training + (1|participant), data = neutrophil_small_data, REML = FALSE)
summary(less_interaction2_test)

emtrends(less_interaction2_test, log_proportion_raised ~ training, var = "exercise")
emtrends(less_interaction2_test, log_proportion_raised ~ exercise, var = "training")

emmeans(less_interaction2_test, pairwise ~ exercise | training)
emmeans(less_interaction2_test, pairwise ~ training | exercise)

neutrophil.emm <- emmeans(less_interaction2_test, ~ exercise * training)
pairs(neutrophil.emm, by = c("exercise"))
pairs(neutrophil.emm, by = c("training"))
pairs(neutrophil.emm, simple = list("exercise", "training"))

#pairs(neutrophil.emm, simple = list("exercise", c("training","program")))
pairs(neutrophil.emm, simple = "each")

pairs(neutrophil.emm, simple = "each", combine = TRUE)
emmeans::contrast(neutrophil.emm, "consec", simple = "each", combine = TRUE, adjust = "mvt") #all these seem to be relevant test here.



emmeans::contrast(neutrophil.emm, interaction = "consec") #pvalue 0.0978
#is this the right interaction though? I don't think so.
coef(emmeans::contrast(neutrophil.emm, interaction = "consec"))
# coefficients are: FALSE.none = 1, TRUE.trained = 1, TRUE.none = -1, FALSE.trained = -1.

emmeans::contrast(neutrophil.emm, interaction = list("exercise","training")) #pvalue 0.0978
emmeans::contrast(neutrophil.emm, interaction = TRUE) 
emmeans::contrast(neutrophil.emm, interaction = FALSE) 
#see https://rdrr.io/cran/emmeans/man/emmc-functions.html
emmeans::contrast(neutrophil.emm, interaction = "trt.vs.ctrl")
emmeans::contrast(neutrophil.emm, interaction = "mean_chg")

### Setting up a custom contrast function
#https://aosmith.rbind.io/2019/04/15/custom-contrasts-emmeans/
#estimated marginal means





#it's based on the order? so try different order?
# less_interaction2_test <- lmer(formula = log_proportion_raised ~ training * exercise + (1|participant), data = neutrophil_small_data, REML = FALSE)
# neutrophil.emm <- emmeans(less_interaction2_test, ~ training * exercise)
# emmeans::contrast(neutrophil.emm, interaction = "consec")
# coef(emmeans::contrast(neutrophil.emm, interaction = "consec"))

# neutrophil_small_data$training <- factor(neutrophil_small_data$training, levels= c("trained","none"))
# less_interaction2_test <- lmer(formula = log_proportion_raised ~ training * exercise + (1|participant), data = neutrophil_small_data, REML = FALSE)
# neutrophil.emm <- emmeans(less_interaction2_test, ~ training * exercise)
# emmeans::contrast(neutrophil.emm, interaction = "consec")
# coef(emmeans::contrast(neutrophil.emm, interaction = "consec"))


#install.packages("emmeans")
# install.packages("mvtnorm")
library(mvtnorm)
library(emmeans)
# .libPaths()
# .libPaths(c("/oak/stanford/groups/smontgom/kameronr/r4.2.2/lib/R/library","/home/kameronr/micromamba/lib/R/library","/home/kameronr/R/4.2.2", "/scg/apps/software/r/4.2.2/lib","/scg/apps/software/r/4.2.2/lib64/R/library"))
# .libPaths()
emmeans::contrast(neutrophil.emm, contrast=TRUE)

neutrophil_small_data$condition <- factor(x = neutrophil_small_data$condition, levels = c("w0_pre", "w0_post", "w12_pre", "w12_post"))
less_interaction2_test2 <- lmer(formula = log_proportion_raised ~ 0 + condition + (1|participant), data = neutrophil_small_data, REML = FALSE)
neutrophil.emm <- emmeans(less_interaction2_test2, ~ condition)
emmeans::contrast(neutrophil.emm, contrast=TRUE)
pairs(neutrophil.emm, simple = "each", combine = TRUE, adjust = "mvt")

pairs(neutrophil.emm, by = c("condition"))
pairs(neutrophil.emm, simple = list("w0_pre", c("w0_post")))
emmeans::contrast(neutrophil.emm, interaction = "consec")
emmeans::contrast(neutrophil.emm, "consec", simple = "each", combine = TRUE, adjust = "mvt")


neutrophil_small_data$condition <- factor(x = neutrophil_small_data$condition, levels = c("w0_pre", "w0_post", "w12_pre", "w12_post"))
less_interaction2_test2 <- lmer(formula = log_proportion_raised ~ 0 + condition + (1|participant), data = neutrophil_small_data, REML = FALSE)
neutrophil.emm <- emmeans(less_interaction2_test2, ~ condition)
w0_pre <- c(1,0,0,0)
w0_post <- c(0,1,0,0)
w12_pre <- c(0,0,1,0)
w12_post <- c(0,0,0,1)
pre <- c(1,0,1,0)
post <- c(0,1,0,1)
w0 <- c(1,1,0,0)
w12 <- c(0,0,1,1)
pre_overall = (w0_pre + w12_pre)/2
post_overall = (w0_post + w12_post)/2

# emmeans::contrast(neutrophil.emm, method = list(w0_post - w0_pre))
# emmeans::contrast(neutrophil.emm, method = list("w0_post - w0_pre" = w0_post - w0_pre,
#                              "w12_post - w12_pre" = w12_post - w12_pre))
# 
# emmeans::contrast(neutrophil.emm, method = list("(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre))) #p-value = 0.0978

emmeans::contrast(neutrophil.emm, method = list(
  "w0_post - w0_pre" = w0_post - w0_pre, 
  "w12_post - w12_pre" = w12_post - w12_pre, 
  "post - pre" = post_overall - pre_overall, 
  "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
  "w12_pre - w0_pre" = w12_pre - w0_pre, 
  "w12_post - w0_post" = w12_post - w0_post 
  #,"w16_rest - w12_pre" = w16_rest - w12_pre 
  #,"w16_rest - w0_pre" = w16_rest - w0_pre 
)
) 

emmeans::contrast(neutrophil.emm, method = list(
  "w0_post - w0_pre" = w0_post - w0_pre, 
  "w12_post - w12_pre" = w12_post - w12_pre, 
  "post - pre" = post - pre, 
  "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
  "w12_pre - w0_pre" = w12_pre - w0_pre, 
  "w12_post - w0_post" = w12_post - w0_post 
  #,"w16_rest - w12_pre" = w16_rest - w12_pre 
  #,"w16_rest - w0_pre" = w16_rest - w0_pre 
),
adjust = "mvt"
) 


# emm_options(opt.digits = TRUE)
# library(formattable)
less_interaction2_test2 <- lmer(formula = proportion_raised ~ 0 + condition + (1|participant), data = neutrophil_small_data, REML = FALSE)
neutrophil.emm <- emmeans(less_interaction2_test2, ~ condition)
emmeans::contrast(neutrophil.emm, method = list(
  "w0_post - w0_pre" = w0_post - w0_pre, 
  "w12_post - w12_pre" = w12_post - w12_pre, 
  "post - pre" = post_overall - pre_overall, 
  "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
  "w12_pre - w0_pre" = w12_pre - w0_pre, 
  "w12_post - w0_post" = w12_post - w0_post 
))
results_proportion_raised <- emmeans::contrast(object = neutrophil.emm, method = list(
  "w0_post - w0_pre" = w0_post - w0_pre, 
  "w12_post - w12_pre" = w12_post - w12_pre, 
  "post - pre" = post_overall - pre_overall, 
  "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
  "w12_pre - w0_pre" = w12_pre - w0_pre, 
  "w12_post - w0_post" = w12_post - w0_post 
  #,"w16_rest - w12_pre" = w16_rest - w12_pre 
  #,"w16_rest - w0_pre" = w16_rest - w0_pre 
)
) %>% as.data.frame() 


less_interaction2_test2 <- lmer(formula = proportion_logit ~ 0 + condition + (1|participant), data = neutrophil_small_data, REML = FALSE)
neutrophil.emm <- emmeans(less_interaction2_test2, ~ condition)
emmeans::contrast(neutrophil.emm, method = list(
  "w0_post - w0_pre" = w0_post - w0_pre, 
  "w12_post - w12_pre" = w12_post - w12_pre, 
  "post - pre" = post_overall - pre_overall, 
  "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
  "w12_pre - w0_pre" = w12_pre - w0_pre, 
  "w12_post - w0_post" = w12_post - w0_post 
))
results_proportion_logit <- emmeans::contrast(neutrophil.emm, method = list(
  "w0_post - w0_pre" = w0_post - w0_pre, 
  "w12_post - w12_pre" = w12_post - w12_pre, 
  "post - pre" = post_overall - pre_overall, 
  "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
  "w12_pre - w0_pre" = w12_pre - w0_pre, 
  "w12_post - w0_post" = w12_post - w0_post 
  #,"w16_rest - w12_pre" = w16_rest - w12_pre 
  #,"w16_rest - w0_pre" = w16_rest - w0_pre 
)
) %>% as.data.frame()



less_interaction2_test2 <- lmer(formula = log_proportion_raised ~ 0 + condition + (1|participant), data = neutrophil_small_data, REML = FALSE)
neutrophil.emm <- emmeans(less_interaction2_test2, ~ condition)
emmeans::contrast(neutrophil.emm, method = list(
  "w0_post - w0_pre" = w0_post - w0_pre, 
  "w12_post - w12_pre" = w12_post - w12_pre, 
  "post - pre" = post_overall - pre_overall, 
  "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
  "w12_pre - w0_pre" = w12_pre - w0_pre, 
  "w12_post - w0_post" = w12_post - w0_post 
))
results_log_proportion_raised <- emmeans::contrast(neutrophil.emm, method = list(
  "w0_post - w0_pre" = w0_post - w0_pre, 
  "w12_post - w12_pre" = w12_post - w12_pre, 
  "post - pre" = post_overall - pre_overall, 
  "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
  "w12_pre - w0_pre" = w12_pre - w0_pre, 
  "w12_post - w0_post" = w12_post - w0_post 
  #,"w16_rest - w12_pre" = w16_rest - w12_pre 
  #,"w16_rest - w0_pre" = w16_rest - w0_pre 
)
) %>% as.data.frame() 


celfie_data_longform$proportion_raised_logit <- logit(celfie_data_longform$proportion_raised)

less_interaction2_test2 <- lmer(formula = proportion_raised_logit ~ 0 + condition + (1|participant), data = neutrophil_small_data, REML = FALSE)
neutrophil.emm <- emmeans(less_interaction2_test2, ~ condition)
emmeans::contrast(neutrophil.emm, method = list(
  "w0_post - w0_pre" = w0_post - w0_pre, 
  "w12_post - w12_pre" = w12_post - w12_pre, 
  "post - pre" = post_overall - pre_overall, 
  "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
  "w12_pre - w0_pre" = w12_pre - w0_pre, 
  "w12_post - w0_post" = w12_post - w0_post 
))
results_proportion_raised_logit <- emmeans::contrast(neutrophil.emm, method = list(
  "w0_post - w0_pre" = w0_post - w0_pre, 
  "w12_post - w12_pre" = w12_post - w12_pre, 
  "post - pre" = post_overall - pre_overall, 
  "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
  "w12_pre - w0_pre" = w12_pre - w0_pre, 
  "w12_post - w0_post" = w12_post - w0_post 
  #,"w16_rest - w12_pre" = w16_rest - w12_pre 
  #,"w16_rest - w0_pre" = w16_rest - w0_pre 
)
) %>% as.data.frame() 




#obtain the estimated marginal mean of the logit transformed data for all cell types and comparisons. consider multiple test correcting results afterwards with BH method?
library(emmeans)
cells <- celfie_data_longform %>% pull(origin) %>% unique()

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



get_emms_logit <- function(cell_type){
  celfie_data_longform_cell_type <- celfie_data_longform %>% filter(origin == cell_type)
  less_interaction2_test2 <- lmer(formula = proportion_logit ~ 0 + condition + (1|participant), data = celfie_data_longform_cell_type, REML = FALSE)
  cell_type.emm <- emmeans(less_interaction2_test2, ~ condition)
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
  result_df$cell_type <- cell_type
  return(result_df)
}

get_emms_proportion_raised <- function(cell_type){
  celfie_data_longform_cell_type <- celfie_data_longform %>% filter(origin == cell_type)
  less_interaction2_test2 <- lmer(formula = proportion_raised ~ 0 + condition + (1|participant), data = celfie_data_longform_cell_type, REML = FALSE)
  cell_type.emm <- emmeans(less_interaction2_test2, ~ condition)
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
  result_df$cell_type <- cell_type
  return(result_df)
}

get_emms_log_proportion_raised <- function(cell_type){
  celfie_data_longform_cell_type <- celfie_data_longform %>% filter(origin == cell_type)
  less_interaction2_test2 <- lmer(formula = log_proportion_raised ~ 0 + condition + (1|participant), data = celfie_data_longform_cell_type, REML = FALSE)
  cell_type.emm <- emmeans(less_interaction2_test2, ~ condition)
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
  result_df$cell_type <- cell_type
  return(result_df)
}

get_emms_proportion <- function(cell_type){
  celfie_data_longform_cell_type <- celfie_data_longform %>% filter(origin == cell_type)
  less_interaction2_test2 <- lmer(formula = proportion ~ 0 + condition + (1|participant), data = celfie_data_longform_cell_type, REML = FALSE)
  cell_type.emm <- emmeans(less_interaction2_test2, ~ condition)
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
  result_df$cell_type <- cell_type
  return(result_df)
}


final_list_logit <- lapply(X = cells, FUN = function(a){get_emms_logit(cell_type = a)})
final_df_logit <- do.call(rbind, final_list_logit)
final_df_logit$p.adj <- p.adjust(p =final_df_logit$p.value , method = "BH")
final_df_logit$p.adj2 <- final_df_logit$p.adj %>% round(x = ., digits = 3)

final_list_proportion_raised <- lapply(X = cells, FUN = function(a){get_emms_proportion_raised(cell_type = a)})
final_df_proportion_raised <- do.call(rbind, final_list_proportion_raised)
final_df_proportion_raised$p.adj <- p.adjust(p =final_df_proportion_raised$p.value , method = "BH")
final_df_proportion_raised$p.adj2 <- final_df_proportion_raised$p.adj %>% round(x = ., digits = 3)

final_list_log_proportion_raised <- lapply(X = cells, FUN = function(a){get_emms_log_proportion_raised(cell_type = a)})
final_df_log_proportion_raised <- do.call(rbind, final_list_log_proportion_raised)
final_df_log_proportion_raised$p.adj <- p.adjust(p =final_df_log_proportion_raised$p.value , method = "BH")
final_df_log_proportion_raised$p.adj2 <- final_df_log_proportion_raised$p.adj %>% round(x = ., digits = 3)

final_list_proportion <- lapply(X = cells, FUN = function(a){get_emms_proportion(cell_type = a)})
final_df_proportion <- do.call(rbind, final_list_proportion)
final_df_proportion$p.adj <- p.adjust(p =final_df_proportion$p.value , method = "BH")
final_df_proportion$p.adj2 <- final_df_proportion$p.adj %>% round(x = ., digits = 3)



final_df_logit %>% filter(contrast == "(w12_post - w12_pre) - (w0_post - w0_pre)") %>% arrange(p.adj)
final_df_logit %>% filter(contrast == "post - pre", p.adj < 0.05) %>% arrange(estimate)
#neutrophil goes up. a lot.
#megakaryocyte, erythroblast, small, endothelial, macrophage, and unknown go down.

final_df_proportion %>% filter(contrast == "post - pre", p.adj < 0.05) %>% arrange(estimate)
#the percent of neutrophil DNA in total plasma cell free DNA increases by 38.32 of total plasma cell free DNA
#neutrophil increased by 38.32%
#megakaryocyte decreased by 11.45%
#erythroblast decreased by 8.25%
#unknown decreased by 3.26%
#macrophage decreased by 3.09%
#endothelial decreased by 2.08%

#the neutrophil training effect was almost significant.

#visualize these exercise induced proportion changes
ggplot(data = celfie_data_longform %>% filter(origin=="neutrophil", week %in% c("w0","w12")), mapping = aes(x=exercise, y=proportion*100, shape=program, color=week, group = interaction(participant, week))) + geom_point(cex=3) + theme_classic(base_size = 14) + geom_line(alpha=0.5) + ggtitle("Neutrophil-derived DNA") + ylab("Proportion of Cell Free DNA (%)")

ggplot(data = celfie_data_longform %>% filter(origin=="megakaryocyte", week %in% c("w0","w12")), mapping = aes(x=exercise, y=proportion*100, shape=program, color=week, group = interaction(participant, week))) + geom_point(cex=3) + theme_classic(base_size = 14) + geom_line(alpha=0.5) + ggtitle("Megakaryocyte-derived DNA") + ylab("Proportion of Cell Free DNA (%)")

ggplot(data = celfie_data_longform %>% filter(origin=="erythroblast", week %in% c("w0","w12")), mapping = aes(x=exercise, y=proportion*100, shape=program, color=week, group = interaction(participant, week))) + geom_point(cex=3) + theme_classic(base_size = 14) + geom_line(alpha=0.5) + ggtitle("Erythroblast-derived DNA") + ylab("Proportion of Cell Free DNA (%)")

ggplot(data = celfie_data_longform %>% filter(origin=="unknown1", week %in% c("w0","w12")), mapping = aes(x=exercise, y=proportion*100, shape=program, color=week, group = interaction(participant, week))) + geom_point(cex=3) + theme_classic(base_size = 14) + geom_line(alpha=0.5) + ggtitle("Unknown-derived DNA") + ylab("Proportion of Cell Free DNA (%)")

ggplot(data = celfie_data_longform %>% filter(origin=="macrophage", week %in% c("w0","w12")), mapping = aes(x=exercise, y=proportion*100, shape=program, color=week, group = interaction(participant, week))) + geom_point(cex=3) + theme_classic(base_size = 14) + geom_line(alpha=0.5) + ggtitle("Macrophage-derived DNA") + ylab("Proportion of Cell Free DNA (%)")

ggplot(data = celfie_data_longform %>% filter(origin=="endothelial", week %in% c("w0","w12")), mapping = aes(x=exercise, y=proportion*100, shape=program, color=week, group = interaction(participant, week))) + geom_point(cex=3) + theme_classic(base_size = 14) + geom_line(alpha=0.5) + ggtitle("Endothelial-derived DNA") + ylab("Proportion of Cell Free DNA (%)")


ggplot(data = celfie_data_longform %>% filter(origin=="small", week %in% c("w0","w12")), mapping = aes(x=exercise, y=proportion*100, shape=program, color=week, group = interaction(participant, week))) + geom_point(cex=3) + theme_classic(base_size = 14) + geom_line(alpha=0.5) + ggtitle("Small intestine-derived DNA") + ylab("Proportion of Cell Free DNA (%)")


#what are the fold change in the percent then? the fold increase or decrease in the proportions?


#amount before and after exercise based on raw numbers (and total DNA amount):
celfie_data_longform %>% filter(origin == "neutrophil", week != "w16") %>% group_by(exercise) %>% summarize(mean(proportion))
celfie_data_longform %>% filter(origin == "megakaryocyte", week != "w16") %>% group_by(exercise) %>% summarize(mean(proportion))
celfie_data_longform %>% filter(origin == "erythroblast", week != "w16") %>% group_by(exercise) %>% summarize(mean(proportion))
celfie_data_longform %>% filter(origin == "endothelial", week != "w16") %>% group_by(exercise) %>% summarize(mean(proportion))
celfie_data_longform %>% filter(origin == "unknown1", week != "w16") %>% group_by(exercise) %>% summarize(mean(proportion))
celfie_data_longform %>% filter(origin == "macrophage", week != "w16") %>% group_by(exercise) %>% summarize(mean(proportion))
celfie_data_longform %>% filter(origin == "dendritic", week != "w16") %>% group_by(exercise) %>% summarize(mean(proportion))


amounts %>% filter(exercise != "rest") %>% group_by(exercise) %>% summarize(mean(Sample.Total.cfDNA.ng.from.1ml.plasma))

#table to organize
celfie_data_longform %>% filter(week != "w16") %>% group_by(origin, exercise) %>% summarize(mean_proportion = mean(proportion)) %>% pivot_wider(data = ., id_cols = origin, names_from = exercise, values_from = mean_proportion) %>% mutate(before_amount = `FALSE` * 5.94, after_amount = `TRUE` * 40.3) %>% filter(origin %in% c("neutrophil", "megakaryocyte", "erythroblast", "endothelial", "unknown1", "macrophage","dendritic")) %>% mutate(fold_change_amount_before_after = after_amount/before_amount)

#looks like megakaryocyte didn't change.
#although many of the cell types' proportion significantly go down in percentage with exercise, because the total amount of DNA is increasing and neutrophils go up by so much, the cell types that go down in proportion are actually increasing in total amount in total amount (when considering the extent that neutrophils diluted them).

#because the non significant cell types are significantly different in proportion, then can't say that their amount changed significantly, so we ignored the non significant cell types and just focus on the cell types that 


#could try to fit models to the calculated amounts, but then that would propagate error. 





lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="fibroblast"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "fibroblast"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="lung"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "lung"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="skeletal"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "skeletal"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="mammary"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "mammary"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="small"), REML = FALSE) %>% summary()
ggplot(celfie_data_longform %>% filter(origin == "small"), aes(x=interaction(exercise, training), y=proportion, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")



# [1] "dendritic"     "endothelial"   "eosinophil"    "erythroblast"  "macrophage"    "monocyte"      "neutrophil"    "placenta"      "tcell"         "adipose"       "brain"        
# [12] "fibroblast"    "heart"         "hepatocyte"    "lung"          "mammary"       "megakaryocyte" "skeletal"      "small"         "unknown1"  

heart <- lmer(formula = proportion_logit ~ exercise * training + (1|participant), data = celfie_data_longform %>% filter(origin=="heart"), REML = FALSE) 
celfie_data_longform_heart <- celfie_data_longform %>% filter(origin == "heart") %>% mutate(pred =  predict(heart))
ggplot(celfie_data_longform_heart, aes(x=interaction(exercise,training), y=pred, colour=participant, group=participant)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

ggplot(celfie_data_longform %>% filter(origin == "heart", week %in% c("w0")), aes(x=exercise, y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

ggplot(celfie_data_longform %>% filter(origin == "heart", week %in% c("w12")), aes(x=exercise, y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

ggplot(celfie_data_longform %>% filter(origin == "heart", week %in% c("w0","w12")), aes(x=exercise, y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

ggplot(celfie_data_longform %>% filter(origin == "heart", week %in% c("w16","w0","w12")), aes(x=exercise, y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")


ggplot(celfie_data_longform %>% filter(origin == "heart", week %in% c("w0","w12")), aes(x=exercise, y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")

ggplot(celfie_data_longform %>% filter(origin == "heart"), aes(x=interaction(exercise, training), y=proportion_logit, colour=participant, group=participant, shape=program)) + geom_point() + geom_line() + theme(legend.position="bottom", legend.direction = "horizontal")




#are there any correlations between cell types for cell free proportions?
#or do any of the cell type proportions of cell free DNA correspond to any of the physical phenotyping measures collected during exercise?
#anything correspond to BMI?

#does poor estimation of cell free DNA from specific cell types lead to more propagated error and worse estimation for all the other cell types/tissues estimated? 





#try making a simpler model with just 0 + condition + (1|participant) and extract the various contrasts we want?



##
##
##
##
##
##
##





#Below is actually the model and results used and presented for publication... (I think)... actually not... must be above? seems single model is bad. too many testing. 

simplest_model2 <- lmer(formula = proportion_logit ~ exercise + (exercise|participant), data = celfie_data_longform %>% filter(origin=="neutrophil"), REML = FALSE)





#try using estimated cell proportions to estimate amount of cell free DNA for each cell type and then fit the LME model to that data instead of fitting to the cell proportions. Then do the tests on the model for significant differences in amount of DNA for each cell type.
celfie_data_longform %>% colnames()
#join the amounts table to the celfie_data_longform table
celfie_data_longform <- celfie_data_longform %>% left_join(x = ., y = amounts %>% select(participant, sample, Sample.Total.cfDNA.ng.from.1ml.plasma), by = c("participant"="participant", "sample"="sample"))

celfie_data_longform <- celfie_data_longform %>% mutate(amount_estimate = proportion * Sample.Total.cfDNA.ng.from.1ml.plasma)

get_emms_amount_estimate <- function(cell_type){
  celfie_data_longform_cell_type <- celfie_data_longform %>% filter(origin == cell_type)
  less_interaction2_test2 <- lmer(formula = amount_estimate ~ 0 + condition + (1|participant), data = celfie_data_longform_cell_type, REML = FALSE)
  cell_type.emm <- emmeans(less_interaction2_test2, ~ condition)
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
  result_df$cell_type <- cell_type
  return(result_df)
}

library(emmeans)
cells <- celfie_data_longform %>% pull(origin) %>% unique()
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

celfie_data_longform %>% ggplot(data = ., mapping = aes(x=amount_estimate)) + geom_histogram()

final_list_amount_estimate <- lapply(X = cells, FUN = function(a){get_emms_amount_estimate(cell_type = a)})
final_df_amount_estimate <- do.call(rbind, final_list_amount_estimate)
final_df_amount_estimate$p.adj <- p.adjust(p =final_df_amount_estimate$p.value , method = "BH")
final_df_amount_estimate$p.adj2 <- final_df_amount_estimate$p.adj %>% round(x = ., digits = 3)

#only what's significant for amount_estimate model is neutrophil, dendritic, and unknown. the response for macrophage is also significant, but only for w0. 

#visualize these exercise induced amount_estimate changes
ggplot(data = celfie_data_longform %>% filter(origin=="neutrophil", week %in% c("w0","w12")), mapping = aes(x=exercise, y=amount_estimate, shape=program, color=week, group = interaction(participant, week))) + geom_point(cex=3) + theme_classic(base_size = 14) + geom_line(alpha=0.5) + ggtitle("Neutrophil-derived DNA") + ylab("Estimated Amount of cfDNA (ng in 1mL plasma)")

ggplot(data = celfie_data_longform %>% filter(origin=="dendritic", week %in% c("w0","w12")), mapping = aes(x=exercise, y=amount_estimate, shape=program, color=week, group = interaction(participant, week))) + geom_point(cex=3) + theme_classic(base_size = 14) + geom_line(alpha=0.5) + ggtitle("Dendritic-derived DNA") + ylab("Estimated Amount of cfDNA (ng in 1mL plasma)")

ggplot(data = celfie_data_longform %>% filter(origin=="macrophage", week %in% c("w12")), mapping = aes(x=exercise, y=amount_estimate, shape=program, color=week, group = interaction(participant, week))) + geom_point(cex=3) + theme_classic(base_size = 14) + geom_line(alpha=0.5) + ggtitle("Macrophage-derived DNA") + ylab("Estimated Amount of cfDNA (ng in 1mL plasma)")

ggplot(data = celfie_data_longform %>% filter(origin=="unknown1", week %in% c("w0","w12")), mapping = aes(x=exercise, y=amount_estimate, shape=program, color=week, group = interaction(participant, week))) + geom_point(cex=3) + theme_classic(base_size = 14) + geom_line(alpha=0.5) + ggtitle("Unknown-derived DNA") + ylab("Estimated Amount of cfDNA (ng in 1mL plasma)")

#seems like there's some unknown cell type that's driving almost just as much increase in cell free DNA as from neutrophils? Be good to try to figure out what this cell type or tissue is!


#is there significant difference between program A and program B?
celfie_data_longform %>% filter(origin == "neutrophil", timepoint== "post", program == "A") %>% pull(amount_estimate) #"traditional" intensity
celfie_data_longform %>% filter(origin == "neutrophil", timepoint== "post", program == "B") %>% pull(amount_estimate) #high intensity
t.test(celfie_data_longform %>% filter(origin == "neutrophil", timepoint== "post", program == "A") %>% pull(amount_estimate),celfie_data_longform %>% filter(origin == "neutrophil", timepoint== "post", program == "B") %>% pull(amount_estimate)  )
#p-value = 0.04727
#program difference identified!
#exercise intensity induces neutrophil-derived cell free DNA in blood plasma

t.test(celfie_data_longform %>% filter(origin == "dendritic", timepoint== "post", program == "A") %>% pull(amount_estimate),celfie_data_longform %>% filter(origin == "dendritic", timepoint== "post", program == "B") %>% pull(amount_estimate)  )
#signficiant also. p-value = 0.04985

t.test(celfie_data_longform %>% filter(origin == "macrophage", timepoint== "post", program == "A") %>% pull(amount_estimate),celfie_data_longform %>% filter(origin == "macrophage", timepoint== "post", program == "B") %>% pull(amount_estimate)  )
#signficiant also. p-value = 0.03778

t.test(celfie_data_longform %>% filter(origin == "unknown1", timepoint== "post", program == "A") %>% pull(amount_estimate),celfie_data_longform %>% filter(origin == "unknown1", timepoint== "post", program == "B") %>% pull(amount_estimate)  )
#not significant... p-value = 0.06603





#difference in endothelial cell proportion isn't found when running the model on the amount_estimate (most likely because not enough power... need more participants?)















celfie_data_longform$exercise.group <- factor(paste0(celfie_data_longform$timepoint,"_",celfie_data_longform$program), levels = c("pre_A","post_A","rest_A","pre_B","post_B","rest_B"))
celfie_data_longform <- celfie_data_longform %>% mutate(condition_id2 = case_when(
  condition == "w0pre" ~ "W0, before",
  condition == "w0h0" ~ "W0, after",
  condition == "w12pre" ~ "W12, before",
  condition == "w12h0" ~ "W12, after",
  condition == "w16rst" ~ "W16, rest"
))

celfie_data_longform <- celfie_data_longform %>% mutate(condition_id2 = case_when(
  week == "w0" & timepoint == "pre" ~ "W0, before",
  week == "w0" & timepoint == "post" ~ "W0, after",
  week == "w12" & timepoint == "pre" ~ "W12, before",
  week == "w12" & timepoint == "post" ~ "W12, after",
  week == "w16" ~ "W16, rest"
))

celfie_data_longform$condition_id2 <- factor(celfie_data_longform$condition_id2, levels = c("W0, before", "W0, after", "W12, before", "W12, after", "W16, rest"))



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

get_emms_exercise_model <- function(cell_type){
celfie_data_longform_cell_type <- celfie_data_longform %>% filter(origin == cell_type)
amount_less_interaction2 <- lmer(formula = amount_estimate ~ 0 + exercise.group + (1|participant), data = celfie_data_longform_cell_type, REML = FALSE)
cell_type.emm <- emmeans(amount_less_interaction2, ~ exercise.group)
result_df <- emmeans::contrast(cell_type.emm, method = list(
  "after_B - after_A" = after_B - after_A,
  #"B_overall - A_overall" = A_overall - B_overall,
  "(after_B - before_B) - (after_A - before_A)" =  (after_B - before_B) - (after_A - before_A)
)) %>% as.data.frame()
result_df$cell_type <- cell_type
return(result_df)
}

get_emms_exercise_model <- function(cell_type){
  celfie_data_longform_cell_type <- celfie_data_longform %>% filter(origin == cell_type)
  amount_less_interaction2 <- lmer(formula = amount_estimate ~ 0 + exercise.group + (1|participant), data = celfie_data_longform_cell_type, REML = FALSE)
  cell_type.emm <- emmeans(amount_less_interaction2, ~ exercise.group)
  result_df <- emmeans::contrast(cell_type.emm, method = list(
    "after_B - after_A" = after_B - after_A
    #"B_overall - A_overall" = A_overall - B_overall,
    #"(after_B - before_B) - (after_A - before_A)" =  (after_B - before_B) - (after_A - before_A)
  )) %>% as.data.frame()
  result_df$cell_type <- cell_type
  return(result_df)
}

get_emms_exercise_model_proportions <- function(cell_type){
  celfie_data_longform_cell_type <- celfie_data_longform %>% filter(origin == cell_type)
  amount_less_interaction2 <- lmer(formula = proportion_logit ~ 0 + exercise.group + (1|participant), data = celfie_data_longform_cell_type, REML = FALSE)
  cell_type.emm <- emmeans(amount_less_interaction2, ~ exercise.group)
  result_df <- emmeans::contrast(cell_type.emm, method = list(
    "after_B - after_A" = after_B - after_A
    #"B_overall - A_overall" = A_overall - B_overall,
    #"(after_B - before_B) - (after_A - before_A)" =  (after_B - before_B) - (after_A - before_A)
  )) %>% as.data.frame()
  result_df$cell_type <- cell_type
  return(result_df)
}

final_list_exercise.group <- lapply(X = cells, FUN = function(a){get_emms_exercise_model(cell_type = a)})
final_df_exercise.group <- do.call(rbind, final_list_exercise.group)
final_df_exercise.group$p.adj <- p.adjust(p =final_df_exercise.group$p.value , method = "BH")
final_df_exercise.group$p.adj2 <- final_df_exercise.group$p.adj %>% round(x = ., digits = 3)

final_list_proportion_exercise.group <- lapply(X = cells, FUN = function(a){get_emms_exercise_model_proportions(cell_type = a)})
final_df_proportion_exercise.group <- do.call(rbind, final_list_proportion_exercise.group)
final_df_proportion_exercise.group$p.adj <- p.adjust(p =final_df_proportion_exercise.group$p.value , method = "BH")
final_df_proportion_exercise.group$p.adj2 <- final_df_proportion_exercise.group$p.adj %>% round(x = ., digits = 3)
#nothing is significant after multiple testing correction


#make plots for significant results. 
#neutrophils, dendritic cells, macrophages, and unknown1

ggplot(data = celfie_data_longform %>% filter(origin == "neutrophil", timepoint %in% c("pre","post")), mapping = aes(x=exercise.group, y=amount_estimate, group = exercise.group)) + 
  ggtitle("Neutrophil-derived DNA")+
  xlab("condition") +
  ylab("Estimated cfDNA amount in 1mL (ng)") +
  geom_boxplot(mapping = aes(fill=condition_id2), outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")

ggplot(data = celfie_data_longform %>% filter(origin == "dendritic", timepoint %in% c("pre","post")), mapping = aes(x=exercise.group, y=amount_estimate, group = exercise.group)) + 
  ggtitle("Dendritic-derived DNA")+
  xlab("condition") +
  ylab("Estimated cfDNA amount in 1mL (ng)") +
  geom_boxplot(mapping = aes(fill=condition_id2), outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")

ggplot(data = celfie_data_longform %>% filter(origin == "macrophage", timepoint %in% c("pre","post")), mapping = aes(x=exercise.group, y=amount_estimate, group = exercise.group)) + 
  ggtitle("Macrophage-derived DNA")+
  xlab("condition") +
  ylab("Estimated cfDNA amount in 1mL (ng)") +
  geom_boxplot(mapping = aes(fill=condition_id2), outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")

ggplot(data = celfie_data_longform %>% filter(origin == "unknown1", timepoint %in% c("pre","post")), mapping = aes(x=exercise.group, y=amount_estimate, group = exercise.group)) + 
  ggtitle("Unknown-derived DNA")+
  xlab("condition") +
  ylab("Estimated cfDNA amount in 1mL (ng)") +
  geom_boxplot(mapping = aes(fill=condition_id2), outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")




# ggplot(data = celfie_data_longform %>% filter(origin == "neutrophil", timepoint %in% c("pre","post")), mapping = aes(x=exercise.group, y=log(amount_estimate), group = exercise.group)) + 
#   ggtitle("Estimated neutrophil-derived DNA")+
#   xlab("condition") +
#   ylab("cfDNA amount in 1mL (ng)") +
#   geom_boxplot(mapping = aes(fill=condition_id2), outlier.shape = NA) + 
#   #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
#   #stat_summary(fun = mean, geom="point", size=2) + 
#   #stat_summary(fun.data = mean_se, geom = "errorbar") +
#   geom_point(size = 4, alpha = 0.8, aes(fill=condition_id2, shape=program)) + 
#   theme_classic() +
#   theme(text=element_text(size=20))+
#   scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
#   scale_shape_manual(values=c(21,24)) + 
#   guides(fill = guide_legend(override.aes = list(shape = 21))) +
#   geom_line(mapping = aes(group=participant), linewidth=0.05) +
#   theme(legend.position = "none")
# 




ggplot(data = celfie_data_longform %>% filter(origin == "dendritic", timepoint %in% c("pre","post")), mapping = aes(x=condition, y=amount_estimate, group = condition)) + 
  ggtitle("Dendritic-derived DNA")+
  xlab("condition") +
  ylab("Estimated cfDNA amount in 1mL (ng)") +
  geom_boxplot(outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")


ggplot(data = celfie_data_longform %>% filter(origin == "macrophage", timepoint %in% c("pre","post")), mapping = aes(x=condition, y=amount_estimate, group = condition)) + 
  ggtitle("Macrophage-derived DNA")+
  xlab("condition") +
  ylab("Estimated cfDNA amount in 1mL (ng)") +
  geom_boxplot(outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")


ggplot(data = celfie_data_longform %>% filter(origin == "neutrophil", timepoint %in% c("pre","post")), mapping = aes(x=condition, y=amount_estimate, group = condition)) + 
  ggtitle("Neutrophil-derived DNA")+
  xlab("condition") +
  ylab("Estimated cfDNA amount in 1mL (ng)") +
  geom_boxplot(outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")




ggplot(data = celfie_data_longform %>% filter(origin == "dendritic", timepoint %in% c("pre","post")), mapping = aes(x=exercise, y=amount_estimate, group = exercise)) + 
  ggtitle("Dendritic-derived DNA")+
  xlab("exercise") +
  ylab("Estimated cfDNA amount in 1mL plasma (ng)") +
  geom_boxplot(outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")

ggplot(data = celfie_data_longform %>% filter(origin == "neutrophil", timepoint %in% c("pre","post")), mapping = aes(x=exercise, y=amount_estimate, group = exercise)) + 
  ggtitle("Neutrophil-derived DNA")+
  xlab("exercise") +
  ylab("Estimated cfDNA amount in 1mL plasma (ng)") +
  geom_boxplot(outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")

ggplot(data = celfie_data_longform %>% filter(origin == "macrophage", timepoint %in% c("pre","post"), week == "w0"), mapping = aes(x=exercise, y=amount_estimate, group = exercise)) + 
  ggtitle("Macrophage-derived DNA")+
  xlab("exercise") +
  ylab("Estimated cfDNA amount in 1mL plasma (ng)") +
  geom_boxplot(outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")

ggplot(data = celfie_data_longform %>% filter(origin == "unknown1", timepoint %in% c("pre","post")), mapping = aes(x=exercise, y=amount_estimate, group = exercise)) + 
  ggtitle("Unknown-derived DNA")+
  xlab("exercise") +
  ylab("Estimated cfDNA amount in 1mL plasma (ng)") +
  geom_boxplot(outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")






ggplot(data = celfie_data_longform %>% filter(origin == "neutrophil", timepoint %in% c("pre","post")), mapping = aes(x=exercise, y=proportion*100, group = exercise)) + 
  ggtitle("Neutrophil-derived")+
  xlab("exercise") +
  ylab("Estimated proportion of cfDNA (%)") +
  geom_boxplot(outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")

ggplot(data = celfie_data_longform %>% filter(origin == "megakaryocyte", timepoint %in% c("pre","post")), mapping = aes(x=exercise, y=proportion*100, group = exercise)) + 
  ggtitle("Megakaryocyte-derived")+
  xlab("exercise") +
  ylab("Estimated proportion of cfDNA (%)") +
  geom_boxplot(outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")

ggplot(data = celfie_data_longform %>% filter(origin == "erythroblast", timepoint %in% c("pre","post")), mapping = aes(x=exercise, y=proportion*100, group = exercise)) + 
  ggtitle("Erythroblast-derived")+
  xlab("exercise") +
  ylab("Estimated proportion of cfDNA (%)") +
  geom_boxplot(outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")

ggplot(data = celfie_data_longform %>% filter(origin == "endothelial", timepoint %in% c("pre","post")), mapping = aes(x=exercise, y=proportion*100, group = exercise)) + 
  ggtitle("Endothelial-derived")+
  xlab("exercise") +
  ylab("Estimated proportion of cfDNA (%)") +
  geom_boxplot(outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")

ggplot(data = celfie_data_longform %>% filter(origin == "unknown1", timepoint %in% c("pre","post")), mapping = aes(x=exercise, y=proportion*100, group = exercise)) + 
  ggtitle("Unknown-derived")+
  xlab("exercise") +
  ylab("Estimated proportion of cfDNA (%)") +
  geom_boxplot(outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")

ggplot(data = celfie_data_longform %>% filter(origin == "macrophage", timepoint %in% c("pre","post")), mapping = aes(x=exercise, y=proportion*100, group = exercise)) + 
  ggtitle("Macrophage-derived")+
  xlab("exercise") +
  ylab("Estimated proportion of cfDNA (%)") +
  geom_boxplot(outlier.shape = NA) + 
  #stat_boxplot(mapping = aes(fill=condition_id2), geom = "errorbar", linetype=1, width=0.2) + 
  #stat_summary(fun = mean, geom="point", size=2) + 
  #stat_summary(fun.data = mean_se, geom = "errorbar") +
  geom_point(size = 4, alpha = 0.8, aes(fill=condition, shape=program)) + 
  theme_classic() +
  theme(text=element_text(size=20))+
  scale_fill_manual(name = "condition", values=c("steelblue1",  "tomato", "royalblue", "firebrick", "grey38"), guides(fill="legend")) +
  scale_shape_manual(values=c(21,24)) + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) +
  geom_line(mapping = aes(group=interaction(participant,week)), linewidth=0.05) +
  theme(legend.position = "none")










celfie_data_longform %>%
  ggplot( aes(x=origin, y=proportion, group=group2, color=timepoint))+#, fill=name)) +
  geom_boxplot() +
  geom_jitter(color="black", size=0.4, alpha=0.9) +
  theme_classic() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

celfie_data_longform %>%
  ggplot( aes(x=origin, y=log10(proportion), group=group2, color=timepoint))+#, fill=name)) +
  geom_boxplot() +
  geom_jitter(color="black", size=0.4, alpha=0.9) +
  theme_classic() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))


celfie_data_longform %>%
  ggplot( aes(x=group2, y=proportion, group=group2, color=timepoint))+#, fill=name)) +
  geom_boxplot() +
  geom_jitter(color="black", size=0.4, alpha=0.9) +
  theme_classic() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

celfie_data_longform %>%
  ggplot( aes(x=group2, y=log10(proportion), group=group2, color=timepoint))+#, fill=name)) +
  geom_boxplot() +
  geom_jitter(color="black", size=0.4, alpha=0.9) +
  theme_classic() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))


celfie_data_longform %>% filter(origin %in% c("dendritic","endothelial","eosinophil","erythroblast","macrophage","megakaryocyte","monocyte","neutrophil","small","t cell","unknown1")) %>% 
  ggplot( aes(x=group3, y=proportion, group=group3, color=timepoint))+#, fill=name)) +
  geom_boxplot() +
  geom_jitter(color="black", size=0.4, alpha=0.9) +
  theme_classic() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

celfie_data_longform %>% filter(origin %in% c("adipose","brain","fibroblast","heart","hepatocyte","lung","skeletal")) %>% 
  ggplot( aes(x=group3, y=log10(proportion), group=group3, color=timepoint))+#, fill=name)) +
  geom_boxplot() +
  geom_jitter(color="black", size=0.4, alpha=0.9) +
  theme_classic() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))



celfie_data_longform %>%
  ggplot( aes(x=origin, y=proportion, group=group2, color=timepoint))+#, fill=name)) +
  geom_boxplot() +
  geom_beeswarm() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))



  ggplot(data = celfie_data_longform %>% filter(origin=="neutrophil"), mapping =  aes(x=origin, y=proportion, group=group2, color=timepoint)) +
  geom_jitter(color="black", size=0.4, alpha=0.9) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

  ggplot(data = celfie_data_longform %>% filter(origin=="neutrophil"), mapping =  aes(x=group1, y=proportion, group=group2, color=week)) +
    geom_beeswarm(cex = 4) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
  



t.test(x = , y = ,  paired = TRUE, alternative = "two.sided")




#pie chart of samples average proportions at baseline no exercise.
#pie chart of samples average proportions with exercise.

library(plotrix)

pie_data <- celfie_data_longform %>% filter(timepoint %in% c("pre")) %>% group_by(origin) %>% summarize(mean_proportion_before = mean(proportion), mean_proportion_before_error = std.error(proportion)) 
pie_data <- pie_data %>% 
  arrange(desc(origin)) %>%
  mutate(prop = mean_proportion_before / sum(pie_data$mean_proportion_before) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )

pie_data <- pie_data %>% mutate(mean_proportion_before2 = round(x = mean_proportion_before *100, digits = 4))

pie_data2 <- celfie_data_longform %>% filter(timepoint %in% c("post")) %>% group_by(origin) %>% summarize(mean_proportion_after = mean(proportion), mean_proportion_after_error = std.error(proportion)) %>% mutate(mean_proportion_after2 = round(x = mean_proportion_after *100, digits = 4)) %>% left_join(x = ., y = pie_data, by = c("origin"="origin"))

pie_data2$origin <- factor(pie_data2$origin, levels = c("unknown1","megakaryocyte", "erythroblast","monocyte","small", "neutrophil","eosinophil","macrophage","dendritic", "tcell","endothelial","heart","hepatocyte","lung","adipose","brain", "skeletal","fibroblast", "mammary", "placenta"))
# "unknown1","megakaryocyte", "erythroblast","monocyte","small", "neutrophil","eosinophil","macrophage","dendritic", "tcell","endothelial","skeletal","fibroblast","heart","hepatocyte","lung","adipose","brain", "mammary", "placenta"

library(RColorBrewer)
n <- 19
qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
pie(rep(1,n), col=sample(col_vector, n))

?colorRampPalette

#install.packages("Polychrome")
library(Polychrome)
# build-in color palette
Glasbey <- glasbey.colors(20)
swatch(Glasbey)

ggplot(pie_data, aes(x="", y=prop, fill=origin)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() + 
  theme(legend.position="none") +
  
  geom_text(aes(y = ypos, label = origin), color = "white", size=6) +
  scale_fill_manual(values = Glasbey)

?scale_fill_brewer

#large proportions
large_cell_types <- c("unknown1","megakaryocyte", "erythroblast","monocyte","small", "neutrophil","eosinophil","macrophage","dendritic", "tcell","endothelial")
#small proportions
small_cell_types <- c("placenta","skeletal","fibroblast","mammary","heart","hepatocyte","lung","adipose","brain")
small_cell_types <- c("skeletal","fibroblast","heart","hepatocyte","lung","adipose","brain")


ggplot(data = pie_data2 %>% filter(origin %in% large_cell_types), mapping = aes(x=origin, y = mean_proportion_before*100)) +
  geom_bar(stat="identity") +
  ylab("mean proportion before exercise (%)") +
  theme_classic(base_size = 14) +
  coord_flip()+
  geom_errorbar(aes(ymin=100*(mean_proportion_before-mean_proportion_before_error), ymax=100*(mean_proportion_before+mean_proportion_before_error)), width=.2) +
  ylim(c(0,50))

ggplot(data = pie_data2 %>% filter(origin %in% large_cell_types), mapping = aes(x=origin, y = mean_proportion_after*100)) +
  geom_bar(stat="identity") +
  ylab("mean proportion after exercise (%)") +
  theme_classic(base_size = 14) +
  coord_flip()+
  geom_errorbar(aes(ymin=100*(mean_proportion_after-mean_proportion_after_error), ymax=100*(mean_proportion_after+mean_proportion_after_error)), width=.2) +
  ylim(c(0,50))


ggplot(data= pie_data2 %>% filter(origin %in% small_cell_types), mapping = aes(x=origin, y = mean_proportion_before*100)) +
  geom_bar(stat="identity") +
  ylab("mean proportion before exercise (%)") +
  theme_classic(base_size = 14) +
  coord_flip()+
  geom_errorbar(aes(ymin=100*(mean_proportion_before-mean_proportion_before_error), ymax=100*(mean_proportion_before+mean_proportion_before_error)), width=.2) +
  ylim(c(0,1))

ggplot(data = pie_data2 %>% filter(origin %in% small_cell_types), mapping = aes(x=origin, y = mean_proportion_after*100)) +
  geom_bar(stat="identity") +
  ylab("mean proportion after exercise (%)") +
  theme_classic(base_size = 14) +
  coord_flip()+
  geom_errorbar(aes(ymin=100*(mean_proportion_after-mean_proportion_after_error), ymax=100*(mean_proportion_after+mean_proportion_after_error)), width=.2) +
  ylim(c(0,1))








#single_model
# w0_pre_A	
# w0_pre_B
# w0_post_A	
# w0_post_B	
# w12_pre_A	
# w12_pre_B	
# w12_post_A	
# w12_post_B	
# w16_rest_A
# w16_rest_B

cells <- celfie_data_longform %>% pull(origin) %>% unique()

celfie_data_longform <- celfie_data_longform %>% mutate(condition_id3 = case_when(
  week == "w0" & timepoint == "pre" & program == "A" ~ "w0_pre_A",
  week == "w0" & timepoint == "pre" & program == "B" ~ "w0_pre_B",
  week == "w0" & timepoint == "post" & program == "A" ~ "w0_post_A",
  week == "w0" & timepoint == "post" & program == "B" ~ "w0_post_B",
  week == "w12" & timepoint == "pre" & program == "A" ~ "w12_pre_A",
  week == "w12" & timepoint == "pre" & program == "B" ~ "w12_pre_B",
  week == "w12" & timepoint == "post" & program == "A" ~ "w12_post_A",
  week == "w12" & timepoint == "post" & program == "B" ~ "w12_post_B",
  week == "w16" & timepoint == "rest" & program == "A" ~ "w16_rest_A",
  week == "w16" & timepoint == "rest" & program == "B" ~ "w16_rest_B"
))

celfie_data_longform$condition_id3 <- factor(celfie_data_longform$condition_id3, levels = c("w0_pre_A",	"w0_pre_B", "w0_post_A", "w0_post_B", "w12_pre_A", "w12_pre_B", "w12_post_A", "w12_post_B", "w16_rest_A", "w16_rest_B"))


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

get_emms_complete_logit <- function(cell_type){
  celfie_data_longform_cell_type <- celfie_data_longform %>% filter(origin == cell_type)
  amount_less_interaction2 <- lmer(formula = proportion_logit ~ 0 + condition_id3 + (1|participant), data = celfie_data_longform_cell_type, REML = FALSE)
  cell_type.emm <- emmeans(amount_less_interaction2, ~ condition_id3)
  result_df <- emmeans::contrast(cell_type.emm, method = list(
    "w0_post - w0_pre" = w0_post - w0_pre, 
    "w12_post - w12_pre" = w12_post - w12_pre, 
    "post - pre" = post_overall - pre_overall, 
    "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
    "w12_pre - w0_pre" = w12_pre - w0_pre, 
    "w12_post - w0_post" = w12_post - w0_post ,
    #"w16_rest - w12_pre" = w16_rest - w12_pre,
    #"w16_rest - w0_pre" = w16_rest - w0_pre,
    "post_B - post_A" = post_B - post_A,
    "pre_B - pre_A" = pre_B - pre_A
    #"B_overall - A_overall" = A_overall - B_overall,
    #"(post_B - pre_B) - (post_A - pre_A)" =  (post_B - pre_B) - (post_A - pre_A)
  )) %>% as.data.frame()
  result_df$cell_type <- cell_type
  return(result_df)
}

final_list_logit <- lapply(X = cells, FUN = function(a){get_emms_complete_logit(cell_type = a)})
final_df_logit <- do.call(rbind, final_list_logit)
final_df_logit$p.adj <- p.adjust(p =final_df_logit$p.value , method = "BH")
final_df_logit$p.adj2 <- final_df_logit$p.adj %>% round(x = ., digits = 3)


#join the amounts table to the celfie_data_longform table
celfie_data_longform <- celfie_data_longform %>% left_join(x = ., y = amounts %>% select(participant, sample, Sample.Total.cfDNA.ng.from.1ml.plasma), by = c("participant"="participant", "sample"="sample"))

celfie_data_longform <- celfie_data_longform %>% mutate(amount_estimate = proportion * Sample.Total.cfDNA.ng.from.1ml.plasma)


get_emms_complete_amount_estimate <- function(cell_type){
  celfie_data_longform_cell_type <- celfie_data_longform %>% filter(origin == cell_type)
  amount_less_interaction2 <- lmer(formula = amount_estimate ~ 0 + condition_id3 + (1|participant), data = celfie_data_longform_cell_type, REML = FALSE)
  cell_type.emm <- emmeans(amount_less_interaction2, ~ condition_id3)
  result_df <- emmeans::contrast(cell_type.emm, method = list(
    "w0_post - w0_pre" = w0_post - w0_pre, 
    "w12_post - w12_pre" = w12_post - w12_pre, 
    "post - pre" = post_overall - pre_overall, 
    "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
    "w12_pre - w0_pre" = w12_pre - w0_pre, 
    "w12_post - w0_post" = w12_post - w0_post ,
    #"w16_rest - w12_pre" = w16_rest - w12_pre,
    #"w16_rest - w0_pre" = w16_rest - w0_pre,
    "post_B - post_A" = post_B - post_A,
    "pre_B - pre_A" = pre_B - pre_A
    #"B_overall - A_overall" = A_overall - B_overall,
    #"(post_B - pre_B) - (post_A - pre_A)" =  (post_B - pre_B) - (post_A - pre_A)
  )) %>% as.data.frame()
  result_df$cell_type <- cell_type
  return(result_df)
}

final_list_amount_estimate <- lapply(X = cells, FUN = function(a){get_emms_complete_amount_estimate(cell_type = a)})
final_df_amount_estimate <- do.call(rbind, final_list_amount_estimate)
final_df_amount_estimate$p.adj <- p.adjust(p =final_df_amount_estimate$p.value , method = "BH")
final_df_amount_estimate$p.adj2 <- final_df_amount_estimate$p.adj %>% round(x = ., digits = 3)


get_emms_complete_amount <- function(cell_type="neutrophil"){
  celfie_data_longform_cell_type <- celfie_data_longform %>% filter(origin == "neutrophil")
  amount_less_interaction2 <- lmer(formula = Sample.Total.cfDNA.ng.from.1ml.plasma.x ~ 0 + condition_id3 + (1|participant), data = celfie_data_longform_cell_type, REML = FALSE)
  cell_type.emm <- emmeans(amount_less_interaction2, ~ condition_id3)
  result_df <- emmeans::contrast(cell_type.emm, method = list(
    "w0_post - w0_pre" = w0_post - w0_pre, 
    "w12_post - w12_pre" = w12_post - w12_pre, 
    "post - pre" = post_overall - pre_overall, 
    "(w12_post - w12_pre) - (w0_post - w0_pre)" = (w12_post - w12_pre) - (w0_post - w0_pre),
    "w12_pre - w0_pre" = w12_pre - w0_pre, 
    "w12_post - w0_post" = w12_post - w0_post ,
    "w16_rest - w12_pre" = w16_rest - w12_pre,
    "w16_rest - w0_pre" = w16_rest - w0_pre,
    "post_B - post_A" = post_B - post_A,
    "pre_B - pre_A" = pre_B - pre_A,
    "B_overall - A_overall" = A_overall - B_overall,
    "(post_B - pre_B) - (post_A - pre_A)" =  (post_B - pre_B) - (post_A - pre_A)
  )) %>% as.data.frame()
  #result_df$cell_type <- cell_type
  return(result_df)
}

final_list_amount <- get_emms_complete_amount()
final_list_amount$p.value2 <- final_list_amount$p.value %>% round(x = ., digits = 3)











