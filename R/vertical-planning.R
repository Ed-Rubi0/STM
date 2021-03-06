#' Vertical Planning Functions
#'
#' Functions for creating vertical planning (progressions)
#'
#' @param reps Numeric vector indicating reps prescription
#' @param reps_change Change in \code{reps} across progression steps
#' @param step Numeric vector indicating progression steps (i.e. -3, -2, -1, 0)
#'
#' @return Data frame with \code{reps}, \code{index}, and \code{step} columns
#'
#' @name vertical_planning_functions
#' @examples
#' # Generic vertical planning function
#' # ----------------------------------
#' # Constant
#' vertical_planning(reps = c(3, 2, 1), step = c(-3, -2, -1, 0))
#'
#' # Linear
#' vertical_planning(reps = c(5, 5, 5, 5, 5), reps_change = c(0, -1, -2))
#'
#' # Reverse Linear
#' vertical_planning(reps = c(5, 5, 5, 5, 5), reps_change = c(0, 1, 2))
#'
#' # Block
#' vertical_planning(reps = c(5, 5, 5, 5, 5), step = c(-2, -1, 0, -3))
#'
#' # Block variant
#' vertical_planning(reps = c(5, 5, 5, 5, 5), step = c(-2, -1, -3, 0))
#'
#' # Undulating
#' vertical_planning(reps = c(12, 10, 8), reps_change = c(0, -4, -2, -6))
#'
#' # Undulating + Block variant
#' vertical_planning(
#'   reps = c(12, 10, 8),
#'   reps_change = c(0, -4, -2, -6),
#'   step = c(-2, -1, -3, 0)
#' )
#'
#' # Rep accumulation
#' vertical_planning(
#'   reps = c(10, 8, 6),
#'   reps_change = c(-3, -2, -1, 0),
#'   step = c(0, 0, 0, 0)
#' )
#' # ----------------------------------
NULL

#' @describeIn vertical_planning_functions Generic Vertical Planning
#' @export
vertical_planning <- function(reps, reps_change = NULL, step = NULL) {
  if (is.null(reps_change) & is.null(step)) {
    stop("Please define either 'reps_change' or 'step' parameters", call. = FALSE)
  }

  if (is.null(reps_change)) {
    reps_change <- rep(0, length(step))
  }

  if (is.null(step)) {
    step <- seq(-length(reps_change) + 1, 0)
  }

  if (length(reps_change) != length(step)) {
    stop("'reps_change' and 'step' parameters lengths differ")
  }

  df <- expand.grid(
    reps = reps,
    index = seq_along(reps_change)
  )

  df$reps <- df$reps + reps_change[df$index]
  df$step <- step[df$index]

  df
}

#' @describeIn vertical_planning_functions Constants Vertical Planning
#' @param n_steps Number of progression steps. Default is 4
#' @export
#' @examples
#'
#' # Constant
#' vertical_constant(c(5, 5, 5), 4)
#' vertical_constant(c(3, 2, 1), 2)
vertical_constant <- function(reps, n_steps = 4) {
  vertical_planning(reps = reps, reps_change = rep(0, n_steps))
}

#' @describeIn vertical_planning_functions Linear Vertical Planning
#' @export
#' @examples
#'
#' # Linear
#' vertical_linear(c(10, 8, 6), c(0, -2, -4))
#' vertical_linear(c(5, 5, 5), c(0, -1, -2, -3))
vertical_linear <- function(reps,
                            reps_change = c(0, -1, -2, -3)) {
  vertical_planning(reps = reps, reps_change = reps_change)
}

#' @describeIn vertical_planning_functions Reverse Linear Vertical Planning
#' @export
#' @examples
#'
#' # Reverse Linear
#' vertical_linear_reverse(c(6, 4, 2), c(0, 1, 2))
#' vertical_linear_reverse(c(5, 5, 5))
vertical_linear_reverse <- function(reps,
                                    reps_change = c(0, 1, 2, 3)) {
  vertical_planning(reps = reps, reps_change = reps_change)
}


#' @describeIn vertical_planning_functions Block Vertical Planning
#' @export
#' @examples
#'
#' # Block
#' vertical_block(c(6, 4, 2))
vertical_block <- function(reps,
                           step = c(-2, -1, 0, -3)) {
  vertical_planning(reps = reps, step = step)
}

#' @describeIn vertical_planning_functions Block Variant Vertical Planning
#' @export
#' @examples
#'
#' # Block Variant
#' vertical_block_variant(c(6, 4, 2))
vertical_block_variant <- function(reps,
                                   step = c(-2, -1, -3, 0)) {
  vertical_planning(reps = reps, step = step)
}


#' @describeIn vertical_planning_functions Rep Accumulation Vertical Planning
#' @export
#' @examples
#'
#' # Rep Accumulation
#' vertical_rep_accumulation(c(19, 8, 6))
vertical_rep_accumulation <- function(reps,
                                      reps_change = c(-3, -2, -1, 0),
                                      step = c(0, 0, 0, 0)) {
  vertical_planning(reps = reps, reps_change = reps_change, step = step)
}


#' @describeIn vertical_planning_functions Set Accumulation Vertical Planning
#' @param accumulate_rep Which rep (position in \code{reps}) to accumulate
#' @param set_increment How many sets to increase each step? Default is 1
#' @export
#' @examples
#'
#' # Set Accumulation
#' vertical_set_accumulation(c(5, 5, 5))
#' vertical_set_accumulation(c(3, 2, 1), step = c(-1, -1, -1))
#' vertical_set_accumulation(
#'   c(3, 2, 1),
#'   step = c(-1, -1, -1),
#'   accumulate_rep = 1
#' )
#' vertical_set_accumulation(
#'   c(3, 2, 1),
#'   step = c(-1, -1, -1),
#'   accumulate_rep = 2,
#'   set_increment = 2
#' )
vertical_set_accumulation <- function(reps,
                                      step = c(-2, -2, -2, -2),
                                      accumulate_rep = length(reps),
                                      set_increment = 1) {
  progression_steps <- list()

  before_reps <- reps[seq(1, min(accumulate_rep))]
  before_reps <- before_reps[-length(before_reps)]
  after_reps <- reps[seq(max(accumulate_rep), length(reps))]
  after_reps <- after_reps[-1]

  for (i in seq_along(step)) {
    new_reps <- c(
      before_reps,
      rep(reps[accumulate_rep], (set_increment * (i - 1)) + 1),
      after_reps
    )

    progression <- vertical_planning(reps = new_reps, step = step[i])
    progression$index <- i

    progression_steps[[i]] <- progression
  }

  do.call(rbind, progression_steps)
}

#' @describeIn vertical_planning_functions Set Accumulation Reverse Vertical Planning
#' @param accumulate_rep Which rep (position in \code{reps}) to accumulate
#' @param set_increment How many sets to increase each step? Default is 1
#' @export
#' @examples
#'
#' # Set Accumulation Reverse
#' vertical_set_accumulation_reverse(c(5, 5, 5))
#' vertical_set_accumulation_reverse(c(3, 2, 1), step = c(-1, -1, -1))
#' vertical_set_accumulation_reverse(
#'   c(3, 2, 1),
#'   step = c(-1, -1, -1),
#'   accumulate_rep = 1
#' )
#' vertical_set_accumulation_reverse(
#'   c(3, 2, 1),
#'   step = c(-4, -2, 0),
#'   accumulate_rep = 2,
#'   set_increment = 2
#' )
vertical_set_accumulation_reverse <- function(reps,
                                              step = c(-3, -2, -1, 0),
                                              accumulate_rep = length(reps),
                                              set_increment = 1) {
  progression_steps <- list()

  before_reps <- reps[seq(1, min(accumulate_rep))]
  before_reps <- before_reps[-length(before_reps)]
  after_reps <- reps[seq(max(accumulate_rep), length(reps))]
  after_reps <- after_reps[-1]

  for (i in rev(seq_along(step))) {
    new_reps <- c(
      before_reps,
      rep(reps[accumulate_rep], (set_increment * (i - 1)) + 1),
      after_reps
    )

    progression <- vertical_planning(reps = new_reps, step = step[length(step) - i + 1])
    progression$index <- length(step) - i + 1

    progression_steps[[length(step) - i + 1]] <- progression
  }

  do.call(rbind, progression_steps)
}

#' @describeIn vertical_planning_functions Undulating Vertical Planning
#' @export
#' @examples
#'
#' # Undulating
#' vertical_undulating(c(8, 6, 4))
vertical_undulating <- function(reps,
                                reps_change = c(0, -2, -1, -3)) {
  vertical_planning(reps = reps, reps_change = reps_change)
}

#' @describeIn vertical_planning_functions Undulating Vertical Planning
#' @export
#' @examples
#'
#' # Undulating
#' vertical_undulating_reverse(c(8, 6, 4))
vertical_undulating_reverse <- function(reps,
                                        reps_change = c(0, 2, 1, 3)) {
  vertical_planning(reps = reps, reps_change = reps_change)
}

#' @describeIn vertical_planning_functions Volume-Intensity Vertical Planning
#' @export
#' @examples
#'
#' # Volume-Intensity
#' vertical_volume_intensity(c(6, 6, 6))
vertical_volume_intensity <- function(reps,
                                      reps_change = c(0, 0, -3, -3)) {
  vertical_planning(reps = reps, reps_change = reps_change)
}
