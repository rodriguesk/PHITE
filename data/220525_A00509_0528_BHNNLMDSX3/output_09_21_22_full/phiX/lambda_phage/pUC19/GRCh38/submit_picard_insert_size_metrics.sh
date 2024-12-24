#!/bin/bash

#SBATCH --time=2:00:00
#SBATCH --partition=interactive
#SBATCH --account=default
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
#SBATCH --job-name=submit_insert_size


# data_path=$1

data_path="/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/"
#code_directory=$( realpath . )
code_directory="/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/"

Logs="${data_path}/Logs_insert_size"
mkdir $Logs

bam_file="/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/exercise_bam_paths.txt" 
#fastq=$(find "$data_path/fastq" -type f | grep ".*\.fastq.gz$" | sort -u | wc -l)
# find "$data_path" -type f | grep ".*\.deduplicated.bam$" | sort -u > "${bam_file}"  
# find "$data_path" -type f | grep ".*\.Aligned.toTranscriptome.out.bam$" | sort -u > "${bam_file}"  
#find "$data_path" -type f | grep ".*Aligned.sortedByCoord.out.bam$" | sort -u > "${bam_file}"  
#find "$data_path" -type f | grep ".*deduplicated.bam$" | sort -u > "${bam_file}"  
# find "$data_path" -type f | grep ".*.bam$" | sort -u > "${bam_file}"

array_length=$(wc -l < "${bam_file}")

sbatch -o "$Logs/${log_name}_%A_%a.log" `#put into log` \
                   -a "1-${array_length}" `#initiate job array equal to the number of bam files` \
                    "${code_directory}/picard_insert_size_metrics_job.sh" \
                    $data_path
