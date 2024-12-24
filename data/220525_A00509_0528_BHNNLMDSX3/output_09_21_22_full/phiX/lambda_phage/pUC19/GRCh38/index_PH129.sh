#!/bin/bash

#SBATCH --time=48:00:00
#SBATCH --account=smontgom
#SBATCH --partition=nih_s10
#SBATCH --cpus-per-task=15
#SBATCH --mem=164GB
#SBATCH --job-name=in_PH129

#merge bam files

module load samtools

cd /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/

samtools index PH129.deduplicated.sorted.bam -o PH129.deduplicated.sorted.bai -@ 15
