#!/bin/bash

#SBATCH --time=12:00:00
#SBATCH --account=default
#SBATCH --partition=interactive
#SBATCH --cpus-per-task=2
#SBATCH --mem=32GB
#SBATCH --job-name=coverage_calc
######SBATCH --partition=nih_s10


module load picard/2.26.4

#picard CollectWgsMetrics --INPUT /oak/stanford/scg/lab_sjaiswal/maurertm/methylseq/Old_Hiseq/results/results_2_2_2022/active_motif_control/zymo_control/pUC19_control/genome_alignment/A1_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.bam.sorted.bam --OUTPUT /oak/stanford/scg/lab_sjaiswal/maurertm/methylseq/Old_Hiseq/results/results_2_2_2022/active_motif_control/zymo_control/pUC19_control/genome_alignment/A1_wgs_coverage_metrics.txt --REFERENCE_SEQUENCE /oak/stanford/groups/smontgom/kameronr/methylseq/JG97/genomes/fasta_mouse/GRCm39.primary_assembly.genome.fa.gz --USE_FAST_ALGORITHM true


#picard CollectWgsMetrics --INPUT /oak/stanford/scg/lab_sjaiswal/maurertm/methylseq/Old_Hiseq/results/results_2_2_2022/active_motif_control/zymo_control/pUC19_control/genome_alignment/A1_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.bam.sorted.bam --OUTPUT /oak/stanford/scg/lab_sjaiswal/maurertm/methylseq/Old_Hiseq/results/results_2_2_2022/active_motif_control/zymo_control/pUC19_control/genome_alignment/A1_wgs_coverage_metrics.txt --REFERENCE_SEQUENCE /oak/stanford/groups/sjaiswal/genomes/GRCm39_fasta/GRCm39.genome.fa.gz

#file=/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/220125_NB551514_0728_AHWF72BGXH/output_02_12_22/phiX/lambda_phage/pUC19/GRCh38/Sample2_S2_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.bam

#unsorted_bam=/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/220125_NB551514_0728_AHWF72BGXH/output_02_12_22/phiX/lambda_phage/pUC19/GRCh38/Sample4_S2_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.bam

sorted_output=/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/220125_NB551514_0728_AHWF72BGXH/output_02_12_22/phiX/lambda_phage/pUC19/GRCh38/Sample1_S1_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam
#sorted_output=Sample4_S2_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.bam

#index_output=/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/220125_NB551514_0728_AHWF72BGXH/output_02_12_22/phiX/lambda_phage/pUC19/GRCh38/Sample4_S2_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.sorted.indexed.bam

#bash /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/code/methylseq_pipeline_v1/Kamerons_changes/sort_and_index.sh $unsorted_bam $sorted_output $index_output $index_output


#sorted_bam=/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/220125_NB551514_0728_AHWF72BGXH/output_02_12_22/phiX/lambda_phage/pUC19/GRCh38/Sample2_S2_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.bam.sorted.bam

fasta=/oak/stanford/groups/smontgom/kameronr/methylseq/JG97/genomes/fasta_human/GRCh38.primary_assembly.genome.fa

output=/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/220125_NB551514_0728_AHWF72BGXH/output_02_12_22/phiX/lambda_phage/pUC19/GRCh38/Sample1_S1_wgs_coverage_metrics.txt

picard CollectWgsMetrics --INPUT $sorted_output --OUTPUT $output --REFERENCE_SEQUENCE $fasta

#PICARD=/home/kameronr/picard.jar

#java -Xmx24g -jar $PICARD CollectWgsMetrics I=/workspace/align/WGS_Norm_merged_sorted_mrkdup_bqsr.bam O=/workspace/align/WGS_Norm_merged_metrics.txt R=/workspace/inputs/references/genome/ref_genome.fa INTERVALS=/workspace/inputs/references/genome/ref_genome_autosomal.interval_list

#java -Xmx24g -jar $PICARD CollectWgsMetrics I=/oak/stanford/scg/lab_sjaiswal/maurertm/methylseq/Old_Hiseq/results/results_2_2_2022/active_motif_control/zymo_control/pUC19_control/genome_alignment/A1_R1_001.trimmed.fastq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1.fq.gz_unmapped_reads_1_bismark_bt2_pe.deduplicated.bam.sorted.bam O=/oak/stanford/scg/lab_sjaiswal/maurertm/methylseq/Old_Hiseq/results/results_2_2_2022/active_motif_control/zymo_control/pUC19_control/genome_alignment/A1_wgs_coverage_metrics.txt R=/oak/stanford/groups/sjaiswal/genomes/GRCm39_fasta/GRCm39.genome.fa



