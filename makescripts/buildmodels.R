#!/usr/bin/Rscript
#library(mrgsolve)
#library(metrumrg)

filename <- function (dir, run = NULL, ext = NULL)  file.path(dir, paste0(run, ext))

ls <- list.files("rdev/inst/project",pattern="\\.cpp$")
ls <- ls[!grepl("\\.cpp\\.cpp", ls)]

out <- lapply(ls, function(file) {
    ## Model is being saved as "x"
    stem <- gsub("\\.cpp$", "", file)
    message(paste0("Building: ", stem))
    x <- mread(stem, "rdev/inst/project",udll=FALSE,compile=FALSE)
    x <- new("packmod", x, package="modmrg", model=stem)
    x <- mrgsolve:::relocate_funs(x, "modmrg")
    x <- mrgsolve:::compiled(x,TRUE)
    x@shlib$par <- pars(x)
    x@shlib$cmt <- cmt(x)
    save(file=filename(file.path("rdev","inst", "project"),stem, ".save"), x)
    x
})


grab <- list.files("rdev/inst/project", pattern="*.\\.(cpp\\.cpp|h)")
foo <- file.copy(file.path("rdev/inst/project",grab),file.path("rdev/src",grab), overwrite=TRUE)


