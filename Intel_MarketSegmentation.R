# Install necessary packages
install.packages("readxl")
install.packages("tidyverse")
install.packages("cluster")
install.packages("openxlsx")


# Loading libraries
library(readxl)     
library(tidyverse)   
library(cluster)     
library(openxlsx)    



# IMPORTING DATA FROM EXCEL 
library(readxl)
SmartWatch <- read_excel("C:/Users/karis/Downloads/SmartWatch Data File.xlsx")

#Displaying the data
View(SmartWatch)

# INITIAL DATA EXPLORATION 
# Display column names of the dataset
names(SmartWatch)
# Display basic summary statistics for each variable
summary(SmartWatch)

# STANDARDISE DATA
dfz <- scale(SmartWatch)

#standardised data
View(dfz) 


# CALCULATE EUCLIDEAN DISTANCE
distance <- dist(dfz, method = 'euclidean')

# CLUSTER DENDROGRAM 
hc.w <- hclust(distance, method = 'ward.D')

# Plot the dendrogram to visualise the clustering
plot(hc.w, main = "Cluster Dendrogram",cex = 0.8, hang = -1, xlab = "Observations", ylab = "Height")

# DETERMINING THE OPTIMAL NUMBER OF CLUSTERS

x <- c(1:10)
sort_height <- sort(hc.w$height, decreasing = TRUE)
y <- sort_height[1:10]

# Plot elbow plot
plot(x, y, type = "b", main = "Elbow Plot", xlab = "Number of Clusters", ylab = "Height")
lines(x, y, col = "blue")

# Display clusters on dendrogram
plot(hc.w, main = "Cluster Dendrogram",cex = 0.8, hang = -1, xlab = "Observations", ylab = "Height")
rect.hclust(hc.w, k = 4, border = 2:5)   # Here, we choose 4 clusters

# CUT DENDROGRAM INTO 4 CLUSTERS
cluster <- cutree(hc.w, k = 4)  # Here, we choose 4 clusters

# Create a frequency table to see the size of each cluster
table(cluster)

# Add cluster assignments back to the original data
Sw_final <- cbind(SmartWatch, cluster)

# Check the updated dataset
View(Sw_final)


# CALCULATE SEGMENT SIZES
# Proportions of each cluster
proportions <- table(Sw_final$cluster) / nrow(Sw_final)
percentages <- proportions * 100

# Display segment sizes in percentages
print(percentages)

# Calculate mean values of selected variables grouped by cluster
segments<-
  Sw_final %>% 
  group_by(cluster) %>% 
  summarise(across(where(is.numeric), mean, .names = "{col}_mean"))

# Display the calculated means
segments


# SAVE MEAN TABLE TO EXCEL
# Export the summarised data to an Excel file
write.xlsx(segments, 'segments.xlsx')

# Calculate an Attractiveness Score
# Define attractiveness from Intel's perspective (productivity, device sturdiness, high-income, younger consumers)

colnames(segments)

segments$Attractiveness_Score <- with(segments,
                                      scale(ConstCom_mean) +
                                        scale(TaskMgm_mean) +
                                        scale(DeviceSt_mean) +
                                        scale(Style_mean) +
                                        scale(Income_mean) +
                                        scale(Degree_mean) +
                                        scale(AmznP_mean) -
                                        scale(Age_mean) 
)

# Estimating Competitive Strength 
# High competitor presence where Style, Well-being and Device sturdiness are very high.
segments$Competitor_Strength <- with(segments, 
                                     scale(Style_mean) + 
                                       scale(DeviceSt_mean) + 
                                       scale(Wellness_mean)
)

# Calculate Intel Opportunity (Attractiveness - Competitor Strength)
segments$Intel_Opportunity <- segments$Attractiveness_Score - segments$Competitor_Strength

# Identify the best segment for Intel
best_segment <- segments %>%
  filter(Intel_Opportunity == max(Intel_Opportunity))

print("Recommended Segment for Intel:")
print(best_segment)

# Detailed Segment Discussion and Intel Positioning
for (i in 1:nrow(segments)) {
  cat("\nSegment:", segments$cluster[i], "\n")
  cat("Attractiveness:", round(segments$Attractiveness_Score[i], 2), "\n")
  cat("Competitor Strength:", round(segments$Competitor_Strength[i], 2), "\n")
  cat("Intel Opportunity:", round(segments$Intel_Opportunity[i], 2), "\n")
}

# Final Recommendation:
cat("\nIntel should target Segment", best_segment$cluster,
    "due to highest opportunity (", round(best_segment$Intel_Opportunity,2),").\n")

# Save complete results to Excel
write.xlsx(segments, 'Final_Intel_Segmentation.xlsx')
getwd()
