

# ✈️ Aircrash Dashboard (1908–2024)

## 📊 Overview

This project is a data visualization of global airplane crashes from **1908 to 2024**, built using **R** and real-world aviation data from [planecrashinfo.com](https://www.kaggle.com/datasets). It explores patterns across time, geography, causes, aircraft types, and fatality rates through impactful visualizations and analysis.

---

## 🗂️ Project Structure

- `www/` – Background videos and UI images
- `Aircrash.R` – R script for data cleaning and wrangling
- `airplane-crash-dashboard.r` – (Optional) R Shiny dashboard script
- `DataVis(CW-1).Rproj` – RStudio project file
- `Airplane_Crashes_and_Fatalities_Since_1908.csv` – Raw dataset
- `processed_data.csv` – Cleaned dataset
- Visual Output Files:
  - `BarGraph(Causes).png`
  - `Line_Graph.png`
  - `Map.png`
  - `PeakYear.png`
  - `piechart.png`
  - `scatter.png`
  - `heatmap.png`
  - `Histogram(Aircraft_Type).png`
  - `Word_Cloud(AC.Type).png`
  - `fatality rate(causes).png`

---

## 🚀 Features

- 📈 Crash trends over time (e.g., peak in 1946)
- 🌍 Geographical crash mapping using `leaflet`
- ⚙️ Cause breakdowns via bar/donut charts
- 🧮 Survival analysis by flight type and condition
- ✈️ Aircraft/operator risk visualization
- 📊 10+ visual outputs including heatmaps, word clouds, and histograms

---

## 🛠️ Tools & Libraries

- **Language**: R  
- **Data Wrangling**: `dplyr`, `lubridate`  
- **Visualization**: `ggplot2`, `leaflet`, `wordcloud`  
- **Dashboard (optional)**: R Shiny  
- **Data Source**: [planecrashinfo.com](https://www.kaggle.com/datasets)

---

## 📈 Sample Visuals

- `Line_Graph.png` – Crash trends over time  
- `Map.png` – Country-wise crash density  
- `BarGraph(Causes).png` – Common crash causes  
- `fatality rate(causes).png` – Survival & mortality comparison  
- `Word_Cloud(AC.Type).png` – Aircraft models involved  
- `heatmap.png` – Fatality rates under weather conditions

---

## 📂 Dataset

- **Raw File**: `Airplane_Crashes_and_Fatalities_Since_1908.csv`  
- **Processed**: `processed_data.csv`  
  - Null value handling  
  - Date/time parsing  
  - Outlier imputation  
  - Column transformations (e.g., Total_Aboard)

---

## 💡 Insights

- ✈️ Crash rates peaked in **1946**, then declined due to safety protocols and modern aircraft.
- 🌧️ Weather and mechanical failure cause the deadliest crashes.
- 📉 Only **46.1%** average survival rate across recorded events.
- ✈️ Aircraft like the **Douglas DC-3** and operators like **Aeroflot** showed higher involvement due to high operational usage.

---

## 📦 How to Run the Project

### 1. Open the R Project

Open `DataVis(CW-1).Rproj` in **RStudio**.

### 2. Clean the Data

Run the `Aircrash.R` script to preprocess the dataset.

### 3. (Optional) Launch the Dashboard

If using the Shiny dashboard:
```r
shiny::runApp('airplane-crash-dashboard.r')
````

> ⚠️ Make sure the `www/` folder is in the same directory to display images/videos properly.

---

## 👩‍💻 Author

**Afra Adnan Qadir**
BSc Software Engineering – University of Nottingham Malaysia
📧 [afraadnan223@gmail.com](mailto:afraadnan223@gmail.com)
🔗 [LinkedIn](https://www.linkedin.com/in/afraadnan)
💻 [GitHub](https://github.com/Afraadnan)

---

## 📜 License

This project is licensed under the **MIT License**.
Feel free to use, modify, and share attribution appreciated!




