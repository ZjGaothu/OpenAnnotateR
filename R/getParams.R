#' @title getParams
#' @description Get parameter list for OpenAnnotate task
#' @export getParams

getParams <- function()
{
  print('Species list : ')
  print('11 - GRCh37/hg19')
  print('12 - GRCh38/hg38')
  print('21 - GRCm37/mm9')
  print('22 - GRCm38/mm10')
  print('Protocol list : ')
  print('1 - DNase-seq(ENCODE)')
  print('2 - ATAC-seq(ENCODE)')
  print('3 - ATAC-seq(ATACdb)')
  print('Annotate mode : ')
  print('0 - Region based')
  print('1 - Per-base based')
}
