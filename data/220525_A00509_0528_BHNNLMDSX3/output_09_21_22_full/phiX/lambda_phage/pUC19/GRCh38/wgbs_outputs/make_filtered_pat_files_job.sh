#!/bin/bash

#SBATCH --job-name=wgbs
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --partition=batch
#SBATCH --account=smontgom
#SBATCH --mem=600G
#SBATCH --time=72:00:00

line_number=$SLURM_ARRAY_TASK_ID #get index of which file to process from $SLURM_ARRAY_TASK_ID provided by SLURM
data_path=$1
bam_file="${data_path}/PATs"

pat_path="$(sed "${line_number}q; d" $bam_file)"

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
pat="$(basename ${pat_path})"
U25_out_file="/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/wgbs_outputs/filtered_pats/filtered_U25_$pat"
U250_out_file="/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/wgbs_outputs/filtered_pats/filtered_U250_$pat"

wgbstools view --genome GRCh38 -L /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/wgbs_outputs/deconv_atlas/Atlas.U25.l4.hg38.full.compatible.bed -o $U25_out_file $pat_path

#wgbstools view --genome GRCh38 -L /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/wgbs_outputs/deconv_atlas/Atlas.U250.l4.hg38.full.compatible.bed -o $U250_out_file $pat_path




# wgbstools bam2pat /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis/sorted_deduplicated_bams/EM_2_13_R1_001.trimmed_bismark_bt2_pe.deduplicated.sorted.bam --out_dir . --genome GRCm39 --min_cpg 1 -@ 16 --verbose

# wgbstools bam2pat /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis/sorted_deduplicated_bams/EM_2_1_R1_001.trimmed_bismark_bt2_pe.deduplicated.sorted.bam --out_dir . --genome GRCm39 --min_cpg 1 -@ 16 --verbose

# wgbstools bam2pat /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis/sorted_deduplicated_bams/EM_3_7_R1_001.trimmed_bismark_bt2_pe.deduplicated.sorted.bam --out_dir . --genome GRCm39 --min_cpg 1 -@ 16 --verbose

# wgbstools bam2pat /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis/sorted_deduplicated_bams/EM_6_15_R1_001.trimmed_bismark_bt2_pe.deduplicated.sorted.bam --out_dir . --genome GRCm39 --min_cpg 1 -@ 16 --verbose

# wgbstools bam2pat /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis/sorted_deduplicated_bams/EM_6_3_R1_001.trimmed_bismark_bt2_pe.deduplicated.sorted.bam --out_dir . --genome GRCm39 --min_cpg 1 -@ 16 --verbose

# wgbstools bam2pat /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/novaseq/EMseq_big_20230117/usftp21.novogene.com/output_processed/wgbs_analysis/sorted_deduplicated_bams/EM_8_19_R1_001.trimmed_bismark_bt2_pe.deduplicated.sorted.bam --out_dir . --genome GRCm39 --min_cpg 1 -@ 16 --verbose
