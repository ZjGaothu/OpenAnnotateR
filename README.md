# OpenAnnotateR

#### A R package for efficiently annotating the chromatin accessibility of genomic regions

Chromatin accessibility is a measure of the ability of nuclear macromolecules to physically contact DNA, and is essential for understanding regulatory mechanisms.

OpenAnnotateR facilitates the chromatin accessibility annotation for massive genomic regions by allowing ultra-efficient annotation across various biosample types based on chromatin accessibility profiles accumulated in public repositories (1236 samples from ENCODE and 1493 samples from ATACdb).

For more information, please refer to the web: http://health.tsinghua.edu.cn/openannotate/

### Install OpenAnnotateR via devtools

OpenAnnotateR is available on github here and can be installed via `devtools`, make sure you have installed `deltools` fist
```R
devtools::install_github("ZjGaothu/OpenAnnotateR")
```

### Available functions

| Code | Function |
| ------ | ------  |
| help() | Get a list of the various functions and arguments that the package contains. |
| getParams() | get params list |
| getCelltypeList(protocol, species) | get cell type list |
| getTissueList(protocol, species) | get tissue for annotation |
| getSystemList(protocol, species) | get systems for annotation|
| getResultList() | get the list of result type|
| searchCelltype(protocol, species, keyword) | search for cell types that contain keyword |
| searchTissue(protocol, species, keyword) | search for tissues that contain keyword and corresponding cell types|
| searchSystem(protocol, species, keyword) | search for systems that contain keyword and corresponding cell types|
| runAnnotate(file_path, species, protocol, perbase) | upload file to server |
| getProgress(task_id)| You can view the annotation progress |
| getAnnoResult(result_type, cell_types, task_id) | Download the annotation result |
| getInputFile(save_path, task_id) | get your input file from server |
| viewParams(task_id) | view parameters|
| getExampleTaskID() | get example task id|
| getExampleInputFile(save_path) | get example input file to the save_path|
| Openness2Seurat(file_path) | convert the openness score to a seurat object|

### A simple example


Upload a region file to the web server and download the head and the readopen of the annotation result to the local path, then initialize an seurat object for downstream analysis.

```r
library(OpenAnnotateR)

getParams()

getCelltypeList(protocol=1, species=1)

task_id <- runAnnotate(file_path, species, protocol, perbase)

getResultList()

getAnnoResult(result_type=1, cell_types=c(2,8,9), task_id)

Openness2Seurat('./results/2023122110412810_readopen.txt')

```
### Tutorial

**Import**

The package inclues a class named `OpenAnnotatePy`, All functions are implemented by instantiating objects of this class.

```r
library(OpenAnnotateR)
```

**Instantiate object**

Instantiate an object with the data path.

```Python
oaa=OpenAnnotateApi.Annotate()
```


**Help**

Get a list of the various functions and arguments that the package contains.
```Python
oaa.help()
'''
testWebserver() : test whether the web server is working normally
setAddress(IP, port) : set the address of the web server
getParams() : get params list
getCelltypeList(protocol,species) : get cell type list
getTissueList(protocol,species) : get tissue list
getSystemList(protocol,species) : get system list

searchCelltype(protocol, species, keyword) : search for cell types that contain keyword
searchTissue(protocol, species, keyword) : search for tissues that contain keyword and the corresponding cell types
searchSystem(protocol, species, keyword) : search for systems that contain keyword and the corresponding cell types
setParams(assay,species,cell_type,perbase) : set params list

runAnnotate(input) : Upload file to server
getProgress(task_id) : query the annotation progress
getAnnoResult(result_type,task_id,cell_type) : download annotation result to local path
getInputFile(save_path, task_id) : get your input file from server
viewParams(task_id) : view parameters
getExampleTaskID() : get example task id
getExampleInputFile(save_path) : get example input file to the save_path
fromOpen2EpiScanpy(data, head) : generate anndata from annotation result
'''
```
