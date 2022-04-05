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

# global variables
csvfile <- NULL
cols <- NULL
xx <- NULL
yy <- NULL
x <- NULL; y <- NULL

server <- function(input, output) {
    # upload button
    observeEvent(
        eventExpr = input[["upload_button"]],
        handlerExpr = {
            csvfile <- read.csv(input$file1$datapath, as.is=T)
            cols <- names(csvfile)
            insertUI (
                selector = "#upload_button",
                where = "afterEnd",
                ui = tags$div("#coords",
                    selectInput("x", "X:",
                        cols
                    ),
                    selectInput("y", "Y:",
                        cols
                    ),
                    actionButton(
                        inputId = "generate_button",
                        label = "Set axis"
                    )
                ),
                multiple = FALSE,
                immediate = FALSE,
                session = getDefaultReactiveDomain()
                )
        }
    )

    # generate graph
    observeEvent (
        eventExpr = input[["generate_button"]],
        handlerExpr = {
            xx <<- x
            yy <<- y
            print(x)
            output$plot <- renderPlotly({
                fig <- plot_ly(csvfile, x=~csvfile[,match(xx, cols)], y=~csvfile[,match(yy, cols)], type = "scatter", mode="lines")
                fig <- fig %>%
                layout(hovermode = "x unified", xaxis = list(title = cols[1]), yaxis = list (title = cols[2]))
            })
        })
}



# parte de html

ui <- fluidPage(
    tags$html(
        tags$head(
            tags$meta(
                charset="UTF-8"
            ),
            tags$meta(
            httpequiv="X-UA-Compatible", content="IE=edge" 
            ),
            tags$link(
                href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css", rel="stylesheet", integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3", crossorigin="anonymous"
            ),
            tags$link(
                rel="stylesheet", href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"
            ),
            tags$style(".bg-primary {
    background-color: #1A374D!important;
}

.bg-secondary {
    background-color: #406882!important;
}

.border-secondary {
    background-color: #406882;
}

.btn-close-light {
    background-color: white;
}

.input-group {
    width: 60%;
}

#dragdrop {
    height: 10rem;
    width: 25rem;
    display: table-cell;
    vertical-align: middle;
    transition: 0.5s;
}

#dragdrop.highlight {
    border-style: dashed!important;
    border-color: #1A374D!important;
    background-color: #B1D0E0!important;
    transition: 0.5s;
}")
        ),
        tags$body(
            tags$nav(
                class="navbar navbar-dark bg-primary",
                tags$div(
                    class="container-fluid",
                    tags$a(
                        class="navbar-brand", href="#",
                        "Think Visual :: Think R"
                    ),
                    tags$button(
                        class="navbar-toggler", type="button",
                        tags$span (
                            class="navbar-toggler-icon"
                        )
                    ),
                    tags$div (
                        class="offcanvas bg-secondary offcanvas-end", tabindex="-1", id="offcanvasNavbar",
                        tags$div(
                            class="offcanvas-header",
                            tags$h5(
                                class="offcanvas-title text-light", id="offcanvasNavbarLabel", 
                                "Think Visual :: Think R"
                            ),
                            tags$button(
                                type="button", class="btn-close btn-close-light text-reset"
                            )
                        ),
                        tags$div(
                            class="offcanvas-body",
                            tags$ul(
                                class="navbar-nav justify-content-end flex-grow-1 pe-3",
                                tags$li(
                                    class="nav-item",
                                    tags$a(
                                        class="nav-link active", href="index.html",
                                        "Home"
                                    )
                                ),
                                tags$li(
                                    class="nav-item",
                                    tags$a(
                                        class="nav-link active", href="https://github.com/slocknad/think-visual-think-r",
                                        "Github Repo",
                                        tags$i(
                                            class="bi bi-github"
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            ),
            tags$div(class = "header", checked = NA,
                fileInput("file1", "Choose a CSV File",
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
            tags$script(
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js", integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p", crossorigin="anonymous"
            )
        )
    )   
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




