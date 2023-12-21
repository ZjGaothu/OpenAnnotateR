#' @title Openness2Seurat
#' @description Download the annotation result
#' @import stringr
#' @import Seurat
#' @param file_path : Path of download file.
#' @export Openness2Seurat
Openness2Seurat <- function(file_path,header_path)
{
  open.mat <- read.table(file_path,header = FALSE)
  lines <- readLines(header_path)
  first_column <- sapply(strsplit(lines, " "), "[", 1)
  open.mat <- open.mat[,5:dim(open.mat)[2]]
  colnames(open.mat) <- first_column
  obj <-CreateSeuratObject(counts = open.mat)
  return(obj)
}
