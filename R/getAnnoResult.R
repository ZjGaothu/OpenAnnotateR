#' @title getAnnoResult
#' @description Download the annotation result
#' @import stringr
#' @import httr
#' @import RCurl
#' @param result_type :  The file type of the result, 1 - head, 2 - readopen, 3 - peakopen, 4 - spotopen, 5 - foreread.
#' @param save_path : Path to save download file.
#' @param task_id : The 16-bit identity of the submitted task.
#' @export getAnnoResult
#' @examples getAnnoResult(1,'.',2020121013091517)
getAnnoResult <- function(result_type,save_path,task_id)
{
  resultDict <- c('head','readopen','peakopen','spotopen','foreread')
  result_type <- resultDict[result_type]
  task_id <- as.character(task_id)
  url <- sprintf('http://health.tsinghua.edu.cn/openness/anno/task/%s/%s/%s/anno/%s.txt.gz',substr(task_id,1,4),substr(task_id,5,8),substr(task_id,9,16),result_type)
  progress <- getBinaryURL(url)
  note <- file(sprintf("%s/%s.txt.gz",save_path,result_type), open = "wb")
  print(sprintf('get the result to %s/%s.txt.gz',save_path,result_type))
  writeBin(progress, note)
  close(note)
}
