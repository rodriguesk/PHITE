#!/bin/bash

#SBATCH --time=48:00:00
#SBATCH --account=smontgom
#SBATCH --partition=nih_s10
#SBATCH --cpus-per-task=15
#SBATCH --mem=164GB
#SBATCH --job-name=PH138

#merge bam files


module load samtools

cd /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/

#PH138
samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.deduplicated.sorted.bam -@ 15 \
WGM_cfDNA_Pool_2_8_S21_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_9_S22_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_10_S23_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_11_S24_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_12_S25_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam



samtools index PH138.deduplicated.sorted.bam -o PH138.deduplicated.sorted.bai -@ 15



#PH138
samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.no_exercise.deduplicated.sorted.bam -@ 15 \
WGM_cfDNA_Pool_2_8_S21_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_10_S23_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_12_S25_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam

samtools index PH138.no_exercise.deduplicated.sorted.bam -o PH138.no_exercise.deduplicated.sorted.bai -@ 15

samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.exercise.deduplicated.sorted.bam -@ 15 \
WGM_cfDNA_Pool_2_9_S22_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_11_S24_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam

samtools index PH138.exercise.deduplicated.sorted.bam -o PH138.exercise.deduplicated.sorted.bai -@ 15


