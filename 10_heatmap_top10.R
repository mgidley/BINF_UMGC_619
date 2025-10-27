#Samsus Saintloth
# Loads R libraries
library(readr)     # For reading csv files
library(pheatmap)  # For heatmaps

# Reads the data
data <- read_csv("top10_expression.csv")

# Set row names to gene names and remove the Gene column
mat <- as.data.frame(data)
rownames(mat) <- mat$Gene
mat$Gene <- NULL

#  log-transform for visualization
mat_log2 <- log2(mat + 1)

# Draw the heatmap
pheatmap(mat_log2, 
         main="Top 10 Expressed Genes Across Samples (log2 scale)",
         color = colorRampPalette(c("navy", "white", "firebrick3"))(100),
         cluster_rows = TRUE, cluster_cols = TRUE,
         fontsize_row = 10, fontsize_col = 10,
         angle_col = 45)
