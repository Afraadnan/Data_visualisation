# Load the dataset
data <- read.csv("C:\\Users\\user\\Desktop\\DataVis\\DataVis(CW-1)\\Airplane_Crashes_and_Fatalities_Since_1908_20190820105639.csv")



#Once the code is run in one go , for live map the tab on bottom 
#right side switches to "viewer" mode , 
# so to further view the other plots kindly switch back to "plots" tab.
# use the back and forward arrow to see all the 11 charts.
#run the "airplane-crash-dashboard.r" for the shiny website.
#open the full project to view the dashboard app( file -> open project->DataVis(cw-1))




# Load necessary libraries for data manipulation
library(dplyr)
library(lubridate)
library(tidyr)

# Check the dimensions and structure of the dataset
dim(data)
str(data)
View(data)

# Check for missing values in the dataset
colSums(is.na(data))

#Handling missing values (if any in dataset)
data$Location[is.na(data$Location)] <- "Unknown"
data$Summary[is.na(data$Summary)] <- "Unknown"
data$Time[is.na(data$Time)] <- hm("00:00")



# Identify numerical columns and perform median imputation for missing values
numerical_columns <- sapply(data, is.numeric)
for (col in colnames(data)[numerical_columns]) {
  data[[col]][is.na(data[[col]])] <- median(data[[col]], na.rm = TRUE)
}

# Impute missing values for categorical columns with "Unknown"
categorical_columns <- sapply(data, is.character)
for (col in colnames(data)[categorical_columns]) {
  data[[col]][is.na(data[[col]])] <- "Unknown"
}

# Verify changes after imputation
colSums(is.na(data))


# Convert 'Aboard.Passengers' and 'Aboard.Crew' to numeric (if not already)
data$Aboard.Passengers <- as.numeric(data$Aboard.Passengers)
data$Aboard.Crew <- as.numeric(data$Aboard.Crew)

# Create 'Total_Aboard' column by summing 'Aboard.Passengers' and 'Aboard.Crew'
data <- data %>%
  mutate(Total_Aboard = Aboard.Passengers + Aboard.Crew)

# Replace zero values in 'Aboard.Passengers' and 'Aboard.Crew' with median of non-zero values
median_Aboard_Passengers <- median(data$Aboard.Passengers[data$Aboard.Passengers != 0], na.rm = TRUE)
median_Aboard_Crew <- median(data$Aboard.Crew[data$Aboard.Crew != 0], na.rm = TRUE)
data$Aboard.Passengers[data$Aboard.Passengers == 0] <- median_Aboard_Passengers
data$Aboard.Crew[data$Aboard.Crew == 0] <- median_Aboard_Crew

# Remove outliers in 'Aboard.Passengers' and 'Aboard.Crew' using median
outliers_passengers <- boxplot.stats(data$Aboard.Passengers)$out
outliers_crew <- boxplot.stats(data$Aboard.Crew)$out
data$Aboard.Passengers[data$Aboard.Passengers %in% outliers_passengers] <- median_Aboard_Passengers
data$Aboard.Crew[data$Aboard.Crew %in% outliers_crew] <- median_Aboard_Crew

# Convert 'Total_Aboard' to numeric and handle non-numeric characters
data$Total_Aboard <- as.numeric(gsub("[^0-9]", "", data$Total_Aboard))
data$Total_Aboard[is.na(data$Total_Aboard)] <- median(data$Total_Aboard, na.rm = TRUE)

# Convert 'Date'to proper formats
data$Date <- mdy(data$Date)  # Assuming dates are in MM/DD/YYYY format

# Remove duplicate rows
data <- data %>% distinct()

# Convert relevant columns to numeric
data$Aboard <- as.numeric(data$Aboard)  # Convert to numeric if it’s not
data$Fatalities <- as.numeric(data$Fatalities)  # Convert to numeric if it’s not

# Standardize categorical variables (e.g., Location)
data$Location <- ifelse(data$Location %in% c("New York", "NYC"), "New York", data$Location)

# Handle extreme outliers in numerical columns 
median_fatalities <- median(data$Fatalities, na.rm = TRUE)
data$Fatalities[data$Fatalities > 100] <- median_fatalities  # Example threshold: 100

# Group less frequent categories in 'Operator' into "Other"
#data$Operator <- ifelse(data$Operator %in% c("Private", "Military"), data$Operator, "Other")

# Scale numerical features like 'Aboard.Passengers' and 'Aboard.Crew'
data$Aboard.Passengers <- scale(data$Aboard.Passengers)
data$Aboard.Crew <- scale(data$Aboard.Crew)

# Final dataset is now cleaned and ready for analysis or modeling
View(data)




library(ggplot2)
library(dplyr)
library(tidyr)
library(leaflet)

#Chart 1 : Visualising the yearly plane crashes

data$Year <- as.numeric(format(as.Date(data$Date), "%Y"))

# Aggregating data by year and summing the crashes
yearly_crashes <- data %>%
  group_by(Year) %>%
  summarise(Crashes = n())

# Find the year with the highest number of crashes
peak_year <- yearly_crashes %>%
  filter(Crashes == max(Crashes)) %>%
  pull(Year)

peak_crashes <- yearly_crashes %>%
  filter(Year == peak_year) %>%
  pull(Crashes)

# Print the peak year and the number of crashes in that year
cat("Peak Year:", peak_year, "\n")
cat("Peak Crashes:", peak_crashes, "\n")



# Adding a new column to differentiate between peak year and other years
yearly_crashes$highlight <- ifelse(yearly_crashes$Year == peak_year, "Peak Year", "Other")

# Plotting the line graph with the peak year and other years highlighted
p <- ggplot(data = yearly_crashes, aes(x = Year, y = Crashes)) +
  geom_line(linewidth = 1) +  # Line for the trend
  geom_point(aes(color = highlight), size = 3) +  # Points with color differentiation
  scale_color_manual(values = c("Peak Year" = "red", "Other" = "lightblue")) +  # Color settings
  labs(title = "Yearly Air Crashes", 
       x = "Year", 
       y = "Number of Crashes") +
  theme_minimal()
print(p)

plot_data <- ggplot_build(p)

# Extract axis scale divisions
x_ticks <- plot_data$layout$panel_params[[1]]$x$breaks
y_ticks <- plot_data$layout$panel_params[[1]]$y$breaks

# Calculate divisions (differences between consecutive ticks)
x_divisions <- diff(x_ticks)  # X-axis divisions
y_divisions <- diff(y_ticks)  # Y-axis divisions

# Print the scale divisions
print(x_divisions)  # Positions of x-axis ticks
print(y_divisions)  # Positions of y-axis ticks


#### Peak Year Graph (CHART 2)

 

data_1946 <- data[format(data$Date, "%Y") == "1946", ]
data_1946$Month <- format(data_1946$Date, "%m")
monthly_crashes_1946 <- table(data_1946$Month)
monthly_crashes_1946_df <- as.data.frame(monthly_crashes_1946)
colnames(monthly_crashes_1946_df) <- c("Month", "Crashes")
ggplot(monthly_crashes_1946_df, aes(x = Month, y = Crashes)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Air Crashes per Month in 1946", 
       x = "Month", 
       y = "Number of Crashes") +
  theme_minimal() +
  scale_x_discrete(labels = c("01" = "January", "02" = "February", "03" = "March", 
                              "04" = "April", "05" = "May", "06" = "June", 
                              "07" = "July", "08" = "August", "09" = "September", 
                              "10" = "October", "11" = "November", "12" = "December"))


### A Bar Graph for Causes wise Analysis (CHART 3)

categories <- list(
  "Human Error" = c("pilot", "fatigue", "decision", "stress", "distraction", "maintenance", "ATC", "controller", "communication"),
  "Mechanical Failure" = c("engine", "mechanical", "malfunction", "failure", "maintenance", "propeller", "hydrogen","mountains","fire","control"),
  "Weather Conditions" = c("weather", "fog", "rainstorm", "snow", "wind", "temperature", "storm", "flew", "downdraft"),
  "Bird Strikes" = c("bird", "bat", "animal", "flock"),
  "Runway Incursions" = c("runway", "incursion", "aerodrome", "surface","wing","taking off","departure","training"),
  "Combat-Related" = c("shot down", "combat", "war", "bomb", "military"),
  "Other" = c("unknown", "unexplained", "cause unknown", "undefined") # Retain this for unclear cases
)

# Function to assign categories based on keywords
assign_category <- function(summary, categories) {
  for (category in names(categories)) {
    keywords <- categories[[category]]
    if (any(grepl(paste(keywords, collapse = "|"), summary, ignore.case = TRUE))) {
      return(category)
    }
  }
  return("Other") # Default if no match found
}



data$Category <- sapply(data$Summary, assign_category, categories = categories)
category_counts <- data %>%
  group_by(Category) %>%
  summarise(Frequency = n()) %>%
  arrange(desc(Frequency))
ggplot(category_counts, aes(x = reorder(Category, -Frequency), y = Frequency, fill = Category)) +
  geom_bar(stat = "identity", width = 0.7) +
  labs(
    title = "Causes of Airplane Crashes",
    x = "General Causes",
    y = "Frequency"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    axis.title = element_text(size = 12)
  ) +
  scale_fill_viridis_d(option = "magma", guide = "none")

# Filter data for frequency justification
filtered_data <- data %>%
  filter(Category %in% c("Human Error", "Mechanical Failure")) %>%
  select(Summary)

# Saving the pre-processed dataset to a CSV file for the shiny app
write.csv(data, "processed_data.csv", row.names = TRUE)


#visualing locations via maps (CHART 4)

library(ggrepel)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(viridis)

# Summarize crashes by country
crashes_by_country <- data %>%
  group_by(Location) %>%
  summarise(Frequency = n()) %>%
  arrange(desc(Frequency))

# Load the world map
world <- ne_countries(scale = "medium", returnclass = "sf")

# Merge crash data with world map
world_data <- world %>%
  left_join(crashes_by_country, by = c("admin" = "Location"))

# Set Frequency NA to 0 for countries with no crashes
world_data$Frequency[is.na(world_data$Frequency)] <- 0


ggplot(data = world_data) +
  geom_sf(aes(fill = Frequency), color = "white", lwd = 0.2) +  # Map polygons
  scale_fill_viridis(
    name = "Crash Frequency",
    option = "mako",  
    direction = -1,    
    na.value = "gray90"  # Countries with no data in light gray
  ) +
  geom_text_repel(
    data = world_data %>% filter(Frequency > 0),
    aes(geometry = geometry, label = admin),
    stat = "sf_coordinates",
    size = 3,
    color = "darkgreen",
    box.padding = 0.3
  ) +  # Add country labels
  labs(
    title = "Airplane Crash Frequencies by Country",
    subtitle = "Crash Frequency Color Intensity Coded",
    caption = "Data source:Kaggle"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, face = "bold"),
    plot.subtitle = element_text(size = 14),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10,face = "bold"),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank()
  )



library(rnaturalearth)
library(countrycode)



# Summarize crash data by location (replacing 'Country' with 'Location' column)
map_data <- data %>%
  group_by(Location) %>%
  summarise(Frequency = n()) %>%
  arrange(desc(Frequency)) %>%
  slice(1:20)  # Select the top 20 locations with the highest crash frequencies

# Get the ISO2 country codes using the countrycode package (replacing 'Country' with 'Location')
map_data$iso2 <- countrycode(map_data$Location, origin = "country.name", destination = "iso2c")

# Fetch country geographic data using rnaturalearth
country_data <- ne_countries(scale = "medium", returnclass = "sf")

# Create the `iso2` column in country_data for joining
country_data <- country_data %>%
  mutate(iso2 = countrycode(name, "country.name", "iso2c"))

# Now join crash data with country data using the 'iso2' column
map_data_with_coords <- left_join(map_data, country_data, by = "iso2")

# Extract centroid coordinates (longitude and latitude) from the joined data
country_data_coords <- st_coordinates(st_centroid(map_data_with_coords$geometry))
map_data_with_coords <- cbind(map_data_with_coords, country_data_coords)

# Remove rows where there are missing lat/lng values
map_data_clean <- map_data_with_coords %>%
  filter(!is.na(X) & !is.na(Y)) %>%  # X is longitude, Y is latitude from st_coordinates
  rename(lng = X, lat = Y)

# Create an interactive map using Leaflet
leaflet(map_data_clean) %>%
  addTiles() %>%  # OpenStreetMap tiles
  addCircleMarkers(
    lng = ~lng, lat = ~lat,
    radius = ~sqrt(Frequency) * 2,  # Scale radius based on frequency
    color = "yellow",  # Border color
    fillColor = "red",  # Fill color (You can use a color palette)
    fillOpacity = 0.5,
    popup = ~paste("<strong>Location: </strong>", Location, 
                   "<br><strong>Crash Count: </strong>", Frequency) , # Popup with Location name and crash count
    label = ~paste("Location:" , Location ,Frequency, " crashes")  # Label for hover effect
  ) %>%
  
  addLegend(
    "bottomright",
    pal = colorNumeric(palette = "YlOrRd", domain = map_data_clean$Frequency),
    values = ~Frequency,
    title = "Crash Frequency",
    opacity = 0.8
  )


#Chart 4: Aircraft Type Analysis: An overview ( CHART 5)

library(wordcloud)
library(RColorBrewer)

#Fetching and counting Frequency using Pipe Operator
aircraft_crashes <- data %>%
  group_by(AC.Type) %>%
  summarise(Frequency = n()) %>%
  arrange(desc(Frequency))

# Convert to a named vector for the word cloud
word_freq <- setNames(aircraft_crashes$Frequency, aircraft_crashes$AC.Type)

# Create the word cloud
set.seed(1234) # For reproducibility
wordcloud(
  words = names(word_freq),          
  freq = word_freq,                  
  min.freq = 5, # Minimum frequency to display
  random.order = FALSE,              # Higher frequency words in the center
  rot.per = 0.3,                     #word dimension as per vertical rotation 
  colors = brewer.pal(8, "Spectral")  
)

## Histogram for Aircraft Type Wise Crashes (CHART 6)


#Filter the top 10 aircraft types based on crash frequency to avoid clustering
top_10_aircraft <- aircraft_crashes %>%
  arrange(desc(Frequency)) %>%
  head(10)


ggplot(top_10_aircraft, aes(x = reorder(AC.Type, Frequency), y = Frequency, fill = Frequency)) +
  geom_bar(stat = "identity", width = 0.7, color = "black") +  # Add borders to bars
  labs(
    title = "Top 10 Aircraft Types by Crashes",
    x = "Aircraft Type",
    y = "Frequency"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(size = 10),    
    axis.text.y = element_text(size = 10),    
    plot.title = element_text(hjust = 0.5),   # Center-align the title
    axis.title = element_text(size = 12),    
    legend.position = "none"                  # Remove legend for clarity
  ) +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +  # Custom gradient colors
  coord_flip()  # Flip the coordinates for horizontal bars

#Donut Chart for AIRLINE OPERATOR wise crash data (CHART 7)


airline_crashes <- data %>%
  filter(!is.na(Operator)) %>%  
  group_by(Operator) %>%
  summarise(Frequency = n()) %>%
  arrange(desc(Frequency)) %>%
  slice(1:10)  

ggplot(airline_crashes, aes(x = 2, y = Frequency, fill = Operator)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y", start = 0) +
  labs(
    title = "Top 10 Airline Crash Operators",
    fill = "Airline Operator"
  ) +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(hjust = 0.5)
  ) +
  
  
  # editing the white center to create the donut effect
  annotate("rect", xmin = -0.5, xmax = 0.5, ymin = -0.5, ymax = 0.5, fill = "white")


  
  ### Fatalities Rate ####

  
  #Check for non-numeric values
unique(data$Fatalities[!grepl("^[0-9]+$", data$Fatalities, perl = TRUE)])
unique(data$Aboard[!grepl("^[0-9]+$", data$Aboard, perl = TRUE)])

# Replace non-numeric values with NA or 0
data$Fatalities <- as.numeric(gsub("[^0-9.]", "", data$Fatalities),gsub("[^0-9.]", "", data$Ground))
data$Aboard <- as.numeric(gsub("[^0-9.]", "", data$Aboard))

data <- data %>%
  mutate(
    Fatalities = ifelse(is.na(Fatalities), 0, Fatalities),
    Aboard = ifelse(is.na(Aboard), 1, Aboard), # Prevent division by zero
    FatalityRate = (Fatalities / Aboard) * 100
  )

#compute survival data
survival_data <- data %>%
  mutate(Survivors = Aboard - Fatalities) %>%
  summarise(
    Fatalities = sum(Fatalities, na.rm = TRUE),
    Survivors = sum(Survivors, na.rm = TRUE)
  ) %>%
  pivot_longer(cols = everything(), names_to = "Category", values_to = "Count") %>%
  mutate(Percentage = round((Count / sum(Count)) * 100, 1))

#Pie Chart to show survival vs fatalities rate (CHART 8)

ggplot(survival_data, aes(x = "", y = Count, fill = Category)) +
  geom_col(width = 1) +
  coord_polar(theta = "y") +
  geom_text(aes(label = paste0(Percentage, "%")), position = position_stack(vjust = 0.5), color = "white") +
  scale_fill_manual(values = custom_colors) +
  labs(title = "Fatalities vs Survivors", fill = "Category") +
  theme_void() +
  theme(plot.title = element_text(size = 16, hjust = 0.5))



#Chart 8 : Fatalities and Crashes

# Ensure Fatalities and Aboard columns are numeric
data$Fatalities <- as.numeric(data$Fatalities)
data$Aboard <- as.numeric(data$Aboard)

# Calculate Fatality Rate
data <- data %>%
  mutate(FatalityRate = (Fatalities / Aboard) * 100)
data$Category <- sapply(data$Summary, assign_category, categories = categories)

fatality_summary <- data %>%
  group_by(Category) %>%
  summarise(AvgFatalityRate = mean(FatalityRate, na.rm = TRUE))

# Bar Graph for fatality vs causes (CHART 9)
ggplot(fatality_summary, aes(x = reorder(Category, AvgFatalityRate), y = AvgFatalityRate, fill = AvgFatalityRate)) +
  geom_bar(stat = "identity") +
  scale_fill_gradient(low = "#5CB85C", high = "#D9534F", name = "Avg Fatality Rate (%)") +
  labs(
    title = "Average Fatality Rate (Causes)",
    x = "Cause Category",
    y = "Average Fatality Rate (%)"
  ) +
  coord_flip()+
  theme_minimal()



### Heat Map Route-Weather Fatality Wise (chart 10)

top_routes <- data %>%
  group_by(Route) %>%
  summarise(CrashCount = n(), .groups = "drop") %>%
  top_n(10, CrashCount)

# Filter original data to include only top 10 routes
filtered_data <- data %>% filter(Route %in% top_routes$Route)

# Summarize data for heatmap
heatmap_route_weather <- filtered_data %>%
  group_by(Route, "Weather Conditions") %>%
  summarise(FatalityRate = mean(FatalityRate, na.rm = TRUE), .groups = "drop")

# Heatmap visualization
ggplot(heatmap_route_weather, aes(x = "Weather " , y = Route, fill = FatalityRate)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "#8E7697", high = "#431C53", name = "Fatality Rate (%)") +
  labs(
    title = "Heatmap of Fatality Rates by Top 10 Routes and Weather Conditions",
    x = "Weather Conditions",
    y = "Route"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



# Filter data to remove outliers
filtered_data <- data[data$Aboard < 500 & data$FatalityRate < 150, ]

#Randomly sample 100 rows for less clustered output
set.seed(123)
data <- filtered_data[sample(nrow(filtered_data), min(100, nrow(filtered_data))), ]

# Create scatter plot with jittering (CHART 11)
ggplot(data = data, aes(x = Aboard, y = FatalityRate)) +
  geom_jitter(color = "blue", alpha = 0.7, width = 5, height = 5) +  # Add jitter for distinction
  geom_smooth(method = "lm", color = "red", se = FALSE) +  # Add trend line
  labs(
    title = "Scatter Plot of Fatality Rate vs Passengers Aboard",
    x = "Passengers Aboard",
    y = "Fatality Rate (%)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),  
    axis.title = element_text(size = 12)
  )






