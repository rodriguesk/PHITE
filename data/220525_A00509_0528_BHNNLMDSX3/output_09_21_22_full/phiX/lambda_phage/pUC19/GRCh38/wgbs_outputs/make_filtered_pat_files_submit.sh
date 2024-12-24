#!/bin/bash

#SBATCH --job-name=wgbs_submit
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=batch
#SBATCH --account=smontgom
#SBATCH --mem=32G
#SBATCH --time=1:00:00


cd /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis

#git clone https://github.com/nloyfer/wgbs_tools.git
cd wgbs_tools

# compile

micromamba deactivate

#run these 3 lines before running this script... run in the login node
#module load miniconda3
#module load miniconda3/4.5.11
module load anaconda
module load gcc
#module load bioconda
#module load samtools/1.9
#module load tabix/0.2.6 
#module load bedtools

source activate
conda deactivate
conda activate wgbs3

python setup.py
export PATH=${PATH}:$PWD

#wgbstools bam2pat
#usage: bam2pat [-h] [-s SITES | -r REGION] [--genome GENOME]
#               [--out_dir OUT_DIR] [--min_cpg MIN_CPG] [--debug] [--force]
#               [--verbose] [--include_flags INCLUDE_FLAGS] [-F EXCLUDE_FLAGS]
#               [-q MAPQ] [--clip CLIP] [-@ THREADS] [--no_beta] [-l]
#               [-T TEMP_DIR] [--blacklist [BLACKLIST] | -L [WHITELIST]]
#               [--mbias] [--blueprint]
#               bam [bam ...]


#already done, but should be done the first time!
#wgbstools init_genome GRCm39 --fasta_path /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/genomes/GRCm39_fasta/GRCm39.genome.fa --force
#wgbstools set_default_ref --name GRCm39

# region=chr5:91025553-91046088
#wgbstools convert -r $region --genome GRCm39
#wgbstools bam2pat bams/*.bam -r $region

#make beta and pat files from deduplicates bam files

#/oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis/sorted_deduplicated_bams/


data_path=$1
code_directory=$( realpath . )

Logs="${data_path}/Logs"

mkdir $Logs
bam_file="${data_path}/PATs" 

#find "$data_path" -type f | grep ".*pat.gz" | sort -u > "${bam_file}"  

array_length=$(wc -l < "${bam_file}")
# sbatch -o "$Logs/${log_name}_%A_%a.log" `#put into log` \
#                    -a "1-${array_length}" `#initiate job array equal to the number of bam files` \
#                     "${code_directory}/make_pat_and_beta_files_job.sh" \
#                     $data_path

sbatch -o "$Logs/${log_name}_%A_%a.log" `#put into log` \
                   -a "1-${array_length}" `#initiate job array equal to the number of bam files` \
                    "${data_path}/make_filtered_pat_files_job.sh" \
                    $data_path


# wgbstools bam2pat /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis/sorted_deduplicated_bams/EM_2_13_R1_001.trimmed_bismark_bt2_pe.deduplicated.sorted.bam --out_dir . --genome GRCm39 --min_cpg 1 -@ 16 --verbose

# wgbstools bam2pat /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis/sorted_deduplicated_bams/EM_2_1_R1_001.trimmed_bismark_bt2_pe.deduplicated.sorted.bam --out_dir . --genome GRCm39 --min_cpg 1 -@ 16 --verbose

# wgbstools bam2pat /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis/sorted_deduplicated_bams/EM_3_7_R1_001.trimmed_bismark_bt2_pe.deduplicated.sorted.bam --out_dir . --genome GRCm39 --min_cpg 1 -@ 16 --verbose

# wgbstools bam2pat /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis/sorted_deduplicated_bams/EM_6_15_R1_001.trimmed_bismark_bt2_pe.deduplicated.sorted.bam --out_dir . --genome GRCm39 --min_cpg 1 -@ 16 --verbose

# wgbstools bam2pat /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis/sorted_deduplicated_bams/EM_6_3_R1_001.trimmed_bismark_bt2_pe.deduplicated.sorted.bam --out_dir . --genome GRCm39 --min_cpg 1 -@ 16 --verbose

# wgbstools bam2pat /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis/sorted_deduplicated_bams/EM_8_19_R1_001.trimmed_bismark_bt2_pe.deduplicated.sorted.bam --out_dir . --genome GRCm39 --min_cpg 1 -@ 16 --verbose
