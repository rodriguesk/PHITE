#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --partition=batch
#SBATCH --account=smontgom
#SBATCH --cpus-per-task=2
#SBATCH --mem=16GB
#SBATCH --job-name=count_reads



module load samtools

line_number=$SLURM_ARRAY_TASK_ID #get index of which file to process from $SLURM_ARRAY_TASK_ID provided by SLURM


bam_file="/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/total_read_count/BAMs"

input_bam="$(sed "${line_number}q; d" $bam_file)"

input_dir="/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/"

# Define the output directory
output_dir="/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/total_read_count/"

# Create the output directory if it doesn't exist
# mkdir -p "$output_dir"

base_name=$(basename "${input_bam}")

output_file="$output_dir/total_read_count_${base_name}.txt"

cd "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/"
samtools view -c -@ 2 -o "$output_file" "$input_bam"





