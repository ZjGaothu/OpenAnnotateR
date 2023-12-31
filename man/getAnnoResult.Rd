% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getAnnoResult.R
\name{getAnnoResult}
\alias{getAnnoResult}
\title{getAnnoResult}
\usage{
getAnnoResult(result_type, cell_types, task_id)
}
\arguments{
\item{result_type}{:  The file type of the result, 1 - head, 2 - readopen, 3 - peakopen, 4 - spotopen, 5 - foreread.}

\item{cell_types}{: Path to save download file.}

\item{task_id}{: The 16-bit identity of the submitted task.}
}
\description{
Download the annotation result
}
\examples{
getAnnoResult(1,2,2020121013091517)
}
