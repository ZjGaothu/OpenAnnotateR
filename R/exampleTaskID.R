#' @title exampleTaskID
#' @description Get an example task id
#' @return task_id
#' @export exampleTaskID
#' @examples task_id <- exampleTaskID()
exampleTaskID <- function()
{
  task_id <- '2020121013091517'
  print(sprintf('Example task id: %s' ,task_id))
  return(task_id)
}
