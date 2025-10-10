#!/bin/bash
# alignment.sh
# Contributor: Lydia Dagne
# Description: Aligns cleaned RNA-Seq reads of Candida tropicalis to the reference genome using HISAT2 and generates sorted BAM files.

# Step 1: Build HISAT2 index (only once)
# Reference genome files: C_tropicalis_genome.fasta and annotation.gff
hisat2-build C_tropicalis_genome.fasta C_tropicalis_index

# Step 2: Align paired-end reads for each sample
for sample in SRR32455703 SRR32854559 SRR33760505
do
  hisat2 -x C_tropicalis_index \
    -1 ${sample}_1_clean.fastq \
    -2 ${sample}_2_clean.fastq \
    -S ${sample}_aligned.sam \
    --summary-file ${sample}_alignment_summary.txt \
    2> ${sample}_hisat2.log

  # Step 3: Convert SAM to BAM, sort, and index
  samtools view -bS ${sample}_aligned.sam > ${sample}_aligned.bam
  samtools sort ${sample}_aligned.bam -o ${sample}_sorted.bam
  samtools index ${sample}_sorted.bam

  # Optional cleanup
  rm ${sample}_aligned.sam
done

echo "Alignment complete for all samples."
