#Samssus Saintloth
# Build HISAT2 index (if not already built)
hisat2-build C_tropicalis_reference.fa C_tropicalis_index

# Align reads
hisat2 -x C_tropicalis_index -1 SRR32854559_1.clean.fastq -2 SRR32854559_2.clean.fastq -S SRR32854559.sam
hisat2 -x C_tropicalis_index -1 SRR33760505_1.clean.fastq -2 SRR33760505_2.clean.fastq -S SRR33760505.sam
hisat2 -x C_tropicalis_index -1 SRR32455703_1.clean.fastq -2 SRR32455703_2.clean.fastq -S SRR32455703.sam

# Convert, sort, and index BAM files
for sample in SRR32854559 SRR33760505 SRR32455703
do
  samtools view -bS ${sample}.sam > ${sample}.bam
  samtools sort ${sample}.bam -o ${sample}.sorted.bam
  samtools index ${sample}.sorted.bam
done
