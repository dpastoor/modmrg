//* MRGSOLVE file
#include "modelheader.h"
#ifndef MODELINCLUDEGUARD
#define INITFUN___ _model_modpk2_main__
#define ODEFUN___ _model_modpk2_ode__
#define TABLECODE___ _model_modpk2_table__
#define _nEQ 2
#define _nPAR 4
#define CENT _A_[0]
#define PERIPH _A_[1]
#define CENT_0 _A_0_[0]
#define PERIPH_0 _A_0_[1]
#define dxdt_CENT _DADT_[0]
#define dxdt_PERIPH _DADT_[1]
#define CL _THETA_[0]
#define V2 _THETA_[1]
#define Q _THETA_[2]
#define V3 _THETA_[3]
#define ECL ETA(1)
#define EV2 ETA(2)
#define EQ ETA(3)
#define EV3 ETA(4)
#define MODELINCLUDEGUARD
#endif

// GLOBAL VARIABLES:


typedef double localdouble;
typedef int localint;
typedef bool localbool;

// MAIN CODE BLOCK:
BEGIN_main
pred_CL = CL*exp(ETA(1));
pred_V2 = V2*exp(ETA(2));
pred_Q  = Q *exp(ETA(3));
pred_V3 = V3*exp(ETA(4));

END_main

// DIFFERENTIAL EQUATIONS:
BEGIN_ode
DXDTZERO();

END_ode

// TABLE CODE BLOCK:
BEGIN_table
table(CP) = CENT/pred_V2;
END_table
