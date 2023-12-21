#' @title getInputFile
#' @description Download input file to the local path
#' @import stringr
#' @import httr
#' @import RCurl
#' @param save_path : Path to save download file.
#' @param task_id : The 16-bit identity of the submitted task.
#' @export getInputFile
#' @examples getInputFile('.',2020121013091517)
getInputFile <- function(save_path, task_id)
{
  print(sprintf('get the result to %s/%s.bed',save_path,task_id))
  task_id <- as.character(task_id)
  url = sprintf('http://159.226.47.242:65533/openness/anno/task/task/%s/%s.bed',task_id,substr(task_id,9,16))
  progress <- getBinaryURL(url)
  note <- file(sprintf("%s/%s.bed",save_path,task_id), open = "wb")
  writeBin(progress, note)
  close(note)
}
