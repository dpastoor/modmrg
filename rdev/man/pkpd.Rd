% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mrgsolveModels.R
\name{pkpd}
\alias{emax}
\alias{irm1}
\alias{irm2}
\alias{irm3}
\alias{irm4}
\alias{pd_effect}
\alias{pkpd}
\title{Pharmacokinetic / pharmacodynamic models.}
\usage{
irm1(...)

irm2(...)

irm3(...)

irm4(...)

emax(...)

pd_effect(...)
}
\arguments{
\item{...}{passed to update}
}
\value{
an object of class \code{packmod}
}
\description{
Pharmacokinetic / pharmacodynamic models.
}
\details{
See \code{\link{pkpd_details}} for more detailed descriptions of parameters and compartments.

All PK/PD models include 2-compartment PK model with absorption from 2 extravasular compartments and linear + nonlinear clearance.  The PK models are parameterized with \code{CL}, \code{VC}, \code{Q}, \code{VMAX}, \code{KM}, \code{KA1} and \code{KA2} and implement compartments \code{EV1}, \code{EV2}, \code{CENT}, \code{PERIPH} .  The indirect response models have compartment \code{RESP} and the emax model has output variable \code{RESP}.  PD parameters include \code{KIN}, \code{KOUT}, \code{IC50}, \code{EC50}, \code{IMAX}, \code{EMAX}, \code{E0}, and \code{n}.

Also, once the model is loaded, use \code{\link{see}} method for \code{mrgmod} to view the model code.
}
\section{Model description}{

\itemize{
 \item{\code{irm1}} inhibition of response production
 \item{\code{irm2}} inhibition of response loss
 \item{\code{irm3}} stimulation of response production
 \item{\code{irm4}} stimulation of response loss
 \item{\code{pd_effect}} effect compartment model
 \item{\code{emax}} sigmoid emax model
}
}
\examples{

## example("pkpd", package="modmrg")

mod <- irm1(end=96, delta=0.2)

mod

see(mod)

param(mod)
init(mod)

events <- ev(amt=1000,cmt=1)

out <- mod \%>\% ev(events) \%>\% mrgsim

plot(out)

}

