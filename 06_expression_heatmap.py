#Samsus Saintloth
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

# Load featureCounts output (after  script-based conversion to better format)
counts = pd.read_csv('top10_expression.csv', index_col=0)

#  log2 transform
counts_log2 = np.log2(counts + 1)

plt.figure(figsize=(8, 6))
sns.heatmap(counts_log2, annot=True, cmap="viridis", linewidths=0.5)
plt.title("Top 10 Expressed Genes Across Samples (log2 scale)")
plt.xlabel("Samples")
plt.ylabel("Genes")
plt.tight_layout()
plt.show()
