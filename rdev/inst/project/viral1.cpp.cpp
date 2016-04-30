//* MRGSOLVE file
#include "modelheader.h"
#ifndef MODELINCLUDEGUARD
#define INITFUN___ _model_viral1_main__
#define ODEFUN___ _model_viral1_ode__
#define TABLECODE___ _model_viral1_table__
#define _nEQ 4
#define _nPAR 9
#define expos _A_[0]
#define T _A_[1]
#define I _A_[2]
#define V _A_[3]
#define expos_0 _A_0_[0]
#define T_0 _A_0_[1]
#define I_0 _A_0_[2]
#define V_0 _A_0_[3]
#define dxdt_expos _DADT_[0]
#define dxdt_T _DADT_[1]
#define dxdt_I _DADT_[2]
#define dxdt_V _DADT_[3]
#define p _THETA_[0]
#define c _THETA_[1]
#define delta _THETA_[2]
#define s _THETA_[3]
#define d _THETA_[4]
#define beta _THETA_[5]
#define AUC _THETA_[6]
#define IC50 _THETA_[7]
#define eta _THETA_[8]
#define MODELINCLUDEGUARD
#endif

// GLOBAL VARIABLES:


#define eps (expos/(IC50+expos))
typedef double localdouble;
typedef int localint;
typedef bool localbool;

// MAIN CODE BLOCK:
BEGIN_main
T_0 = c*delta/(beta*p);
V_0 = (s*p*beta - d*c*delta)/(delta*c*beta);
I_0 = (s*p*beta - d*c*delta)/(delta*p*beta);
expos_0 = 0;

END_main

// DIFFERENTIAL EQUATIONS:
BEGIN_ode
dxdt_T = s - d*T - (1-eta)*beta*V*T;
dxdt_I = (1-eta)*beta*V*T - delta*I;
dxdt_V = (1-eps)*p*I - c*V;
dxdt_expos = 0;
END_ode

// TABLE CODE BLOCK:
BEGIN_table
table(logV) = log10(V);
table(logChange) = log10(V) - log10(V_0);
END_table
