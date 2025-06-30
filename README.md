# Data_visualisation
# ✈️ An Aircrash Saga (1908–2024) – Data Visualization Project

## 📊 Overview

**“An Aircrash Saga (1908–2024)”** is a data visualization project exploring over a century of global aviation incidents. Using R and a dataset sourced from [planecrashinfo.com](http://www.planecrashinfo.com/database.html), this project uncovers critical patterns, crash causes, survival rates, and geographic trends that impact aviation safety.

The goal is to raise awareness about flight risks, inform safety improvements, and apply visualization best practices to real-world data.

---

## 🎯 Key Highlights

- Analyzed **4,967 crash records** with 17+ variables
- Preprocessed data: handled NULLs, outliers, date formats, categorical encoding
- Explored **5 research questions** covering trends, causes, aircraft/operator risks, geography, and survival rates
- Generated 10+ impactful visualizations (line plots, heatmaps, word clouds, donut charts, interactive maps)
- Built using R packages: `ggplot2`, `leaflet`, `dplyr`, `lubridate`

---

## 🔍 Research Questions

1. **How have airplane crashes evolved over time?**
   - Peak observed in 1946 (see Figure 2); steady decline post-1980s due to tech and safety protocols.

2. **Which aircraft types and airline operators had the most incidents?**
   - Douglas DC-3 and Aeroflot were most crash-prone due to fleet size and historical use (Figures 4–5).

3. **What are the leading causes of air crashes?**
   - Human error and mechanical failure dominate; visualized in horizontal bar chart (Figure 6).

4. **How does geography affect crash frequency and fatality rate?**
   - Russia and Pakistan had higher incidents due to terrain and traffic density (Figure 7 heatmap).

5. **What is the survival rate in crashes?**
   - Only **46.1% survive** on average; larger aircraft had better survival odds (Figures 8–11).

---

## 📦 Tools & Technologies

| Category | Tools |
|---------|-------|
| Language | R |
| Visualization | ggplot2, leaflet, wordcloud |
| Data Wrangling | dplyr, lubridate |
| Data Source | [planecrashinfo.com](http://www.planecrashinfo.com/database.html) |
| Format | R Markdown Report (PDF/HTML) |

---

## 🗂️ Project Structure

```bash
📁 aircrash-visualisation/
├── aircrash_analysis.Rmd
├── cleaned_data.csv
├── figures/
│   ├── fig2_trends_linegraph.png
│   ├── fig6_crash_causes_bar.png
│   ├── fig10_heatmap.png
│   └── ...
├── README.md
└── report.pdf
