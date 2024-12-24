#!/bin/bash

#SBATCH --time=48:00:00
#SBATCH --account=smontgom
#SBATCH --partition=nih_s10
#SBATCH --cpus-per-task=15
#SBATCH --mem=164GB
#SBATCH --job-name=PH119

#merge bam files


module load samtools

cd /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/


# samtools merge -f -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.deduplicated.sorted.bam -@ 15 \
# WGM_cfDNA_Pool_2_1_S14_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
# WGM_cfDNA_Pool_2_2_S15_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
# WGM_cfDNA_Pool_4_1_S38_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
# WGM_cfDNA_Pool_4_2_S39_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
# WGM_cfDNA_Pool_4_3_S40_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam

# samtools index PH119.deduplicated.sorted.bam -o PH119.deduplicated.sorted.bai -@ 15


#PH119 no exercise
samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.no_exercise.deduplicated.sorted.bam -@ 15 \
WGM_cfDNA_Pool_2_1_S14_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_4_1_S38_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_4_3_S40_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam

samtools index PH119.no_exercise.deduplicated.sorted.bam -o PH119.no_exercise.deduplicated.sorted.bai -@ 15


#PH119 exercise
samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.exercise.deduplicated.sorted.bam -@ 15 \
WGM_cfDNA_Pool_2_2_S15_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam \
WGM_cfDNA_Pool_4_2_S39_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam

samtools index PH119.exercise.deduplicated.sorted.bam -o PH119.exercise.deduplicated.sorted.bai -@ 15

