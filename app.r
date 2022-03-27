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
  
  observeEvent(
    eventExpr = input[["upload_button"]],
    handlerExpr = {
  

  #csvfile <- read.csv(file="measles.csv", sep=",", header = TRUE)
      
  
      csvfile <- read.csv(input$file1$datapath, as.is=T)
      
      cols <- names(csvfile)
      
      output$plot <- renderPlotly({
        fig <- plot_ly(csvfile, x=~csvfile[,1], y=~csvfile[,2], type = "scatter", mode="lines")
        
        fig <- fig %>%
          layout(hovermode = "x unified", xaxis = list(title = cols[1]), yaxis = list (title = cols[2]))
      
      })
    })
}



# parte de html

ui <- fluidPage(
  
  tags$div(class = "header", checked = NA,
           fileInput("file1", "Choose CSV File",
                     multiple = FALSE,
                     accept = c("text/csv",
                                "text/comma-separated-values,text/plain",
                                ".csv"))
  ),
  
  actionButton(
    inputId = "upload_button",
    label = "Upload"),
  
  h4("Plot output",align="center"),
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




