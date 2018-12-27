server <- function(input, output, session) {
  require(ShinyFireworks)
  require(R6)
  require(ggvis)
  require(shiny)
  require(magrittr)
  require(gplots)

  size <- list(x = 400, y = 300)
  makeFrame <- shiny::reactiveTimer(200, session)

  fw <- ShinyFireworks::Firework$new(x = runif(1, 100, 300), yVel = runif(1, 12, 16), nBurst = 25)

  b <- shiny::reactive({
    #Update the firework when the timer triggers
    makeFrame()
    fw$update()
    conf <- fw$getConfiguration()
    if(fw$isDone()) {
      fw$reset(x = runif(1, 100, 300), yVel = runif(1, 12, 16), nBurst = 25)
    }

    #Inefficient hack to make points outside the plot region invisible
    conf$color <- as.character(conf$color)
    conf[conf$y <= 0 | conf$y >= size$y | conf$x <= 0 | conf$x >= size$x, "color"] <- "#FFFFFF"
    conf
  })

  b %>% ggvis::ggvis(x = ~x, y = ~y) %>%
        ggvis::layer_rects(x = 0, x2 = size$x, y = 0, y2 = size$y, fill := "#16161D") %>%
        ggvis::layer_points(size := 25, fill := ~color) %>%
        ggvis::scale_numeric("x", domain = c(0, size$x), nice = FALSE) %>%
        ggvis::scale_numeric("y", domain = c(0, size$y), nice = FALSE) %>%
        ggvis::hide_axis("x") %>%
        ggvis::hide_axis("y") %>%
        ggvis::bind_shiny("fplot")
}
