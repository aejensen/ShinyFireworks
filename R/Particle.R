Particle <- R6::R6Class("Particle",
  private = list(
    location = rep(NA, 2),
    velocity = rep(NA, 2),
    acceleration = rep(NA, 2),
    color = NULL
  ),

  public = list(
    #Constructor
    initialize = function(loc, vel, col) {
      private$location <- loc
      private$velocity <- vel
      private$acceleration <- c(0, 0)
      private$color <- col
    },

    #Basic physics engine applying Newton's laws in each time step
    update = function() {
      private$velocity <- private$velocity + private$acceleration
      private$location <- private$location + private$velocity
      private$acceleration <- c(0, 0)
    },

    #Return the location and color of the particle
    getLocation = function() {
      data.frame(x = private$location[1], y = private$location[2], color = private$color)
    },

    #Add an external force vector to the particle
    addForce = function(f) {
      private$acceleration <- private$acceleration + f
    },

    #Return true if particle at the top of its trajectory
    isAtTop = function() {
      private$velocity[2] < 0
    }
  )
)
