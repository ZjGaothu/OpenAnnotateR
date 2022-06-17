#' @title getParams
#' @description Get parameter list for OpenAnnotate task
#' @export getParams

getParams <- function()
{
  print('Species list : ')
  print('1 - GRCh37/hg19')
  print('2 - GRCh38/hg38')
  print('3 - GRCm37/mm9')
  print('4 - GRCm38/mm10')
  print('Protocol list : ')
  print('1 - DNase-seq(ENCODE)')
  print('2 - ATAC-seq(ENCODE)')
  print('3 - ATAC-seq(ATACdb)')
  print('Annotate mode : ')
  print('1 - Region based')
  print('2 - Per-base based')
}
