

#awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /Z.*Z.*Z/) { print $1; break } } }'

# samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print ; break } } }' | head



#bam files requiring at least 2 CpG methylation in the read pair:


samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH117.no_exercise.deduplicated.sorted.bam chrM



samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH119.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH119.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH119.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH119.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH119.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH119.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH119.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH119.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH119.no_exercise.deduplicated.sorted.bam chrM




samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH129.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH129.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH129.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH129.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH129.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH129.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH129.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH129.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH129.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH129.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH129.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH129.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH129.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH129.no_exercise.deduplicated.sorted.bam chrM




samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH133.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH133.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH133.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH133.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH133.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH133.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH133.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH133.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH133.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH133.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH133.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH133.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH133.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH133.no_exercise.deduplicated.sorted.bam chrM




samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH137.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH137.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH137.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH137.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH137.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH137.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH137.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH137.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH137.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH137.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH137.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH137.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH137.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH137.no_exercise.deduplicated.sorted.bam chrM




samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH138.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH138.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH138.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH138.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH138.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH138.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH138.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH138.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH138.no_exercise.deduplicated.sorted.bam chrM






samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH142.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH142.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH142.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH142.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH142.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH142.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH142.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH142.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH142.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH142.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH142.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH142.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH142.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH142.no_exercise.deduplicated.sorted.bam chrM




samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH144.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH144.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH144.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH144.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH144.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH144.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH144.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH144.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH144.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH144.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH144.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH144.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH144.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH144.no_exercise.deduplicated.sorted.bam chrM




samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH148.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH148.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH148.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH148.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH148.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH148.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH148.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH148.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH148.no_exercise.deduplicated.sorted.bam chrM



samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH154.exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH154.exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH154.exercise.deduplicated.sorted.bam chrM

samtools view /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH154.no_exercise.deduplicated.sorted.bam chrM | awk '{ for (i=1; i<=NF; i++) { if ($i ~ /^XM:Z:/ && $i ~ /XM:Z:.*Z.*Z/) { print $1; break } } }' > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.no_exercise.deduplicated.sorted.mito.CpGmethylated.bam -N /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.no_exercise.deduplicated.sorted.mito.CpGmethylated_reads.txt /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH154.no_exercise.deduplicated.sorted.bam chrM

samtools view -b -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.no_exercise.deduplicated.sorted.mito.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/PH154.no_exercise.deduplicated.sorted.bam chrM



cd ~

sbatch ~/sort_and_index_submit.sh /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/

cd /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/





#calculate regions that the bam reads cover and put into bed file so can summarize into number of nucleotides covered
module load bedtools
module load samtools

#should it be paired end bed file or not?

# bedtools bamtobed -i /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/PH117.no_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam


samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.no_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.no_exercise.mito.CpGmethylated.bed 

#merged fragments (but not filtered by coverage yet)
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.no_exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.no_exercise.mito.CpGmethylated.merged_no_cov_filter.bed


# sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.no_exercise.mito.CpGmethylated.bed | bedtools coverage -d -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.no_exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b -

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.no_exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.no_exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - | awk '$4 > 1'




samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.exercise.mito.CpGmethylated.bed 

#merged fragments (but not filtered by coverage yet)
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.exercise.mito.CpGmethylated.merged_no_cov_filter.bed

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - | awk '$4 > 1'



#merge bams that are NuMTs (methylated mito-like reads) from both exercise and non-exercise samples from the same participant, then run the procedure for determining reference NuMT regions
samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.no_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam 

samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH117.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.no_exercise_and_exercise.mito.CpGmethylated.bed 

#merged fragments (but not filtered by coverage yet)
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
#actually only keep fragments that have evidence via at least 10 reads. (>9 reads) (and just assume the rest are from mosaicism?)
#actually, for now don't filter.
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH117.no_exercise_and_exercise.mito.CpGmethylated.merged_cov_filter.bed







samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH119.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH119.no_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH119.exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam 

samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH119.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH119.no_exercise_and_exercise.mito.CpGmethylated.bed 

#merged fragments (but not filtered by coverage yet)
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH119.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH119.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
#actually only keep fragments that have evidence via at least 10 reads. (>9 reads) (and just assume the rest are from mosaicism?)
#actually, for now don't filter.
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH119.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH119.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH119.no_exercise_and_exercise.mito.CpGmethylated.merged_cov_filter.bed







samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH129.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH129.no_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH129.exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam 

samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH129.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH129.no_exercise_and_exercise.mito.CpGmethylated.bed 

#merged fragments (but not filtered by coverage yet)
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH129.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH129.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
#actually only keep fragments that have evidence via at least 10 reads. (>9 reads) (and just assume the rest are from mosaicism?)
#actually, for now don't filter.
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH129.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH129.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH129.no_exercise_and_exercise.mito.CpGmethylated.merged_cov_filter.bed





samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH133.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH133.no_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH133.exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam 

samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH133.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH133.no_exercise_and_exercise.mito.CpGmethylated.bed 

#merged fragments (but not filtered by coverage yet)
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH133.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH133.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
#actually only keep fragments that have evidence via at least 10 reads. (>9 reads) (and just assume the rest are from mosaicism?)
#actually, for now don't filter.
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH133.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH133.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH133.no_exercise_and_exercise.mito.CpGmethylated.merged_cov_filter.bed






samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH137.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH137.no_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH137.exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam 

samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH137.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH137.no_exercise_and_exercise.mito.CpGmethylated.bed 

#merged fragments (but not filtered by coverage yet)
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH137.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH137.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
#actually only keep fragments that have evidence via at least 10 reads. (>9 reads) (and just assume the rest are from mosaicism?)
#actually, for now don't filter.
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH137.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH137.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH137.no_exercise_and_exercise.mito.CpGmethylated.merged_cov_filter.bed





samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH138.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH138.no_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH138.exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam 

samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH138.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH138.no_exercise_and_exercise.mito.CpGmethylated.bed 

#merged fragments (but not filtered by coverage yet)
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH138.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH138.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
#actually only keep fragments that have evidence via at least 10 reads. (>9 reads) (and just assume the rest are from mosaicism?)
#actually, for now don't filter.
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH138.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH138.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH138.no_exercise_and_exercise.mito.CpGmethylated.merged_cov_filter.bed





samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH142.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH142.no_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH142.exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam 

samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH142.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH142.no_exercise_and_exercise.mito.CpGmethylated.bed 

#merged fragments (but not filtered by coverage yet)
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH142.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH142.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
#actually only keep fragments that have evidence via at least 10 reads. (>9 reads) (and just assume the rest are from mosaicism?)
#actually, for now don't filter.
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH142.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH142.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH142.no_exercise_and_exercise.mito.CpGmethylated.merged_cov_filter.bed





samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH144.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH144.no_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH144.exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam 

samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH144.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH144.no_exercise_and_exercise.mito.CpGmethylated.bed 

#merged fragments (but not filtered by coverage yet)
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH144.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH144.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
#actually only keep fragments that have evidence via at least 10 reads. (>9 reads) (and just assume the rest are from mosaicism?)
#actually, for now don't filter.
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH144.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH144.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH144.no_exercise_and_exercise.mito.CpGmethylated.merged_cov_filter.bed






samtools merge -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH148.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH148.no_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH148.exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam 

samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH148.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH148.no_exercise_and_exercise.mito.CpGmethylated.bed 

#merged fragments (but not filtered by coverage yet)
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH148.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH148.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
#actually only keep fragments that have evidence via at least 10 reads. (>9 reads) (and just assume the rest are from mosaicism?)
#actually, for now don't filter.
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH148.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH148.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH148.no_exercise_and_exercise.mito.CpGmethylated.merged_cov_filter.bed





samtools merge -f -o /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.no_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam 

samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.no_exercise_and_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.no_exercise_and_exercise.mito.CpGmethylated.bed 

#merged fragments (but not filtered by coverage yet)
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
#actually only keep fragments that have evidence via at least 10 reads. (>9 reads) (and just assume the rest are from mosaicism?)
#actually, for now don't filter.
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.no_exercise_and_exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.no_exercise_and_exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.no_exercise_and_exercise.mito.CpGmethylated.merged_cov_filter.bed






samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.exercise.mito.CpGmethylated.bed 


sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.exercise.mito.CpGmethylated.merged_no_cov_filter.bed

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
#actually only keep fragments that have evidence via at least 10 reads. (>9 reads) (and just assume the rest are from mosaicism?)
#actually, for now don't filter.
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.exercise.mito.CpGmethylated.merged_cov_filter.bed






samtools sort -n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/PH154.no_exercise.deduplicated.sorted.mito.CpGmethylated.sorted.bam | bedtools bamtobed -bedpe -i - | cut -f1,2,6 - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.no_exercise.mito.CpGmethylated.bed 


sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.no_exercise.mito.CpGmethylated.bed | bedtools merge -d -1 -i - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.no_exercise.mito.CpGmethylated.merged_no_cov_filter.bed

#Only remove fragments if there’s no other reads overlaping any of it… ? for now, yes
#actually only keep fragments that have evidence via at least 10 reads. (>9 reads) (and just assume the rest are from mosaicism?)
#actually, for now don't filter.
sort -k1,1 -k2,2n -k3,3n /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.no_exercise.mito.CpGmethylated.bed | bedtools coverage -counts -a /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.no_exercise.mito.CpGmethylated.merged_no_cov_filter.bed -b - > /oak/stanford/groups/smontgom/kameronr/CF_DNA_methylation/data/220525_A00509_0528_BHNNLMDSX3/output_09_21_22_full/phiX/lambda_phage/pUC19/GRCh38/mito_metrics/filt_2CpGs/coverage/PH154.no_exercise.mito.CpGmethylated.merged_cov_filter.bed





