#Samsus Saintloth
# Download raw data from NCBI SRA
prefetch SRR32854559
prefetch SRR33760505
prefetch SRR32455703

# Convert SRA to FASTQ (single-end or paired-end as needed)
fastq-dump --split-files SRR32854559.sra
fastq-dump --split-files SRR33760505.sra
fastq-dump --split-files SRR32455703.sra
