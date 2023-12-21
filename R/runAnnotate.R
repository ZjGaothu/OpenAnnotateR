#' @title runAnnotate
#' @description Upload .bed or .bed.gz file to the server
#' @import stringr
#' @import httr
#' @import RCurl
#' @param input : The path of the '.bed' or '.bed.gz' file to be uploaded.
#' @param species : genome version of human of mouse, 1-hg19,2-hg38,3-mm9,4-mm10
#' @param protocol : 1-DNase-seq(ENCODE),2-ATAC-seq(ENCODE),3-ATAC-seq(ATACdb)
#' @param perbase : 1 : Region based,2 : Per-base based.
#' @return taskID
#' @export runAnnotate
runAnnotate <- function(input, species,protocol,perbase)
{
  species_transDict <- c('1' ='11','2'='12','3'='21','4'='22')
  species <- species_transDict[species]
  file_path <- input
  cell_type <- 1
  perbase <- perbase - 1
  if(is.character(file_path)){
    protocolDict <- c('dseq','aseq','atbd')
    speciesDict <- c('11' ='hg19','12'='hg38','21'='mm09','22'='mm10')
    if(species == 21 & protocol == 3){
      print('The corresponding cell type was not found. Please reselect the parameters.')
      return(0)}
    if(species == 21 & protocol == 3){
      print('The corresponding cell type was not found. Please reselect the parameters.')
      return(0)}
    if(!protocol %in% c(1,2,3)){print('Wrong parameter! Please reset protocol')
      return(0)}
    if(!species %in% c('11','12','21','22')){print('Wrong parameter! Please reset species')
      return(0)}
    ask_species <- 0
    if(species == 12){ask_species <- 11}
    if(species == 22){ask_species <- 21}
    url = sprintf('http://159.226.47.242:65533/openness/anno/info/stat/celltp_%s_%s.txt',speciesDict[as.character(ask_species)],protocolDict[protocol])
    result = getURL(url)
    result = str_split(result,'\n',simplify = TRUE)
    if(!cell_type %in% seq(1:length(result)))
    {
      print('Wrong parameter! Please reset cell type')
      return(0)
    }
    if(!perbase %in% c(0,1))
    {
      print('Wrong parameter! Please reset perbase')
      return(0)
    }

    # check bed bed.gz file
    temp_path = str_split(file_path,'/',simplify = TRUE)
    if(length(temp_path) > 1)
    {
      temp_path <- temp_path[length(temp_path)]
    }
    if(str_split(temp_path,'[.]',simplify = TRUE)[2] != 'bed')
    {
      print('ERROR! Please upload \'.bed\' or \'.bed.gz\' file.')
      return(0)
    }
    tmp_bed <- read.table(file_path,header = FALSE, sep = "\t")
    tmp_bed <- as.matrix(tmp_bed)
    dim <- dim(tmp_bed)
    if(dim[2] != 6)
    {
      print('Wrong file format! Please check the format of your bed file.')
      return(0)
    }
    for(i in 1:dim[1])
    {
      if(substr(tmp_bed[i,1],1,3) != 'chr')
      {
        print('Wrong file format! Please check the format of your bed file.')
        return(0)
      }
      temp_digits <- gregexpr('[0-9 ]',tmp_bed[i,2])
      temp_digits <- temp_digits[[1]]
      if(length(temp_digits) != as.numeric(nchar(tmp_bed[i,2])))
      {
        print('Wrong file format! Please check the format of your bed file.')
        return(0)
      }
      if(length(temp_digits) != (nchar(tmp_bed[i,3])))
      {
        print('Wrong file format! Please check the format of your bed file.')
        return(0)
      }
    }
    taskID <- generateID()
    url_post <- 'http://159.226.47.242:65533/openness/anno/phpa/stepu.php'
    upload <- POST(url_post,
                   body = list(species = species,
                               protocol = protocol,
                               celltype=cell_type,
                               perbasepair=perbase,
                               taskname = taskID,file = upload_file(file_path,type = 'file')),
                   encode = 'multipart')
    print(paste(c("your task id is : ",as.character(taskID)),collapse = ''))
    random_id <- as.character(taskID)
    url <- sprintf('http://159.226.47.242:65533/openness/anno/task/%s/%s/%s/logs/openanno.sta',substr(random_id,1,4),substr(random_id,5,8),substr(random_id,9,16))
    response <- GET(url)
    status_code <- response$status_code
    if(status_code != 200)
    {
      Sys.sleep(1)
      response <- GET(url)
      status_code <- response$status_code
    }
    print(sprintf('You can get the progress of your task through getProgress(task_id=%s)',taskID))
    return(taskID)
  }
  else if(class(file_path) == 'data.frame')
  {
    if(dim(file_path)[2] != 6)
    {
      print('Wrong file format! Please check the format of your bed file.')
      return(0)
    }
    if(!dir.exists('tmp')){dir.create('tmp')}
    write.table(file_path,'./tmp/annotateFile.bed',sep='\t',quote = F,col.names = F,row.names = F)
    file_path <- './tmp/annotateFile.bed'
    return(runAnnotate(file_path, species,protocol,perbase))
  }
}
