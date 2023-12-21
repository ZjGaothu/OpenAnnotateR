#' @title generateID
#' @description Generate a task id for your OpenAnnotate task
#' @param NULL
#' @return id
#' @examples task_id <- generateID()
#' @export generateID

generateID <- function()
{
  op <- options(digits.secs = 2)
  today <- Sys.time()
  date_id <- format(today, format="%Y%m%d%H%M%OS")
  id <- paste(c(substr(date_id, 1, 14),substr(date_id,16,17)),collapse = "")
  options(op)
  return(id)
}

