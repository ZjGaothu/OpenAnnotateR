# OpenAnnotateR

#### A R package for efficiently annotating the chromatin accessibility of genomic regions

Chromatin accessibility is a measure of the ability of nuclear macromolecules to physically contact DNA, and is essential for understanding regulatory mechanisms.

OpenAnnotate facilitates the chromatin accessibility annotation for massive genomic regions by allowing ultra-efficient annotation across various biosample types based on chromatin accessibility profiles accumulated in public repositories (1236 samples from ENCODE and 1493 samples from ATACdb).

For more information, please refer to the web: http://health.tsinghua.edu.cn/openannotate/

### Install OpenAnnotate via Pypi
Anaconda users can first create a new Python environment and activate it via(this is unnecessary if your Python environment is managed in other ways)


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
| searchCelltype(protocol, species, keyword) | search for cell types that contain keyword |
| runAnnotate(file_path, species, protocol, cell_type, perbase) | upload file to server |
| getProgress(task_id)| You can view the annotation progress |
| getAnnoResult(result_type, save_path, task_id) | Download the annotation result |
| getInputFile(save_path, task_id) | get your input file from server |
| viewParams(task_id) | view parameters|
| exampleTaskID() | get example task id|
| exampleInputFile(save_path) | get example input file to the save_path|
