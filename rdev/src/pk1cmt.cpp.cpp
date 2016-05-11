//* MRGSOLVE file
#include "modelheader.h"
#ifndef MODELINCLUDEGUARD
#define INITFUN___ _model_pk1cmt_main__
#define ODEFUN___ _model_pk1cmt_ode__
#define TABLECODE___ _model_pk1cmt_table__
#define _nEQ 3
#define _nPAR 6
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
#define VMAX _THETA_[4]
#define KM _THETA_[5]
#define MODELINCLUDEGUARD
#endif

// GLOBAL VARIABLES:


#define CP (CENT/VC)
#define CT (PERIPH/VP)
#define CLNL (VMAX/(KM+CP))
typedef double localdouble;
typedef int localint;
typedef bool localbool;

// MAIN CODE BLOCK:
BEGIN_main

END_main

// DIFFERENTIAL EQUATIONS:
BEGIN_ode
dxdt_EV1 = -KA1*EV1;
dxdt_EV2 = -KA2*EV2;
dxdt_CENT = KA1*EV1 + KA2*EV2 - (CL+CLNL)*CP;
END_ode

// TABLE CODE BLOCK:
BEGIN_table
capture(CP);
END_table
