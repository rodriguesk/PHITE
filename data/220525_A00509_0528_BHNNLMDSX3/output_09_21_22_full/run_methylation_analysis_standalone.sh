#!/bin/bash

#SBATCH --job-name=analyze
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --partition=batch
#SBATCH --account=smontgom
#SBATCH --mem=600G
#SBATCH --time=72:00:00


cd /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full
module load r/4.1.2 
Rscript analyze_cfDNA_methylation_standalone.R





