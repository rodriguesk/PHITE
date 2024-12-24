#!/bin/bash


module load samtools



samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH117.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH117.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH117.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH117.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH117.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH117.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH117.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH117.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.no_exercise.deduplicated.sorted.bam chrM



samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH119.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH119.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH119.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH119.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH119.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH119.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH119.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH119.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.no_exercise.deduplicated.sorted.bam chrM




samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH129.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH129.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH129.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH129.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH129.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH129.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH129.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH129.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH129.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH129.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH129.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH129.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH129.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH129.no_exercise.deduplicated.sorted.bam chrM




samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH133.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH133.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH133.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH133.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH133.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH133.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH133.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH133.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH133.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH133.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH133.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH133.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH133.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH133.no_exercise.deduplicated.sorted.bam chrM




samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH137.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH137.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH137.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH137.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH137.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH137.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH137.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH137.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH137.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH137.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH137.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH137.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH137.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH137.no_exercise.deduplicated.sorted.bam chrM




samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH138.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH138.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH138.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH138.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH138.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH138.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH138.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH138.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.no_exercise.deduplicated.sorted.bam chrM






samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH142.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH142.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH142.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH142.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH142.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH142.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH142.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH142.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH142.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH142.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH142.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH142.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH142.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH142.no_exercise.deduplicated.sorted.bam chrM




samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH144.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH144.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH144.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH144.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH144.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH144.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH144.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH144.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH144.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH144.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH144.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH144.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH144.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH144.no_exercise.deduplicated.sorted.bam chrM




samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH148.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH148.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH148.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH148.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH148.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH148.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH148.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH148.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.no_exercise.deduplicated.sorted.bam chrM



samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH154.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH154.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH154.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH154.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH154.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH154.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH154.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH154.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*[Z]/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH154.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH154.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH154.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH154.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH154.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH154.no_exercise.deduplicated.sorted.bam chrM



cd ~

sbatch ~/sort_and_index_submit.sh /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/

cd /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/




