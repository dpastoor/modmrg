//* MRGSOLVE file
#include "modelheader.h"
#ifndef MODELINCLUDEGUARD
#define INITFUN___ _model_modpk1po_main__
#define ODEFUN___ _model_modpk1po_ode__
#define TABLECODE___ _model_modpk1po_table__
#define _nEQ 2
#define _nPAR 3
#define DEPOT _A_[0]
#define CENT _A_[1]
#define DEPOT_0 _A_0_[0]
#define CENT_0 _A_0_[1]
#define dxdt_DEPOT _DADT_[0]
#define dxdt_CENT _DADT_[1]
#define CL _THETA_[0]
#define V _THETA_[1]
#define KA _THETA_[2]
#define ECL ETA(1)
#define EV ETA(2)
#define EKA ETA(3)
#define MODELINCLUDEGUARD
#endif

// GLOBAL VARIABLES:


typedef double localdouble;
typedef int localint;
typedef bool localbool;

// MAIN CODE BLOCK:
BEGIN_main
pred_CL   = CL*exp(ETA(1));
pred_V    = V *exp(ETA(2));
pred_KA   = KA*exp(ETA(3));

END_main

// DIFFERENTIAL EQUATIONS:
BEGIN_ode
DXDTZERO();

END_ode

// TABLE CODE BLOCK:
BEGIN_table
table(CP) = CENT/pred_V;
END_table
