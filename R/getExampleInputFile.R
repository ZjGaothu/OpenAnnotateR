#' @title getExampleInputFile
#' @description Download example input file to the local path
#' @import stringr
#' @import httr
#' @import RCurl
#' @return save_path : Path to save download file.
#' @export getExampleInputFile
#' @examples getExampleInputFile('.')
getExampleInputFile <- function(save_path)
{
  url = 'http://159.226.47.242:65533/openness/anno/phpa/help/EXAMPLE.bed.gz'
  progress <- getBinaryURL(url)
  note <- file(sprintf("%s/EXAMPLE.bed.gz",save_path), open = "wb")
  print(sprintf('get the result to %s/EXAMPLE.bed.gz',save_path))
  writeBin(progress, note)
  close(note)
}
