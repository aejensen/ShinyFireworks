ui <- shiny::fluidPage(
  shinyWidgets::setBackgroundColor(color = "ghostwhite", gradient = c("linear", "radial"), direction = c("bottom", "top", "right", "left")),
  shiny::h1("Happy New Year 2020!", align = "center"),
  shiny::h3("from Lektor Jensen", align = "center"),
  shiny::column(12, align="center", ggvis::ggvisOutput("fplot")),
  shiny::h6("Source code available at https://github.com/aejensen/ShinyFireworks", align="center")
)
