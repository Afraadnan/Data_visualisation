library(shiny)
library(bslib)
library(DT)



ui <- fluidPage(
  tags$head( 
    tags$meta(name = "viewport", content = "width=device-width, initial-scale=1.0"),
    tags$style(HTML("
    
    
    
  body, html {
  margin:0;
  padding:0;
overflow-x: hidden; /* Prevent horizontal scrolling */
box-sizing:border-box;

  }

      /* Video Background Styles */
      
      .video-background {
        position: fixed;
        right: 0;
        bottom: 0;
        min-width: 100%;
        min-height: 100%;
        filter: brightness(0.7);
        z-index: -1000;
        background-size: cover;
      } }
      
  
      
      /* Content wrapper styles */
      .content-wrapper {
        position:relative;
        z-index: -1;
        background: rgba(53, 61, 90, 0.3);
        min-height: 180vh;
        top:50;
        left:0;
        padding:0;
        margin:0;
        min-width:100vh;
        box-sizing:border-box;
      
      }
      
      /* Navbar */
      .navbar {
        background-color: rgba(53, 61, 90, 0.55);
        position:relative;
        margin:0;
        font-size:1.5rem;
        font-weight:bold;
        z-index:1;
        top:0px;
        width: 110%; /* Make it span the entire width */
        left:0px;
       
        display: flex;
  -webkit-display: flex; /* Safari */
  -ms-display: flex; /* IE10 */
        
       
      }
      
     .navbar-brand {
     
     color:rgb(255 255 116);
     font-size:2rem;
     
     }
      
      

      .navbar-nav .nav-item .nav-link {
        color: white !important;
        font-weight: bold;
        padding: 15px 50px;
      }

      .navbar-nav .nav-item .nav-link:hover {
        background-color: #ff7f00;
        color: white !important;
      }


@media (max-width: 768px) {
  .content-wrapper {
    min-width: 100vw;  /* Adjust for smaller screens */
  }
  .navbar a {
    margin: 10px 0;  /* Add space between items */
  }
}

      /* Panel-like Card Design for Plots */
      
      .plot-container {
        background-color: rgba(255, 255, 255, 0.9);
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        padding: 15px;
        margin:10px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        cursor: pointer;
        max-width: 120%;
        overflow: hidden;
        display: flex;
        justify-content: center;
        
      }

      .plot-container:hover {
        transform: scale(1.05);
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
      }

      /* Map container specific styling */
      
      .map-container {
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 20px 0;
        text-align: center;
      }
      
      .map-container img {
        max-width: 90%;
        height: auto;
        margin: 0 auto;
        text-align: center;
      }
      
      /* Live map container */
      
      .live-map-container {
        width: 100%;
        height: 600px;
        margin: 20px 0;
        border-radius: 10px;
        overflow: hidden;
         text-align: center;
      }

      /* Flexbox for Plot Row */
      
      .plot-row {
        display: flex;
        flex-wrap: wrap;
         justify-content: space-around;
        gap: 10px;
        padding-top: 20px;
      }

      .plot-container img {
        max-width: 100%;
        height: auto;
        object-fit: contain;
      }

      /* Button Styling */
      
      .btn-custom {
        background-color: #FF7F00;
        color: white;
        border: none;
        padding: 10px 20px;
        font-size: 1rem;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
      }

      .btn-custom:hover {
        background-color: #0066CC;
        color: white;
      }
      
      /* Data table customization */
      
      .dataTables_wrapper{
        background-color:rgb(210 197 209);
        padding: 20px;
        border-radius: 10px;
        margin-top: 20px;
        
      }
      .dataTable {
      table-layout: fixed;
      width: 100% !important;
    }
    .dataTable td, .dataTable th {
      word-wrap: break-word;
      width: 150px;  /* Adjust this value as needed */
    }

  
 "))

    
  ),
  # Video Background
  tags$video(
    class = "video-background",
    autoplay = TRUE,
    loop = TRUE,
    muted = TRUE,
    playsinline = TRUE,
    src = "vid1.mp4",
    type = "video/mp4"
  ),
  
  # Content Wrapper
  div(class = "content-wrapper",
      navbarPage(
        title = "Aircraft Crashes 1908-2024",
        theme = bs_theme(
          bg = "#549aba",
          fg = "#112c46",
          base_font = "Arial, sans-serif"
        ),
        
        # Tab 1: Yearly Trends
        tabPanel("Yearly Analysis",
                 fluidRow(
                   column(12, 
                          div(class = "plot-row", 
                              div(class = "plot-container col-md-6 col-sm-12", 
                                  imageOutput("yearly_crashes_image", height = "100%")
                              ),
                              div(class = "plot-container col-md-6 col-sm-12", 
                                  imageOutput("peak_year_image", height = "100%")
                              )
                          )
                   )
                 )
        ),
        # Tab 2: Causes Analysis
        tabPanel("Crash Causes",
                 fluidRow(
                   column(12, 
                          div(class = "plot-row", 
                              div(class = "plot-container col-md-6 col-sm-12", 
                                  imageOutput("causes_image", height = "100%")
                              ),
                              div(class = "plot-container col-md-6 col-sm-12", 
                                  imageOutput("fatality_cause_image", height = "100%")
                              )
                          )
                   )
                 )
        ),
        
        # Tab 3: Geographic Analysis
        tabPanel("Geographic Analysis",
                 fluidRow(
                   column(12, 
                          div(class = "plot-row", 
                              div(class = "map-container", 
                                  imageOutput("world_map_image", height = "auto")
                              )
                          )
                   ),
                   column(12,
                          div(class = "plot-row",
                              div(class = "live-map-container",
                                  htmlOutput("live_map")
                              )
                          )
                   )
                 )
        ),
        
        # Tab 4: Aircraft Analysis
        tabPanel("Aircraft Analysis",
                 fluidRow(
                   column(12, 
                          div(class = "plot-row", 
                              div(class = "plot-container col-md-6 col-sm-12", 
                                  imageOutput("aircraft_bar_image", height = "100%")
                              ),
                              div(class = "plot-container col-md-6 col-sm-12", 
                                  imageOutput("wordcloud_image", height = "100%")
                              )
                          )
                   ),
                   column(12,
                          div(class = "plot-row", 
                              div(class = "plot-container col-md-6 col-sm-12", 
                                  imageOutput("operator_donut_image", height = "100%")
                              )
                          )
                   )
                 )
        ),
        
        # Tab 5: Survival Analysis
        tabPanel("Survival Analysis",
                 fluidRow(
                   column(12, 
                          div(class = "plot-row", 
                              div(class = "plot-container col-md-6 col-sm-12", 
                                  imageOutput("survival_pie_image", height = "100%")
                              ),
                              div(class = "plot-container col-md-6 col-sm-12", 
                                  imageOutput("heatmap_image", height = "100%")
                              ),
                              
                              
                              div(class = "plot-container col-md-6 col-sm-12", 
                                  imageOutput("scatter_image", height = "100%")
                              ) 
                              
                              
                              
                          )
                   ) )
                 
                 
        ),
        
       
        
        
        
        
        
        
   tabPanel("Data Explorer",
                 fluidPage(
                   # Title
                   h3("Explore Aircraft Crash Data", style = "color: #1e081c; font-style: oblique; padding-bottom: 50px; padding-top: 30px; font-weight:bold;"),
                   
                   # Layout for filters and data table
                   fluidRow(
                     column(3,
                            selectInput("year_filter", "Select Year:",
                                        choices = c("All", 1908:2024), 
                                        selected = "All")
                     ),
                     column(3,
                            selectInput("cause_filter", "Select Cause:",
                                        choices = c("All", "Weather Conditions", "Human Error", "Mechanical Failure", "Combat-Related", "Runway Incursions", "Bird Strikes", "Other"), 
                                        selected = "All")
                     ),
                     column(3,
                            sliderInput("fatalities_filter", "Fatalities Range:",
                                        min = 0, max = 1000, value = c(0, 1000))
                     )
                   ),
                   
                   # Data Table
                   fluidRow(
                     column(12,
                            DTOutput("data_table")
                     )
                   )
                 )
        ) 
   )
   
  ) )
  

# Server Logic
server <- function(input, output, session) {
  
  # Load pre-saved images
  load_image <- function(file_name) {
    list(
      src = file_name,
      contentType = 'image/png',
      alt = paste("Image:", file_name)
    )
  }
  
  # Render images for each tab
  output$yearly_crashes_image <- renderImage({ load_image("Line_Graph.png") }, deleteFile = FALSE)
  output$peak_year_image <- renderImage({ load_image("PeakYear.png") }, deleteFile = FALSE)
  output$causes_image <- renderImage({ load_image("BarGraph(Causes).png") }, deleteFile = FALSE)
  output$fatality_cause_image <- renderImage({ load_image("fatality rate(causes).png") }, deleteFile = FALSE)
  output$world_map_image <- renderImage({ load_image("Map.png") }, deleteFile = FALSE)
  output$aircraft_bar_image <- renderImage({ load_image("Histogram(Aircraft_Type).png") }, deleteFile = FALSE)
  output$wordcloud_image <- renderImage({ load_image("Word_Cloud(AC.Type).png") }, deleteFile = FALSE)
  output$operator_donut_image <- renderImage({ load_image("donutchart.png") }, deleteFile = FALSE)
  output$survival_pie_image <- renderImage({ load_image("piechart.png") }, deleteFile = FALSE)
  output$heatmap_image <- renderImage({ load_image("heatmap.png") }, deleteFile = FALSE)
  output$scatter_image <- renderImage({ load_image("scatter.png") }, deleteFile = FALSE)
  
  # Load the dataset
  data <- reactive({
    df <- read.csv("C:\\Users\\user\\Desktop\\DataVis\\DataVis(CW-1)\\processed_data.csv")
    
    # Apply filters
    if (input$year_filter != "All") {
      df <- df[df$Year == input$year_filter, ]
    }
    if (input$cause_filter != "All") {
      df <- df[df$Category == input$cause_filter, ]
    }
    df <- df[df$Fatalities >= input$fatalities_filter[1] & df$Fatalities <= input$fatalities_filter[2], ]
    
    df
  })
  
  # Render Data Table
  output$data_table <- renderDT({
   
    datatable(data(), options = list(pageLength = 10,
              
              
              scrollX = TRUE  # Enables horizontal scrolling
    ),
    width = "100%"
              
              
              )
  })
  
  output$live_map <- renderUI({
    tags$iframe(
      src = "liveview.html",
      width = "100%",
      height = "600px",
      frameborder = 0
    )
  })
  
} 

# Run the app
shinyApp(ui = ui, server = server)
