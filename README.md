[![Travis-CI Build Status](https://travis-ci.org/shntnu/cytoplot.svg?branch=master)](https://travis-ci.org/shntnu/cytoplot)

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

install.packages("BiocInstaller", repos = "https://bioconductor.org/packages/3.4/bioc")

devtools::install_github("shntnu/cytoplot", 
                         dependencies = TRUE, 
                         build_vignettes = TRUE, 
                         repos = BiocInstaller::biocinstallRepos())
```

You may need to do run that again in order to build the vignettes correctly (seems like a bug in `install_github`):
```R
devtools::install_github("shntnu/cytoplot", 
                         dependencies = TRUE, 
                         build_vignettes = TRUE, 
                         force = TRUE,
                         repos = BiocInstaller::biocinstallRepos())
```
