# ✈️ Aircrash Dashboard (1908–2024)

## 📊 Project Overview

This R-based dashboard explores global aviation incidents over the past century using rich visualizations and curated insights. Built as part of a university data visualization course, the project covers crash trends, causes, survival rates, and geospatial patterns — all using cleaned, transformed real-world data.

---

## 🗂️ Project Structure

📦 Aircrash Dashboard Project/
├── 📁 www/ # Contains images, background videos, icons used in dashboard UI
├── Aircrash.R # Data cleaning and wrangling script
├── airplane-crash-dashboard.r # Main R Shiny dashboard script
├── DataVis(CW-1).Rproj # R project file
├── .RData, .Rhistory # R session and history files
├── processed_data.csv # Cleaned version of crash dataset
├── Airplane_Crashes_and_Fatalities_1908.csv # Original raw dataset
├── 📊 Visual Outputs:
│ ├── BarGraph(Causes).png
│ ├── Line_Graph.png
│ ├── Map.png
│ ├── PeakYear.png
│ ├── piechart.png
│ ├── scatter.png
│ ├── heatmap.png
│ ├── Histogram(Aircraft_Type).png
│ ├── Word_Cloud(AC.Type).png
│ └── fatality rate(causes).png

yaml
Copy
Edit

---

## 🚀 Features

- 📈 **Crash Trends Over Time**: Line graphs reveal historical spikes (e.g., 1946), declines, and flight safety improvements.
- 📍 **Geospatial Mapping**: Leaflet-powered maps show country-wise incident densities.
- 📋 **Cause Breakdown**: Bar and donut charts highlight human error and mechanical failure as dominant causes.
- 🔢 **Fatality Analysis**: Survival rates and correlations between aircraft type, operator, and crash outcomes.
- 🌐 **Interactive Dashboard**: (If using Shiny) integrated with images/videos from the `www/` directory for an engaging UI.

---

## 🧪 Tools & Technologies

| Category        | Tools                         |
|----------------|-------------------------------|
| Language        | R                             |
| Visualization   | ggplot2, leaflet, wordcloud   |
| Dashboard       | R Shiny (if applicable)       |
| Data Wrangling  | dplyr, lubridate              |
| Data Source     | [planecrashinfo.com](http://www.planecrashinfo.com/database.html) |

---

## 📈 Sample Visuals

- **Line Graph:** Crash count over years (`Line_Graph.png`)
- **Heatmap:** Mortality by weather/conditions (`heatmap.png`)
- **Word Cloud:** Frequent aircraft in crashes (`Word_Cloud(AC.Type).png`)
- **Scatter Plot:** Aboard passengers vs fatality rate (`scatter.png`)
- **Map:** Crash frequency by region (`Map.png`)

---

## 📂 Dataset Info

- **Raw Data**: `Airplane_Crashes_and_Fatalities_1908.csv`
- **Cleaned & Transformed**: `processed_data.csv`  
  > Includes imputation, outlier handling, column standardization, and encoding of categorical variables.

---

## 📖 How to Run

1. Open `DataVis(CW-1).Rproj` in RStudio
2. Run `Aircrash.R` to process and clean data
3. Open `airplane-crash-dashboard.r` (if dashboard included)
4. Run the app using:
```r
shiny::runApp()
Ensure the www/ folder remains in the same directory — it powers the visual media inside the app.

✍️ Author
Afra Adnan Qadir
BSc Software Engineering – University of Nottingham Malaysia
LinkedIn | GitHub

📜 License
MIT License. Educational use only. Attribution appreciated.
