//* MRGSOLVE file
#include "modelheader.h"
#ifndef MODELINCLUDEGUARD
#define INITFUN___ _model_modpk1_main__
#define ODEFUN___ _model_modpk1_ode__
#define TABLECODE___ _model_modpk1_table__
#define _nEQ 1
#define _nPAR 2
#define CENT _A_[0]
#define CENT_0 _A_0_[0]
#define dxdt_CENT _DADT_[0]
#define CL _THETA_[0]
#define V _THETA_[1]
#define ECL ETA(1)
#define EV ETA(2)
#define MODELINCLUDEGUARD
#endif

// GLOBAL VARIABLES:


typedef double localdouble;
typedef int localint;
typedef bool localbool;

// MAIN CODE BLOCK:
BEGIN_main
pred_CL = CL*exp(ETA(1));
pred_V  = V *exp(ETA(2));

END_main

// DIFFERENTIAL EQUATIONS:
BEGIN_ode
DXDTZERO();

END_ode

// TABLE CODE BLOCK:
BEGIN_table
table(CP) = CENT/pred_V;
END_table
