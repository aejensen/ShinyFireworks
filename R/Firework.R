Firework <- R6::R6Class("Firework",
  private = list(
    rocket = NULL,         #the rocket object
    exploded = NULL,       #has the rocket exploded yet?
    nBurst = NULL,         #number of burst particles
    burst = NULL,          #list of burst particles

    #Make the rocket explode
    explode = function() {
      bCol <- sample(self$burstCols) #get a random burst color
      private$burst <- lapply(1:private$nBurst, function(i) {
        #Generate new nBurst particles at the current burst location with a random spherical velocity vectors
        ShinyFireworks::Particle$new(private$rocket$getLocation()[, c("x", "y")], private$randVel(), bCol)
      })
    },

    #Generate a random spherical velocity vector
    randVel = function(lMin = 2, lMax = 7) {
      length <- stats::runif(1, lMin, lMax)
      theta <- stats::runif(1, 0, 2 * pi)
      c(length * cos(theta), length * sin(theta))
    }
  ),

  public = list(
    gravity = NULL,    #gravity vector
    rocketCol = NULL,  #color of the rocket
    burstCols = NULL,  #vector of possible burst colors

    #Constructor
    initialize = function(x, yVel, nBurst) {
      self$gravity <- c(0, -0.5)
      self$rocketCol = "#E5E4E2"
      self$burstCols <- gplots::col2hex(c("chocolate3", "deepskyblue", "gold", "forestgreen", "olivedrab1", "maroon3"))

      #Initialize variables
      private$rocket <- ShinyFireworks::Particle$new(c(x, 0), c(0, yVel), self$rocketCol)
      private$exploded <- FALSE
      private$nBurst <- nBurst
      private$burst <- NULL
    },

    #Re-initialize variables
    reset = function(x, yVel, nBurst) {
      private$rocket <- ShinyFireworks::Particle$new(c(x, 0), c(0, yVel), self$rocketCol)
      private$exploded <- FALSE
      private$nBurst <- nBurst
      private$burst <- NULL
    },

    #Update the dynamics of the firework
    update = function() {
      #If not exploded yet update the rocket
      if(!private$exploded) {
        private$rocket$addForce(self$gravity)
        private$rocket$update()

        #and explode when the rocket is at its top
        if(private$rocket$isAtTop()) {
          private$exploded <- TRUE
          private$explode()
        }
      } else {
        #If exploded then update the burst particles and forget the rocket
        for(i in 1:private$nBurst) {
          private$burst[[i]]$addForce(self$gravity) #add gravity
          private$burst[[i]]$update() #update dynamics
        }
      }
    },

    #Returns true if exploded and all burst particles have landed
    isDone = function() {
      if(!private$exploded) {
        out <- FALSE
      } else {
        #If all burst y-coordinates are below zero
        out <- all(sapply(private$burst, function(b) b$getLocation()[, "y"] < 0))
      }
      out
    },

    #Get point configuration of the firework
    getConfiguration = function() {
      if(!private$exploded) {
        out <- private$rocket$getLocation()
      } else {
        out <- as.data.frame(do.call("rbind", lapply(private$burst, function(b) b$getLocation())))
      }
      out
    }
  )
)
