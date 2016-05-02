##' Precompiled models for use with \code{mrgsolve}.
##' 
##' @name modmrg
##' @docType package
##' @useDynLib modmrg
##' @importFrom mrgsolve as.locked
##' @importFrom mrgsolve as.packmod
##' @importFrom mrgsolve loadso
##' @importFrom mrgsolve update
##' @importFrom mrgsolve relocate
##' @section Package help:
##' \itemize{
##'  \item  Package \href{00Index.html}{index}, including a listing of all functions
##' }
##'
##' @section Types of models:
##'
##' Currently available are:
##' \itemize{
##' \item Traditional \code{\link{pk}} models
##' \item \code{\link{pkpd}} models
##' \item \code{\link{tmdd}} models
##' \item \code{\link{viral}} dynamics models
##' }
##' 
##' @examples 
##' mod <- pk1cmt()
##' mod <- pk2cmt()
##' mod <- pk3cmt()
##' mod <- irm1()
##' mod <- irm2()
##' mod <- irm3()
##' mod <- irm4()
##' mod <- pd_effect()
##' mod <- emax()
##' mod <- tmdd()
##' mod <- viral1()
##' mod <- viral2()
##'
NULL



##' PK/PD Model parameters, compartments, and output variables.
##' 
##' @name pkpd_details
##'
##' @section Compartments:
##' \itemize{
##' \item{\code{EV1}, \code{EV2}}: extravasular dosing compartments
##' \item{\code{CENT}}: central PK compartment
##' \item{\code{PERIPH}}: peripheral PK compartment
##' \item{\code{PERIPH2}}: peripheral PK compartment 2
##' \item{\code{RESP}}: response PD compartment (irm models)
##' }
##'
##' @section Output variables:
##' \itemize{
##' \item{\code{CP}}: concentration in the central compartment (\code{CENT/VC})
##' \item{\code{RESP}}: response (emax model)
##' }
##'
##' @section PK parameters:
##' \itemize{
##' \item{\code{KA1}, \code{KA2}}:  first order absorption rate constants from first and second extravascular compartment (1/time)
##' \item{\code{CL}}: clearance (volume/time)
##' \item{\code{VC}}: volume of distribution, central compartment (volume)
##' \item{\code{VP}}:  volume of distribution, peripheral compartment (volume)
##' \item{\code{VP2}}: volume of distribution, peripheral compartment 2 (volume)
##' \item{\code{Q}}: intercompartmental clearance (volume/time)
##' \item{\code{Q2}}: intercompartmental clearance 2 (volume/time)
##' \item{\code{VMAX}}:  maximum rate, nonlinear process (mass/time)
##' \item{\code{KM}}: Michaelis constant (mass/volume)
##' \item{\code{K10}}: elimination rate constant (1/time); \code{CL/VC}
##' \item{\code{K12}}: rate constant for transfer to peripheral compartment from central (1/time); \code{Q/VC}
##' \item{\code{K21}}: rate constant for transfer to central compartment from peripheral (1/time); \code{Q/VP}
##' }
##'
##' @section PD parameters:
##' \itemize{
##' \item{\code{E0}}: baseline effect (emax model)
##' \item{\code{EMAX}, \code{IMAX}}: maximum effect (response)
##' \item{\code{EC50}, \code{IC50}}: concentration producing 50 percent of effect (mass/volume)
##' \item{\code{KIN}}: zero-order response production rate (irm models) (response/time)
##' \item{\code{KOUT}}: first-order response elimination rate (irm models) (1/time)
##' \item{\code{n}}: sigmoidicity factor
##' \item{\code{KEO}}: rate constant for transfer to effect compartment (1/time)
##' }
NULL



cfile_dir <- function() {
  file.path(path.package("modmrg"), "project")
}

object_dir <- function() {
  file.path(path.package("modmrg"), "project")
}

configure <- function(model,tryload=TRUE,...) {
  load(file=file.path(mrgsolve:::filename(object_dir(), model, ".save")))
  if(!mrgsolve:::dll_loaded(x)) {
    if(tryload) {
      warning("Model not loaded... attempting to load.")
      x <- loadso(x)
    }
    if(!mrgsolve:::dll_loaded(x)) stop("Could not load the model")
  }
  x <- update(x,...)
  return(x)
}


##' Pharmacokinetic models.
##' 
##' @name pk
##' @param ... passed to update
##'
##' @section Model description:
##' All pk models have two extravascular dosing compartments and potential for linear and nonlinear clearance.
##' \itemize{
##'  \item{\code{pk1cmt}}: one compartment pk model
##'  \item{\code{pk2cmt}}: two compartment pk  model
##'  \item{\code{pk3cmt}}: three compartment pk model
##' }
##'
##' @details
##'
##' See \code{\link{pkpd_details}} for more detailed descriptions of parameters and compartments.
##'
##' The \code{pk1cmt} model is parameterized in terms of \code{CL}, \code{VC}, \code{KA1} and \code{KA2} and uses compartments \code{EV1},
##' \code{EV2}, and \code{CENT}.  The \code{pk2cmt} model adds a \code{PERIPH} compartment and parameters \code{Q} and \code{VP} to that of the
##' one-compartment model.  Likewise, the three-compartment model (\code{pk3cmt}) adds \code{PERIPH2} and parameters \code{Q2} and \code{VP2} to
##' that of the two-compartment models.  All pk models also have parameters \code{VMAX} (defaulting to zero, no non-linear clearance) and \code{KM}.
##'
##' @return an object of class \code{packmod}
##' @examples
##'
##' ## example("pk", package="modmrg")
##'
##' mod <- pk1cmt(end=180)
##'
##' events <- ev(amt=1000, cmt=1, addl=4, ii=24)
##'
##'
##' mod
##' see(mod)
##' param(mod)
##' init(mod)
##' events
##'
##' out <- mod %>% ev(events) %>% mrgsim(delta=0.25)
##'
##' plot(out, CP~.)
##'
##'
##' mod <- pk1cmt_pop(end=180,delta=0.25)
##'
##' omega  <-  omat(dmat(0.1,0.3,0.2, 0.6))
##'
##' out <- mod %>% ev(events) %>%  mrgsim(omega=omega, idata=data.frame(ID=1:10))
##'
##' plot(out, CP~.)
##'
NULL


##' @export
##' @rdname pk
pk1cmt <- function(...) {configure("pk1cmt",...)}
##' @export
##' @rdname pk
pk2cmt <- function(...) return(configure("pk2cmt",...))
##' @export
##' @rdname pk
pk3cmt <- function(...) return(configure("pk3cmt", ...))

##' @export
##' @rdname pk
pk1cmt_pop <- function(...) return(configure("pk1cmt_pop", ...))


##' Pharmacokinetic / pharmacodynamic models. 
##' 
##' @name pkpd
##' @param ... passed to update
##' @details
##'
##' See \code{\link{pkpd_details}} for more detailed descriptions of parameters and compartments.
##'
##' All PK/PD models include 2-compartment PK model with absorption from 2 extravasular compartments and linear + nonlinear clearance.  The PK models are parameterized with \code{CL}, \code{VC}, \code{Q}, \code{VMAX}, \code{KM}, \code{KA1} and \code{KA2} and implement compartments \code{EV1}, \code{EV2}, \code{CENT}, \code{PERIPH} .  The indirect response models have compartment \code{RESP} and the emax model has output variable \code{RESP}.  PD parameters include \code{KIN}, \code{KOUT}, \code{IC50}, \code{EC50}, \code{IMAX}, \code{EMAX}, \code{E0}, and \code{n}.
##'
##' Also, once the model is loaded, use \code{\link{see}} method for \code{mrgmod} to view the model code.
##'
##' @section Model description:
##' \itemize{
##'  \item{\code{irm1}} inhibition of response production
##'  \item{\code{irm2}} inhibition of response loss
##'  \item{\code{irm3}} stimulation of response production
##'  \item{\code{irm4}} stimulation of response loss
##'  \item{\code{pd_effect}} effect compartment model
##'  \item{\code{emax}} sigmoid emax model
##' }
##' @return an object of class \code{packmod}
##'
##' @examples
##'
##' ## example("pkpd", package="modmrg")
##'
##' mod <- irm1(end=96, delta=0.2)
##'
##' mod
##'
##' see(mod)
##'
##' param(mod)
##' init(mod)
##'
##' events <- ev(amt=1000,cmt=1)
##'
##' out <- mod %>% ev(events) %>% mrgsim
##'
##' plot(out)
##'
NULL

##' @export
##' @rdname pkpd
irm1 <- function(...) return(configure("irm1",...))
##' @export
##' @rdname pkpd
irm2 <- function(...) return(configure("irm2",...))
##' @export
##' @rdname pkpd
irm3 <- function(...) return(configure("irm3",...))
##' @export
##' @rdname pkpd
irm4 <- function(...) return(configure("irm4",...))
##' @export
##' @rdname pkpd
emax <- function(...) return(configure("emax",...))


##' Target mediated disposition model.
##' 
##' @param ... passed to update
##' @export
##'
##' @section Parameters:
##' \itemize{
##' \item{\code{KEL}}: elimination rate constant
##' \item{\code{KTP}}: tissue to plasma rate constant
##' \item{\code{KPT}}: plasma to tissue rate constant
##' \item{\code{VC}}: volume of distribution
##' \item{\code{KA1}, \code{KA2}}: absorption rate constants
##' \item{\code{KINT}}: internalization rate constant
##' \item{\code{KON}}: association rate constant
##' \item{\code{KOFF}}: dissociation rate constant
##' \item{\code{KSYN}}: target systhesis rate
##' \item{\code{KDEG}}: target degredation rate constant
##' }
##'
##' @section Compartments:
##' \itemize{
##' \item{\code{CENT}}: unbound drug in central compartment
##' \item{\code{TISS}}: unbound drug in tissue compartment
##' \item{\code{REC}}: concentration of target
##' \item{\code{RC}}: concentration of drug-target complex
##' \item{\code{EV1}, \code{EV2}}: extravascular dosing compartments
##' }
##'
##' @section Output variables:
##' \itemize{
##' \item{\code{CP}}: unbound drug in the central compartment
##' \item{\code{TOTAL}}: total concentration of target (complexed and uncomplexed)
##' }
##'
tmdd <- function(...) return(configure("tmdd",...))

##' HCV viral dynamics models.
##' @name viral
##' @param ... passed to update
##'
##' @section Models:
##' \itemize{
##'  \item{\code{viral1}}: viral dynamics model with single HCV species
##'  \item{\code{viral2}}: viral dynamics model with wild-type and mutant HCV species
##' }
##'
##' @section Parameters:
##' \itemize{
##' \item{\code{s}}: new hepatocyte synthesis rate (cells/ml/day)
##' \item{\code{d}}: hepatocyte death rate constant (1/day)
##' \item{\code{p}}: viral production rate constant (copies/cell/day)
##' \item{\code{beta}}: new infection rate constant (ml/copy/day)
##' \item{\code{delta}}: infected cell death rate constant (1/day)
##' \item{\code{c}}: viral clearance rate constant (1/day)
##' \item{\code{fit}}: mutant virus fitness
##' \item{\code{N}}: non-target hepatocytes
##' \item{\code{mu}}: forward mutation rate
##' \item{\code{Tmax}}: maximum number of target hepatocytes (cells/ml)
##' \item{\code{rho}}: maximum hepatocyte regeneration rate (1/day)
##' }
##'
##' @section Compartments:
##' \itemize{
##' \item{\code{T}}: uninfected target hepatocytes (cells/ml)
##' \item{\code{I}}: productively infected hepatocytes (cells/ml)
##' \item{\code{V}}: hepatitis C virus (copies/ml)
##' \item{\code{IM}}: mutant infected hepatocytes (cells/ml)
##' \item{\code{VM}}: mutant hepatitis C virus (copies/ml)
##' \item{\code{expos}}: exposure metric to drive pharmacodynamic model
##' }
##'
##' @export
##'
##' @examples
##'
##' ## example("viral", package="modmrg")
##'
##' mod <- viral1(end=84, delta=0.25)
##'
##' mod
##'
##' see(mod)
##'
##' param(mod)
##' init(mod)
##'
##' on <-  ev(cmt=1, amt=100, evid=8,time=7)
##' off <- ev(cmt=1, amt=0, evid=8, time=21)
##'
##' out <- mod %>% ev(on + off) %>% mrgsim(req="")
##'
##' plot(out)
##'
viral1 <- function(...) return(configure("viral1",...))
##' @export
##' @rdname viral
viral2 <- function(...) return(configure("viral2",...))


##'
##' Simulate from 1- or 2-compartment PK model.
##'
##' This is an R function that returns model objects based on \code{$PKMODEL}.
##'
##' @param ncmt passed to \code{\link{PKMODEL}}
##' @param depot passed to \code{\link{PKMODEL}}
##' @param ... passed to \code{\link{update}}
##' @return An object of class \code{\link{mrgmod-class}}
##'
##'
##' @details Once the model object is generated, use \code{\link{param}} to check names of the parameters in the model and \code{\link{init}} to check
##' the names of the compartments in the model.  Calculations for the amounts in each compartment are done via analytical solutions, not differential equations.
##' A subject-level random effect is also provided for each PK parameter; use \code{\link{omat}} to see the names of those random effects.  All random effect
##' variances have initial value of zero and may be updated via \code{\link{omat}}.
##'
##' @examples
##'
##' mod <- pkmodel(1)
##'
##' mod <- pkmodel(1,TRUE)
##'
##' mod %>% ev(amt=1000, ii=24, addl=3) %>% mrgsim(end=120)
##'
##' mod <- pkmodel(2)
##'
##' mod <- pkmodel(2,TRUE)
##'
##'
##'
##'
##'
##' @export
##' @rdname pk_model
pkmodel <- function(ncmt=1,depot=FALSE,...) {
  stopifnot(ncmt %in% c(1,2))
  depot <- as.logical(depot)
  code <- paste0("modpk", ncmt, ifelse(depot, "po", ""))
  x <- configure(code,...)
  return(x)
}


##' @rdname pkpd
##' @export
##' 
pd_effect <- function(...) {
  configure("effect",...) 
}

##' Extract the code from a model.
##' 
##' @param x an mrgsolve model object
##' @return a character vector of model code
code <- function(x) {
  what <- try(x@code, silent=TRUE)
  if(inherits("try-error",what)) {
    message("Could not find model code.")
    return(invisible(NULL))
  }
  return(what)
}

.onAttach <- function(libname,pkgname) {
  packageStartupMessage("modmrg: Pre-release / Community Edition")
  packageStartupMessage("www.github.com/metrumresearchgroup")
}
