//* MRGSOLVE file
#include "modelheader.h"
#ifndef MODELINCLUDEGUARD
#define INITFUN___ _model_effect_main__
#define ODEFUN___ _model_effect_ode__
#define TABLECODE___ _model_effect_table__
#define _nEQ 4
#define _nPAR 9
#define GUT _A_[0]
#define CENT _A_[1]
#define PERIPH _A_[2]
#define CE _A_[3]
#define GUT_0 _A_0_[0]
#define CENT_0 _A_0_[1]
#define PERIPH_0 _A_0_[2]
#define CE_0 _A_0_[3]
#define dxdt_GUT _DADT_[0]
#define dxdt_CENT _DADT_[1]
#define dxdt_PERIPH _DADT_[2]
#define dxdt_CE _DADT_[3]
#define VC _THETA_[0]
#define KA _THETA_[1]
#define K10 _THETA_[2]
#define K12 _THETA_[3]
#define K21 _THETA_[4]
#define E0 _THETA_[5]
#define EMAX _THETA_[6]
#define EC50 _THETA_[7]
#define KEO _THETA_[8]
#define MODELINCLUDEGUARD
#endif

// GLOBAL VARIABLES:


typedef double localdouble;
typedef int localint;
typedef bool localbool;
double CP;

// MAIN CODE BLOCK:
BEGIN_main

END_main

// DIFFERENTIAL EQUATIONS:
BEGIN_ode
CP = CENT/VC;
dxdt_GUT = -KA*GUT;
dxdt_CENT = KA*GUT - K10*CENT - K12*CENT + K21*PERIPH;
dxdt_PERIPH = K12*CENT - K21*PERIPH;
dxdt_CE = KEO*(CP-CE);
END_ode

// TABLE CODE BLOCK:
BEGIN_table
table(EFFECT) = E0 - EMAX*CE/(CE+EC50);
table(CP) = CENT/VC;
END_table
