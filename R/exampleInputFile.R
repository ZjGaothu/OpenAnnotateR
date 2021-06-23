#' @title exampleInputFile
#' @description Download example input file to the local path
#' @import stringr
#' @import httr
#' @import RCurl
#' @return save_path : Path to save download file.
#' @export exampleInputFile
#' @examples exampleInputFile('.')
exampleInputFile <- function(save_path)
{
  url = 'http://health.tsinghua.edu.cn/openness/anno/phpa/help/EXAMPLE.bed.gz'
  progress <- getBinaryURL(url)
  note <- file(sprintf("%s/EXAMPLE.bed.gz",save_path), open = "wb")
  print(sprintf('get the result to %s/EXAMPLE.bed.gz',save_path))
  writeBin(progress, note)
  close(note)
}
