# 🧠 Intel Market Segmentation using R

Welcome to the **Intel Market Segmentation** project — where data science meets strategic decision-making.

This project harnesses the power of **unsupervised machine learning** and **cluster analysis** to help **Intel** understand **smartwatch market segments**, assess **market attractiveness**, and identify **growth opportunities**.

---

## 📌 Project Overview

💡 **Objective**: 
Segment consumers based on their smartwatch usage behavior and demographic traits to identify the most promising group for Intel to target.

🎯 **Key Business Questions**:
- Which market segment is most attractive to Intel?
- Where does Intel face the strongest competition?
- How can Intel strategically position its offering?

---

## 🔍 Workflow Summary

The project follows this step-by-step pipeline:

1. **📥 Data Import & Exploration**
   - Data read from Excel using `readxl`
   - Initial statistics & structure explored

2. **🧽 Data Preprocessing**
   - Standardization using `scale()` for fair clustering
   - Euclidean distance computation

3. **🌳 Hierarchical Clustering**
   - Clustering via Ward's method
   - Dendrogram and Elbow method for optimal k
   - Final model: **4 clusters**

4. **📊 Cluster Profiling**
   - Segment proportions
   - Mean values of key traits for each segment

5. **🧮 Strategic Scoring**
   - **Attractiveness Score**: Productivity, Income, Device Sturdiness, etc.
   - **Competitive Strength**: Where competitors dominate (e.g., Style, Wellness)
   - **Intel Opportunity**: Attractiveness – Competition

6. **🏆 Final Recommendation**
   - The segment with the highest "Intel Opportunity" is recommended as the **primary target**.

---

## 📁 Files Included

- `Intel_MarketSegmentation.R`: Core R script with clustering and scoring logic
- `segments.xlsx`: Output file with summarized cluster data
- `Final_Intel_Segmentation.xlsx`: Final scored and ranked market segments

---

## 📈 Visuals and Interpretations

- **Dendrogram**: Visualizes hierarchical relationships among consumers
- **Elbow Plot**: Helps identify the optimal number of clusters
- **Cluster-wise Summary**: Offers insights into the psychology and behavior of each segment

---

## 🤖 Tech Stack

- **Language**: R
- **Libraries**:
  - `tidyverse` for data manipulation
  - `cluster` for distance & clustering
  - `readxl` & `openxlsx` for Excel I/O

---

## 🚀 Insights & Takeaways

✅ A data-driven recommendation that guides Intel toward a **high-value, low-competition segment**  
✅ A replicable methodology for segmentation projects across industries  
✅ Demonstrates the strategic power of analytics in real-world marketing

---

## 🧭 Future Enhancements

- Integrate interactive visualizations using `shiny`
- Expand to k-means and DBSCAN for comparison
- Automate reporting via RMarkdown or dashboards

---

## 👤 Author

📚 Business Analytics Enthusiast | 📊 Data Storyteller | 🎯 Passionate about turning insights into impact

---

> _“Without data, you're just another person with an opinion.” – W. Edwards Deming_

Give this repo a ⭐ if it sparked your interest. Contributions, suggestions, or coffee are always welcome! ☕

