#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --partition=batch
#SBATCH --account=smontgom
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --job-name=submit


input_dir="/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/"

# Define the output directory
output_dir="/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/total_read_count/"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"


data_path="/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/total_read_count"
code_directory="/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/total_read_count"
Logs="${data_path}/Logs"
mkdir $Logs
bam_file="${data_path}/BAMs" 
#find "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38" -type f | grep ".*_reads_1_bismark_bt2_pe.deduplicated.sorted.bam$" | sort -u > "${bam_file}"

cd "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/"
ls *_reads_1_bismark_bt2_pe.deduplicated.sorted.bam > "${bam_file}"

cd "/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/total_read_count"
array_length=$(wc -l < "${bam_file}")

sbatch -o "$Logs/${log_name}_%A_%a.log" `#put into log` \
                   -a "1-${array_length}" `#initiate job array equal to the number of bam files` \
                    "${code_directory}/count_total_reads_job.sh"




