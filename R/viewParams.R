#' @title viewParams
#' @import stringr
#' @import httr
#' @import RCurl
#' @description You can view the parameters you set before
#' @param task_id : The 16-bit identity of the submitted task.
#' @export viewParams
#' @examples viewParams(2020121013091517)
viewParams <- function(task_id)
{
  protocolDict <- c('dseq','aseq','atbd')
  speciesDict <- c('11' ='hg19','12'='hg38','21'='mm09','22'='mm10')
  protocolDict_w = c('DNase-seq(ENCODE)','ATAC-seq(ENCODE)','ATAC-seq(ATACdb)')
  speciesDict_w = c('11' = 'GRCh37/hg19','12' = 'GRCh38/hg38','21' = 'GRCm37/mm9','22' = 'GRCm38/mm10')
  print('Your task\'s parameters:')
  url <- sprintf('http://159.226.47.242:65533/openness/anno/task/task/%s/openanno.ret',task_id)
  result <- getURL(url)
  task_info <- str_split(result,'\t',simplify = TRUE)
  info_len <- length(task_info)
  task_info_new <- task_info[(info_len - 3):info_len]
  task_info_new[4] <- str_split(task_info_new[4],'\n',simplify = TRUE)[1]
  protocol <- task_info_new[1]
  species <- task_info_new[2]
  cell_type <- task_info_new[3]
  perbase <- task_info_new[4]
  print(paste(c('Protocol: ',protocolDict_w[as.integer(protocol)]),collapse = ''))
  print(paste(c('Species: ' , speciesDict_w[species]),collapse = ''))
  if(species == 12){species <- 11}
  if(species == 22){species <- 21}
  if(species == 21 & protocol == 3){
    print('The corresponding cell type was not found. Please reselect the parameters.')
    return(0)}
  url = sprintf('http://159.226.47.242:65533/openness/anno/info/stat/celltp_%s_%s.txt',speciesDict[as.integer(species)],protocolDict[as.integer(protocol)])
  result = getURL(url)
  result = str_split(result,'\n')
  perbaseDict = c('region based','perbase based')
  # if(as.integer(cell_type) ==  1){
  #   print('Cell type: All biosample types')}
  # else{
  #   print(paste(c('Cell type: ' , result[as.integer(cell_type) - 2][8:length(result[as.integer(cell_type) - 2])]),collapse = ''))}
  print(paste(c('Annotate mode: ', perbaseDict[as.integer(perbase) + 1] ),collapse = ''))
}
