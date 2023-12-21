# OpenAnnotateR

#### A R package for efficiently annotating the chromatin accessibility of genomic regions

Chromatin accessibility is a measure of the ability of nuclear macromolecules to physically contact DNA, and is essential for understanding regulatory mechanisms.

OpenAnnotate facilitates the chromatin accessibility annotation for massive genomic regions by allowing ultra-efficient annotation across various biosample types based on chromatin accessibility profiles accumulated in public repositories (1236 samples from ENCODE and 1493 samples from ATACdb).

For more information, please refer to the web: http://health.tsinghua.edu.cn/openannotate/

### Install OpenAnnotate via devtools

OpenAnnotate is available on github here and can be installed via `devtools`, make sure you have installed `deltools` fist
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
| searchCelltype(protocol, species, keyword) | search for cell types that contain keyword |
| searchTissue(protocol, species, keyword) | search for tissues that contain keyword and corresponding cell types|
| searchSystem(protocol, species, keyword) | search for systems that contain keyword and corresponding cell types|
| runAnnotate(file_path, species, protocol, cell_type, perbase) | upload file to server |
| getProgress(task_id)| You can view the annotation progress |
| getAnnoResult(result_type, cell_type, task_id) | Download the annotation result |
| getInputFile(save_path, task_id) | get your input file from server |
| viewParams(task_id) | view parameters|
| getExampleTaskID() | get example task id|
| getExampleInputFile(save_path) | get example input file to the save_path|
| Openness2Seurat(file_path) | convert the openness score to seurat object|
