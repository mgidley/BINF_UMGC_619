# BINF_UMGC_619
619 Group project template
### Alignment (HISAT2 + SAMtools)
The cleaned paired-end reads (SRR32455703, SRR32854559, SRR33760505) were aligned to the Candida tropicalis reference genome using HISAT2. The workflow:
1. Build a genome index with `hisat2-build`
2. Align each sample with `hisat2`
3. Convert SAM to BAM, then sort and index using `samtools`

This step produces sorted, indexed BAM files for each sample, which are then used as input for gene-level quantification with featureCounts. The full workflow is included in `alignment.sh`.
 
