library(shiny)
library(modeldata)
library(DAAG)
library(ggplot2)
library(plotly)
library(devtools)
library(RCurl)
library(httr)
library(magick)
library(gganimate)
require(ggplot2)
require(gganimate)
require(magick)


server <- function(input, output){
  

  #csvfile <- read.csv(file="measles.csv", sep=",", header = TRUE)
  
  csvfile <- reactive({
    inFile <- input$file1
    if (is.null(inFile)) return(NULL)   
    read.csv(inFile$datapath, as.is=T)
  }) 
  
  if (is.null(csvfile)) return(NULL)
  output$plot <- renderPlotly({
    fig <- plot_ly(csvfile, x=~time, y=~measles, type = "scatter", mode="lines")
    
    fig <- fig %>%
      layout(hovermode = "x unified")
    
  
  })
  
}



# parte de html

ui <- fluidPage(
  
  tags$div(class = "header", checked = NA,
           tags$p("Ready to take the Shiny tutorial? If so"),
           tags$a(href = "shiny.rstudio.com/tutorial", "Click Here!"),
           fileInput("file1", "Choose CSV File",
                     multiple = FALSE,
                     accept = c("text/csv",
                                "text/comma-separated-values,text/plain",
                                ".csv"))
  ),
  
  
  h4("Number of measles cases",align="center"),
  div(plotlyOutput("plot",width = "500px", height = "300px"), align = "center"),
)

shinyApp(ui = htmlTemplate("www/index.html"), server)




shinyApp(ui, server)

# 
# animated_plot <- ggplot(m, aes(x = time, y = measles)) +
#   geom_line(size = 1, color = "blue") +
#   transition_reveal(time) +
#   theme_minimal()
# 
# animation <- animate(animated_plot, nframes=70, renderer=magick_renderer())
# 
# animation








# animated_plot <- ggplot(m, aes(x = time, y = measles)) +
#   geom_line(size = 1, color = "blue") +
#   transition_reveal(time) +
#   theme_minimal()
# 
# animation <- animate(animated_plot, nframes=70, renderer=magick_renderer())
# 
# animation




