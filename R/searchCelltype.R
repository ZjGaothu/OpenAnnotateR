#' @title searchCelltype
#' @import stringr
#' @import httr
#' @import RCurl
#' @description Search for the corresponding cell type list
#' @param protocol : 1-DNase-seq(ENCODE),2-ATAC-seq(ENCODE),3-ATAC-seq(ATACdb)
#' @param species : genome version of human of mouse, 11-hg19,12-hg38,21-mm9,22-mm10
#' @param keyword : key word you want to search
#' @export searchCelltype
#' @examples searchCelltype(1,11,'K562')
searchCelltype <- function(protocol,species,keyword)
{
  protocolDict <- c('dseq','aseq','atbd')
  speciesDict <- c('1' ='hg19','2'='hg38','3'='mm09','4'='mm10')
  if(species == 2){species = 1}
  if(species == 4){species = 3}
  if(species == 3 & protocol == 3){
    print('The corresponding cell type was not found. Please reselect the parameters.')
    return(0)}
  url = sprintf('http://159.226.47.242:65533/openness/anno/info/stat/celltp_%s_%s.txt',speciesDict[as.character(species)],protocolDict[protocol])
  result = getURL(url)
  result = str_split(result,'\n',simplify = TRUE)
  if(grepl(keyword,'All biosample types') == TRUE)
  {
    print('1 - All biosample types')
  }
  for(i in 2: length(result) - 1){
    if(grepl(keyword,substring(result[i],9,nchar(result[i]))) == TRUE)
    {
      print(paste(c(as.character(i + 1) , " - " , substring(result[i],9,nchar(result[i]))),collapse = ''))
    }
  }
}
