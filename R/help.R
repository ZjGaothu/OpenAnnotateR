#' @title help
#' @description Get a list of the various functions and arguments that the package contains.
#' @export help
#' @examples help()
help <- function()
{
  print('getParams() : get params list')
  print('getCelltypeList(protocol, species) : get cell type list')
  print('getTissueList(protocol, species) : get tissue list')
  print('getSystemList(protocol, species) : get system list')
  print('getResultList() : get result types')
  print('searchCelltype(protocol, species, keyword) : search for cell types that contain keyword')
  print('searchTissue(protocol, species, keyword) : search for tissues that contain keyword and corresponding cell types')
  print('searchSystem(protocol, species, keyword) : search for systems that contain keyword and corresponding cell types')
  print('runAnnotate(file_path, species, protocol, perbase) : upload file to server')
  print('getProgress(task_id)')
  print('getAnnoResult(result_type, cell_type, task_id)')
  print('getInputFile(save_path, task_id) : get your input file from server')
  print('viewParams(task_id) : view parameters')
  print('exampleTaskID() : get example task id')
  print('exampleInputFile(save_path) : get example input file to the save_path')
  print('Openness2Seurat(file_path) : convert the openness score to a seurat object')
}
