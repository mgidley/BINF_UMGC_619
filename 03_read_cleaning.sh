#Samsus Saintloth
# Use fastp for adapter and quality trimming
fastp -i SRR32854559_1.fastq -I SRR32854559_2.fastq -o SRR32854559_1.clean.fastq -O SRR32854559_2.clean.fastq --length_required 50 --html SRR32854559_fastp.html

fastp -i SRR33760505_1.fastq -I SRR33760505_2.fastq -o SRR33760505_1.clean.fastq -O SRR33760505_2.clean.fastq --length_required 50 --html SRR33760505_fastp.html

fastp -i SRR32455703_1.fastq -I SRR32455703_2.fastq -o SRR32455703_1.clean.fastq -O SRR32455703_2.clean.fastq --length_required 50 --html SRR32455703_fastp.html
