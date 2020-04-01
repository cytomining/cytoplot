[![Travis-CI Build Status](https://travis-ci.org/cytomining/cytoplot.svg?branch=master)](https://travis-ci.org/cytomining/cytoplot)

# cytoplot
Package for visualizing high-dimensional single-cell data

## Installation

You may need to install some libraries:

OSX:
```
brew install fftw libtiff
```

Ubuntu:

```
sudo apt-get install -y libfftw3-dev libtiff5 libtiff5-dev 
```

Install the package:

```R
install.packages("devtools")

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.10")

devtools::install_github("cytomining/cytoplot", 
                         dependencies = TRUE, 
                         build_vignettes = TRUE, 
                         repos = BiocInstaller::biocinstallRepos())
```

You may need to do run that again in order to build the vignettes correctly (seems like a bug in `install_github`):
```R
devtools::install_github("cytomining/cytoplot", 
                         dependencies = TRUE, 
                         build_vignettes = TRUE, 
                         force = TRUE,
                         repos = BiocInstaller::biocinstallRepos())
```
