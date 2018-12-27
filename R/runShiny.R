runShiny <- function() {
  appDir <- system.file("shiny-examples", "shinyFirework", package = "ShinyFireworks")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = "normal")
}
