#!/bin/bash

#SBATCH --time=48:00:00
#SBATCH --account=smontgom
#SBATCH --partition=nih_s10
#SBATCH --cpus-per-task=15
#SBATCH --mem=164GB
#SBATCH --job-name=PH148

#merge bam files


module load samtools

cd /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/

#PH148
samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.deduplicated.sorted.bam -@ 15 \
WGM_cfDNA_Pool_4_9_S46_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_4_10_S47_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_4_11_S48_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_4_12_S49_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_4_13_S50_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam

samtools index PH148.deduplicated.sorted.bam -o PH148.deduplicated.sorted.bai -@ 15

#PH148
samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.no_exercise.deduplicated.sorted.bam -@ 15 \
WGM_cfDNA_Pool_4_9_S46_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_4_11_S48_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_4_13_S50_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam

samtools index PH148.no_exercise.deduplicated.sorted.bam -o PH148.no_exercise.deduplicated.sorted.bai -@ 15

samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.exercise.deduplicated.sorted.bam -@ 15 \
WGM_cfDNA_Pool_4_10_S47_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_4_12_S49_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam

samtools index PH148.exercise.deduplicated.sorted.bam -o PH148.exercise.deduplicated.sorted.bai -@ 15


