ui <- shiny::fluidPage(
  shinyWidgets::setBackgroundColor(color = "ghostwhite", gradient = c("linear", "radial"), direction = c("bottom", "top", "right", "left")),
  shiny::h1("Happy New Year 2019!", align = "center"),
  shiny::column(12, align="center", ggvis::ggvisOutput("fplot"))
)
