#' @title getAnnoResult
#' @description Download the annotation result
#' @import stringr
#' @import httr
#' @import RCurl
#' @param result_type :  The file type of the result, 1 - head, 2 - readopen, 3 - peakopen, 4 - spotopen, 5 - foreread.
#' @param cell_types : Path to save download file.
#' @param task_id : The 16-bit identity of the submitted task.
#' @export getAnnoResult
#' @examples getAnnoResult(1,2,2020121013091517)
getAnnoResult <- function(result_type,cell_types,task_id)
{
  save_path <- './results'
  if(!dir.exists('results')){dir.create('results')}
  resultDict <- c('head','readopen','peakopen','spotopen','foreread')
  result_type <- resultDict[result_type]
  task_id <- as.character(task_id)
  if(length(cell_types) == 1){
    if(cell_types == 1)
    {
      url <- sprintf('http://159.226.47.242:65533/openness/anno/task/%s/%s/%s/anno/%s.txt.gz',substr(task_id,1,4),substr(task_id,5,8),substr(task_id,9,16),result_type)
      progress <- getBinaryURL(url)
      note <- file(sprintf("%s/%s_%s.txt.gz",save_path,task_id,result_type), open = "wb")
      writeBin(progress,note)
      close(note)
      print(sprintf('get the result to %s/%s_%s.txt',save_path,task_id,result_type))
      return(0)
    }
  }
  if(result_type != 'head')
  {
    url <- sprintf('http://159.226.47.242:65533/openness/anno/task/%s/%s/%s/anno/head.txt.gz',substr(task_id,1,4),substr(task_id,5,8),substr(task_id,9,16))
    progress <- getBinaryURL(url)
    note <- file(sprintf("%s/%s_head.txt.gz",save_path,task_id), open = "wb")
    writeBin(progress,note)
    close(note)

    url <- sprintf('http://159.226.47.242:65533/openness/anno/task/%s/%s/%s/anno/%s.txt.gz',substr(task_id,1,4),substr(task_id,5,8),substr(task_id,9,16),result_type)
    progress <- getBinaryURL(url)
    note <- file(sprintf("%s/%s_%s.txt.gz",save_path,task_id,result_type), open = "wb")
    writeBin(progress,note)
    close(note)

    heads <- read.table(sprintf("%s/%s_head.txt.gz",save_path,task_id),sep='\t',quote = "")
    heads <- heads$V6

    # get cell types
    protocolDict <- c('dseq','aseq','atbd')
    speciesDict <- c('11' ='hg19','12'='hg38','21'='mm09','22'='mm10')

    url <- sprintf('http://159.226.47.242:65533/openness/anno/task/task/%s/openanno.ret',task_id)
    result <- getURL(url)
    task_info <- str_split(result,'\t',simplify = TRUE)
    info_len <- length(task_info)
    task_info_new <- task_info[(info_len - 3):info_len]
    task_info_new[4] <- str_split(task_info_new[4],'\n',simplify = TRUE)[1]
    protocol <- task_info_new[1]
    species <- task_info_new[2]

    if(species == 12){species = 11}
    if(species == 22){species = 21}
    url = sprintf('http://159.226.47.242:65533/openness/anno/info/stat/celltp_%s_%s.txt',speciesDict[as.character(species)],protocolDict[as.integer(protocol)])
    result <- getURL(url)
    result <- str_split(result,'\n',simplify = TRUE)
    cells <- c()
    for(j in 1:length(result))
    {
      cells <- c(cells,substring(result[j],9,nchar(result[j])))
    }
    cells <- cells[cell_types-1]
    idxs <- which(heads %in% cells)

    tmp_file_5_rows <- read.table(sprintf("%s/%s_%s.txt.gz",save_path,task_id,result_type),nrows=5)
    classes <- sapply(tmp_file_5_rows, class)
    targetnum <- c(c(1,2,3,4),idxs+4)
    classes[-targetnum] <- rep("NULL", length(classes) - length(targetnum))
    classes[targetnum[5:length(targetnum)]] <- "numeric"
    tmp_file <- read.table(sprintf("%s/%s_%s.txt.gz",save_path,task_id,result_type),colClasses = classes)
    file.remove(sprintf("%s/%s_%s.txt.gz",save_path,task_id,result_type))
    write.table(tmp_file,file=sprintf("%s/%s_%s.txt",save_path,task_id,result_type),quote = F,col.names = F,row.names = F)
    print(sprintf('get the result to %s/%s_%s.txt',save_path,task_id,result_type))
  }
  else
  {
    url <- sprintf('http://159.226.47.242:65533/openness/anno/task/%s/%s/%s/anno/head.txt.gz',substr(task_id,1,4),substr(task_id,5,8),substr(task_id,9,16))
    progress <- getBinaryURL(url)
    note <- file(sprintf("%s/%s_head.txt.gz",save_path,task_id), open = "wb")
    writeBin(progress,note)
    close(note)
    heads <- read.table(sprintf("%s/%s_head.txt.gz",save_path,task_id),sep='\t',quote = "")
    datas <- heads
    heads <- heads$V6

    # get cell types
    protocolDict <- c('dseq','aseq','atbd')
    speciesDict <- c('11' ='hg19','12'='hg38','21'='mm09','22'='mm10')

    url <- sprintf('http://159.226.47.242:65533/openness/anno/task/task/%s/openanno.ret',task_id)
    result <- getURL(url)
    task_info <- str_split(result,'\t',simplify = TRUE)
    info_len <- length(task_info)
    task_info_new <- task_info[(info_len - 3):info_len]
    task_info_new[4] <- str_split(task_info_new[4],'\n',simplify = TRUE)[1]
    protocol <- task_info_new[1]
    species <- task_info_new[2]
    if(species == 12){species = 11}
    if(species == 22){species = 21}
    url = sprintf('http://159.226.47.242:65533/openness/anno/info/stat/celltp_%s_%s.txt',speciesDict[as.character(species)],protocolDict[as.integer(protocol)])
    result <- getURL(url)
    result <- str_split(result,'\n',simplify = TRUE)
    cells <- c()
    for(j in 1:length(result))
    {
      cells <- c(cells,substring(result[j],9,nchar(result[j])))
    }
    cells <- cells[cell_types-1]
    # print(heads)
    idxs <- which(heads %in% cells)
    datas <- datas[idxs,]
    file.remove(sprintf("%s/%s_%s.txt.gz",save_path,task_id,result_type))
    write.table(datas,file=sprintf("%s/%s_%s.txt",save_path,task_id,result_type),quote = F,col.names = F,row.names = F)
    print(sprintf('get the result to %s/%s_%s.txt.gz',save_path,task_id,result_type))
  }
}
