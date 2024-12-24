#!/bin/bash

#SBATCH --time=48:00:00
#SBATCH --account=smontgom
#SBATCH --partition=nih_s10
#SBATCH --cpus-per-task=15
#SBATCH --mem=164GB
#SBATCH --job-name=PH117

#merge bam files


module load samtools

cd /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/

samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.deduplicated.sorted.bam -@ 15 \
WGM_cfDNA_Pool_2_3_S16_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_5_S18_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_7_S20_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_4_S17_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_6_S19_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam

samtools index PH117.deduplicated.sorted.bam -o PH117.deduplicated.sorted.bai -@ 15

#PH117
samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.no_exercise.deduplicated.sorted.bam -@ 15 \
WGM_cfDNA_Pool_2_3_S16_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_5_S18_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_7_S20_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam

samtools index PH117.no_exercise.deduplicated.sorted.bam -o PH117.no_exercise.deduplicated.sorted.bai -@ 15

samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.exercise.deduplicated.sorted.bam -@ 15 \
WGM_cfDNA_Pool_2_4_S17_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_2_6_S19_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam

samtools index PH117.exercise.deduplicated.sorted.bam -o PH117.exercise.deduplicated.sorted.bai -@ 15



