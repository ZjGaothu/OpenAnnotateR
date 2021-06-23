#' @title getProgress
#' @description You can view the annotation progress
#' @import stringr
#' @import httr
#' @import RCurl
#' @param task_id : The 16-bit identity of the submitted task.
#' @export getProgress
#' @examples getProgress(2020121013091517)
getProgress <- function(task_id)
{
  random_id <- as.character(task_id)
  url_finish <- sprintf('http://health.tsinghua.edu.cn/openness/anno/task/%s/%s/%s/logs/openanno.ret',substr(random_id,1,4),substr(random_id,5,8),substr(random_id,9,16))
  response <- GET(url_finish)
  status_code <- response$status_code
  if(status_code == 404)
  {
    url <- sprintf('http://health.tsinghua.edu.cn/openness/anno/task/%s/%s/%s/logs/openanno.sta',substr(random_id,1,4),substr(random_id,5,8),substr(random_id,9,16))
    progress <- getURL(url)
    print(str_split(str_split(progress,'\n',simplify = TRUE)[1:length(str_split(progress,'\n',simplify = TRUE))-1],'\t',simplify = TRUE))
  }
  else
  {
    print('Your task has been completed!')
    print('You can get the result file type first through getResultType()')
    print(sprintf('You can download result file through getAnnoResult(result_type, save_path, %s)',random_id))
  }
}
