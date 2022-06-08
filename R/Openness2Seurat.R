#' @title Openness2Seurat
#' @description Download the annotation result
#' @import stringr
#' @import Seurat
#' @param file_path : Path of download file.
#' @export Openness2Seurat
Openness2Seurat <- function(file_path)
{
  open.mat <- read.table(file_path,header = FALSE)
  open.mat <- open.mat[,5:dim(open.mat)[2]]
  pbmc <-CreateSeuratObject(counts = open.mat)
  return(pbmc)
}
