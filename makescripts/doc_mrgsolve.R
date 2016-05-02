#!/usr/bin/Rscript
#.libPaths("~/Rlibs/lib")

message("\n\nwriting documentation ... \n")

library(methods)
library(devtools)

pkg <- file.path("rdev")

document(pkg)

source("makescripts/buildmodels.R")





