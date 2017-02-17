[![Travis-CI Build Status](https://travis-ci.org/shntnu/cytoplot.svg?branch=master)](https://travis-ci.org/shntnu/cytoplot)

# cytoplot
Package for visualizing high-dimensional single-cell data

## Installation

On OSX, you may need to do this to install FFTW

```
brew install fftw
```

Install the package:

```R
install.packages("devtools")

install.packages("BiocInstaller")

devtools::install_github("shntnu/cytoplot", dependencies = TRUE, build_vignettes = TRUE, repos=c(BiocInstaller::biocinstallRepos(), "http://cran.us.r-project.org"))
```

