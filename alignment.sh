#!/bin/bash
# alignment.sh
# Description: Aligns cleaned Candida tropicalis RNA-Seq reads to the reference genome.
# This script builds a HISAT2 index, aligns paired-end reads, and sorts/indexes BAMs with SAMtools.

# STEP 1: Build HISAT2 index (run once)
# Input: C_tropicalis_genome.fasta
hisat2-build C_tropicalis_genome.fasta C_tropicalis_index

# STEP 2: Align each sample
for sample in SRR32455703 SRR32854559 SRR33760505
do
  # Align paired-end reads
  hisat2 -x C_tropicalis_index \
    -1 ${sample}_1_clean.fastq \
    -2 ${sample}_2_clean.fastq \
    -S ${sample}_aligned.sam \
    --summary-file ${sample}_alignment_summary.txt \
    2> ${sample}_hisat2.log

  # Convert SAM → BAM, sort, and index
  samtools view -bS ${sample}_aligned.sam > ${sample}_aligned.bam
  samtools sort ${sample}_aligned.bam -o ${sample}_sorted.bam
  samtools index ${sample}_sorted.bam

  # Clean up SAM (optional)
  rm ${sample}_aligned.sam
done

echo "Alignment complete for all samples. Sorted BAMs and indexes are ready for quantification."
