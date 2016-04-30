//* MRGSOLVE file
#include "modelheader.h"
#ifndef MODELINCLUDEGUARD
#define INITFUN___ _model_viral2_main__
#define ODEFUN___ _model_viral2_ode__
#define TABLECODE___ _model_viral2_table__
#define _nEQ 6
#define _nPAR 14
#define expos _A_[0]
#define T _A_[1]
#define I _A_[2]
#define V _A_[3]
#define VM _A_[4]
#define IM _A_[5]
#define expos_0 _A_0_[0]
#define T_0 _A_0_[1]
#define I_0 _A_0_[2]
#define V_0 _A_0_[3]
#define VM_0 _A_0_[4]
#define IM_0 _A_0_[5]
#define dxdt_expos _DADT_[0]
#define dxdt_T _DADT_[1]
#define dxdt_I _DADT_[2]
#define dxdt_V _DADT_[3]
#define dxdt_VM _DADT_[4]
#define dxdt_IM _DADT_[5]
#define p _THETA_[0]
#define fit _THETA_[1]
#define c _THETA_[2]
#define delta _THETA_[3]
#define s _THETA_[4]
#define d _THETA_[5]
#define beta _THETA_[6]
#define N _THETA_[7]
#define shift _THETA_[8]
#define AUC _THETA_[9]
#define IC50 _THETA_[10]
#define mu _THETA_[11]
#define Tmax _THETA_[12]
#define rho _THETA_[13]
#define MODELINCLUDEGUARD
#endif

// GLOBAL VARIABLES:


#define a (s + rho*T_0*(1-((T_0+N)/Tmax)) - d*T_0)
#define b (beta*T_0 * ((1-fit)/(1-mu-fit)) * (1+(rho*T_0)/(delta*Tmax)))
#define eps (expos/(IC50+expos))
#define epsm (expos/(IC50*shift+expos))
typedef double localdouble;
typedef int localint;
typedef bool localbool;

// MAIN CODE BLOCK:
BEGIN_main
T_0 = c*delta/((1-mu)*beta*p);
V_0 = a/b;
I_0 = (beta/delta)*V_0 * T_0;
VM_0 = V_0*(mu)/(1-mu-fit);
IM_0 = (beta/delta) * VM_0 * T_0;
expos_0 = AUC;

END_main

// DIFFERENTIAL EQUATIONS:
BEGIN_ode
dxdt_T = s+rho*T*(1-((T+I+IM+N)/Tmax)) - d*T - beta*V*T - beta*VM*T;
dxdt_I = beta*V*T - delta*I;
dxdt_V = (1-mu)*(1-eps)*p*I - c*V;
dxdt_IM = beta*VM*T - delta*IM;
dxdt_VM = mu*(1-eps)*p*I + (1-epsm)*fit*p*IM - c*VM;
dxdt_expos = 0;
END_ode

// TABLE CODE BLOCK:
BEGIN_table
table(logVT) = log10(V+VM);
table(logV) = log10(V);
table(logVM) = log10(VM);
table(logIT) = log10(IM+I);
table(logChange) = log10(VM+V) - log10(VM_0 + V_0);
END_table
