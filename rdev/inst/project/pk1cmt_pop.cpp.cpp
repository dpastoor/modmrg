//* MRGSOLVE file
#include "modelheader.h"
#ifndef MODELINCLUDEGUARD
#define INITFUN___ _model_pk1cmt__pop_main__
#define ODEFUN___ _model_pk1cmt__pop_ode__
#define TABLECODE___ _model_pk1cmt__pop_table__
#define _nEQ 3
#define _nPAR 11
#define EV1 _A_[0]
#define CENT _A_[1]
#define EV2 _A_[2]
#define EV1_0 _A_0_[0]
#define CENT_0 _A_0_[1]
#define EV2_0 _A_0_[2]
#define dxdt_EV1 _DADT_[0]
#define dxdt_CENT _DADT_[1]
#define dxdt_EV2 _DADT_[2]
#define CL _THETA_[0]
#define VC _THETA_[1]
#define KA1 _THETA_[2]
#define KA2 _THETA_[3]
#define F1 _THETA_[4]
#define TVCL _THETA_[5]
#define TVVC _THETA_[6]
#define TVKA1 _THETA_[7]
#define TVKA2 _THETA_[8]
#define VMAX _THETA_[9]
#define KM _THETA_[10]
#define MODELINCLUDEGUARD
#endif

// GLOBAL VARIABLES:


#define CT (PERIPH/VP)
#define CLNL (VMAX/(KM+pop1::CP))
namespace pop1 {
  double CLi=0, VCi = 0, KA1i = 0, KA2i= 0, CP = 0; 
}
typedef double localdouble;
typedef int localint;
typedef bool localbool;

// MAIN CODE BLOCK:
BEGIN_main
  pop1::CLi = TVCL*exp(ETA(1));
  pop1::VCi = TVVC*exp(ETA(2));
  pop1::KA1i = TVKA1*exp(ETA(3));
  pop1::KA2i = TVKA2*exp(ETA(4));
  _F(1) = F1;

END_main

// DIFFERENTIAL EQUATIONS:
BEGIN_ode
pop1::CP = CENT/pop1::VCi;
dxdt_EV1 = -pop1::KA1i*EV1;
dxdt_EV2 = -pop1::KA2i*EV2;
dxdt_CENT = pop1::KA1i*EV1 + pop1::KA2i*EV2 - (pop1::CLi+CLNL)*pop1::CP;
END_ode

// TABLE CODE BLOCK:
BEGIN_table
table(CP) = pop1::CP*(1+EPS(1)); 
END_table
