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

setwd("C:/Users/Pedro Martins/Documents/Projeto/test")

server <- function(input, output){

  csvfile <- read.csv(file="measles.csv", sep=",", header = TRUE)
  
  output$plot <- renderPlotly({
    fig <- plot_ly(csvfile, x=~time, y=~measles, type = "scatter", mode="lines")
    
    fig <- fig %>%
      layout(hovermode = "x unified")
    
  
  })
  
}



# parte de html
shinyApp(ui = htmlTemplate("www/index.html"), server)

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




