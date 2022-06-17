#' @title searchTissue
#' @import stringr
#' @import httr
#' @import RCurl
#' @description Search for the corresponding cell type list
#' @param protocol : 1-DNase-seq(ENCODE),2-ATAC-seq(ENCODE),3-ATAC-seq(ATACdb)
#' @param species : genome version of human of mouse, 1-hg19,2-hg38,3-mm9,4-mm10
#' @param keyword : key word you want to search
#' @export searchTissue
#' @examples searchTissue(1,1,'blood')
searchTissue <- function(protocol,species,keyword)
{
  protocolDict <- c('dseq','aseq','atbd')
  speciesDict <- c('1' ='hg19','2'='hg38','3'='mm09','4'='mm10')
  if(species == 2){species = 1}
  if(species == 4){species = 3}
  if(species == 3 & protocol == 3){
    print('The corresponding cell type was not found. Please reselect the parameters.')
    return(0)}
  url = sprintf('http://159.226.47.242:65533/openness/anno/info/meta/headFiles/%s_%s.txt',speciesDict[as.character(species)],protocolDict[protocol])
  result = getURL(url)
  result = str_split(result,'\n',simplify = T)
  result = str_split(result,'\t',simplify = T)
  count = 0
  for(i in 1: (dim(result)[1]-1)){
    if(grepl(keyword,result[i,2]) == TRUE)
    {
      count = count + 1
      print(paste(c(as.character(count) , " - " ,result[i,2],' - ' ,result[i,3]),collapse = ''))
    }
  }
}
