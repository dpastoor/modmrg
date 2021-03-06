% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mrgsolveModels.R
\name{viral}
\alias{viral}
\alias{viral1}
\alias{viral2}
\title{HCV viral dynamics models.}
\usage{
viral1(...)

viral2(...)
}
\arguments{
\item{...}{passed to update}
}
\description{
HCV viral dynamics models.
}
\section{Models}{

\itemize{
 \item{\code{viral1}}: viral dynamics model with single HCV species
 \item{\code{viral2}}: viral dynamics model with wild-type and mutant HCV species
}
}

\section{Parameters}{

\itemize{
\item{\code{s}}: new hepatocyte synthesis rate (cells/ml/day)
\item{\code{d}}: hepatocyte death rate constant (1/day)
\item{\code{p}}: viral production rate constant (copies/cell/day)
\item{\code{beta}}: new infection rate constant (ml/copy/day)
\item{\code{delta}}: infected cell death rate constant (1/day)
\item{\code{c}}: viral clearance rate constant (1/day)
\item{\code{fit}}: mutant virus fitness
\item{\code{N}}: non-target hepatocytes
\item{\code{mu}}: forward mutation rate
\item{\code{Tmax}}: maximum number of target hepatocytes (cells/ml)
\item{\code{rho}}: maximum hepatocyte regeneration rate (1/day)
}
}

\section{Compartments}{

\itemize{
\item{\code{T}}: uninfected target hepatocytes (cells/ml)
\item{\code{I}}: productively infected hepatocytes (cells/ml)
\item{\code{V}}: hepatitis C virus (copies/ml)
\item{\code{IM}}: mutant infected hepatocytes (cells/ml)
\item{\code{VM}}: mutant hepatitis C virus (copies/ml)
\item{\code{expos}}: exposure metric to drive pharmacodynamic model
}
}
\examples{

## example("viral", package="modmrg")

mod <- viral1(end=84, delta=0.25)

mod

see(mod)

param(mod)
init(mod)

on <-  ev(cmt=1, amt=100, evid=8,time=7)
off <- ev(cmt=1, amt=0, evid=8, time=21)

out <- mod \%>\% ev(on + off) \%>\% mrgsim(req="")

plot(out)

}

