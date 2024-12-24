#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --account=smontgom
#SBATCH --partition=batch
#SBATCH --cpus-per-task=2
#SBATCH --mem=6GB
#SBATCH --job-name=insert_sizes

module load picard

line_number=$SLURM_ARRAY_TASK_ID #get index of which file to process from $SLURM_ARRAY_TASK_ID provided by SLURM

BAM_FILES="/oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/exercise_bam_paths.txt"
BAM_FILE="$(sed "${line_number}q; d" $BAM_FILES)"
BASENAME=$(basename ${BAM_FILE})
DIRNAME=$(dirname ${BAM_FILE})

METRICS_FILE=${DIRNAME}/${BASENAME}.insert_size_metrics.txt
HISTOGRAM_FILE=${DIRNAME}/${BASENAME}.insert_size_histogram.pdf

picard CollectInsertSizeMetrics W=800 I=${BAM_FILE} O=${METRICS_FILE} H=${HISTOGRAM_FILE}
# STOP_AFTER=1000

echo "Done with this job."
