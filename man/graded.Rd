% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/graded.R
\name{graded}
\alias{graded}
\title{Graded object for submission value}
\usage{
graded(correct, message = NULL)
}
\arguments{
\item{correct}{A boolean value of whether or not the checked code is correct.}

\item{message}{A character string of the message to be displayed.}
}
\description{
The return value from \code{graded} should be returned by every
\code{*-check} chunk when used with \code{link{grade_learnr}}.
}
