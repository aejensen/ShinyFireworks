ui <- shiny::fluidPage(
  shinyWidgets::setBackgroundColor(color = "ghostwhite", gradient = c("linear", "radial"), direction = c("bottom", "top", "right", "left")),
  h1("Happy New Year 2018!", align = "center"),
  column(12, align="center", ggvis::ggvisOutput("fplot"))
)
