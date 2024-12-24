#!/bin/bash

#SBATCH --job-name=analyze
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=batch
#SBATCH --account=smontgom
#SBATCH --mem=600G
#SBATCH --time=9:00:00


cd /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full
module load r/4.0 
Rscript read_in_data_and_make_PCA_CF_methylation.r





