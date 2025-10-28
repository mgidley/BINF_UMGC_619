import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

# Read counts file, skip comments
counts = pd.read_csv("counts.txt", sep="\t", comment="#")

# Identify the sample columns (all columns after the first 6)
sample_cols = counts.columns[6:]

# Select only sample counts and convert to numeric
counts_samples = counts[sample_cols].apply(pd.to_numeric)

# Select top 10 genes by total counts across all samples
top10_genes = counts_samples.sum(axis=1).nlargest(10).index
top10_counts = counts_samples.loc[top10_genes]

# Log2 transform for heatmap visualization
top10_counts_log = np.log2(top10_counts + 1)

# Plot heatmap including all samples
sns.heatmap(top10_counts_log, annot=True, cmap="Reds", vmin=0)
plt.title("Top 10 Genes Across All Samples")
plt.ylabel("Gene")
plt.show()
