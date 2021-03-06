% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mrgsolveModels.R
\name{tmdd}
\alias{tmdd}
\title{Target mediated disposition model.}
\usage{
tmdd(...)
}
\arguments{
\item{...}{passed to update}
}
\description{
Target mediated disposition model.
}
\section{Parameters}{

\itemize{
\item{\code{KEL}}: elimination rate constant
\item{\code{KTP}}: tissue to plasma rate constant
\item{\code{KPT}}: plasma to tissue rate constant
\item{\code{VC}}: volume of distribution
\item{\code{KA1}, \code{KA2}}: absorption rate constants
\item{\code{KINT}}: internalization rate constant
\item{\code{KON}}: association rate constant
\item{\code{KOFF}}: dissociation rate constant
\item{\code{KSYN}}: target systhesis rate
\item{\code{KDEG}}: target degredation rate constant
}
}

\section{Compartments}{

\itemize{
\item{\code{CENT}}: unbound drug in central compartment
\item{\code{TISS}}: unbound drug in tissue compartment
\item{\code{REC}}: concentration of target
\item{\code{RC}}: concentration of drug-target complex
\item{\code{EV1}, \code{EV2}}: extravascular dosing compartments
}
}

\section{Output variables}{

\itemize{
\item{\code{CP}}: unbound drug in the central compartment
\item{\code{TOTAL}}: total concentration of target (complexed and uncomplexed)
}
}

