% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/progression-tables.R
\name{generic_progression_table}
\alias{generic_progression_table}
\alias{RIR_increment_generic}
\alias{perc_drop_generic}
\title{Generic progression table}
\usage{
RIR_increment_generic(
  reps,
  step = 0,
  rep_start = 2,
  rep_step = ((6 - 2)/11),
  inc_start = 1,
  inc_step = ((2 - 1)/11),
  adjustment = 0,
  func_max_perc_1RM = get_max_perc_1RM,
  ...
)

perc_drop_generic(
  reps,
  step = 0,
  rep_start = -0.05,
  rep_step = ((-0.1 - -0.05)/11),
  inc_start = -0.025,
  inc_step = ((-0.05 - -0.025)/11),
  adjustment = 0,
  func_max_perc_1RM = get_max_perc_1RM,
  ...
)
}
\arguments{
\item{reps}{Number of reps}

\item{step}{Progression step. Default is 0. Use negative numbers (i.e., -1, -2)}

\item{rep_start}{Used to define intensive, normal, and extensive progression.
\code{rep_start} defines the adjustment for the first rep}

\item{rep_step}{Used to define intensive, normal, and extensive progression.
\code{rep_step} defines the adjustment as rep number increases}

\item{inc_start}{Defines the progression for \code{step} for single rep}

\item{inc_step}{Defines the progression for \code{step} for rep increase
For example, lower reps can have bigger jumps than high reps.}

\item{adjustment}{Additional adjustment. Default is 0.}

\item{func_max_perc_1RM}{What max rep table should be used?
Default is \code{\link{get_max_perc_1RM}}}

\item{...}{Forwarded to \code{func_max_perc_1RM}. Used to differentiate between
'grinding' and 'ballistic' max reps schemes.}
}
\value{
List with two elements: \code{adjustment} and \code{perc_1RM}
}
\description{
Generic progression tables allow for custom progressions using
\code{rep_start}, \code{rep_step}, \code{inc_start}, and
\code{inc_step} parameters. For more information check the
'Strength Training Manual' Chapter 6.
}
\section{Functions}{
\itemize{
\item \code{RIR_increment_generic}: RIR Increment generic table

\item \code{perc_drop_generic}: Percent Drop generic table
}}

\examples{
RIR_increment_generic(10, step = seq(-3, 0, 1))
RIR_increment_generic(5, step = seq(-3, 0, 1), type = "ballistic")
perc_drop_generic(10, step = seq(-3, 0, 1))
perc_drop_generic(5, step = seq(-3, 0, 1), type = "ballistic")
}
