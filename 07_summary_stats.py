# Samsus Saintlooth


import os
import glob
import pandas as pd
import json

# ----- CONFIGURATION -----

REPORTS_DIR = "./"
SAMPLES = ["SRR32455703", "SRR32854559", "SRR33760505"]

def parse_fastqc_data(fastqc_data_path):
    """Extract total sequences and duplication levels from fastqc_data.txt"""
    total_sequences = None
    duplication = None
    with open(fastqc_data_path) as fh:
        for line in fh:
            if line.startswith("Total Sequences"):
                total_sequences = int(line.strip().split("\t")[1])
            if line.startswith("Sequence Duplication Levels"):
                # The next non-header line contains %duplication, but for conciseness we'll use overall duplication if present
                pass
            if line.startswith("Percent Duplication"):
                duplication = float(line.strip().split("\t")[1])
    return total_sequences, duplication

def parse_fastp_json(fastp_json_path):
    """Extract relevant metrics from fastp json report"""
    with open(fastp_json_path) as f:
        d = json.load(f)
    try:
        total_reads = d['summary']['before_filtering']['total_reads']
        filtered_reads = d['summary']['after_filtering']['total_reads']
        dup_rate = d['duplication']['rate'] * 100  # Convert to percent
    except KeyError:
        total_reads = filtered_reads = dup_rate = None
    return total_reads, filtered_reads, dup_rate

def main():
    rows = []
    for sample in SAMPLES:
        # Try FastQC
        fq_dir = f"{sample}_fastqc"
        fq_data = os.path.join(REPORTS_DIR, fq_dir, "fastqc_data.txt")
        total_reads, dup_rate = None, None
        if os.path.isfile(fq_data):
            total_reads, dup_rate = parse_fastqc_data(fq_data)
        else:
            # Try fastp JSON
            fastp_json = os.path.join(REPORTS_DIR, f"{sample}_fastp.json")
            if os.path.isfile(fastp_json):
                total_reads, filtered_reads, dup_rate = parse_fastp_json(fastp_json)
            else:
                print(f"Warning: No report found for sample {sample}")
        rows.append({
            "Sample": sample,
            "Raw read counts": total_reads,
            "Duplication rate (%)": dup_rate
        })
    # Output summary table
    summary_df = pd.DataFrame(rows)
    print(summary_df.to_string(index=False))

if __name__ == "__main__":
    main()
