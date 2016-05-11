//* MRGSOLVE file
#include "modelheader.h"
#ifndef MODELINCLUDEGUARD
#define INITFUN___ _model_emax_main__
#define ODEFUN___ _model_emax_ode__
#define TABLECODE___ _model_emax_table__
#define _nEQ 4
#define _nPAR 12
#define EV1 _A_[0]
#define CENT _A_[1]
#define PERIPH _A_[2]
#define EV2 _A_[3]
#define EV1_0 _A_0_[0]
#define CENT_0 _A_0_[1]
#define PERIPH_0 _A_0_[2]
#define EV2_0 _A_0_[3]
#define dxdt_EV1 _DADT_[0]
#define dxdt_CENT _DADT_[1]
#define dxdt_PERIPH _DADT_[2]
#define dxdt_EV2 _DADT_[3]
#define CL _THETA_[0]
#define VC _THETA_[1]
#define KA1 _THETA_[2]
#define KA2 _THETA_[3]
#define Q _THETA_[4]
#define VP _THETA_[5]
#define VMAX _THETA_[6]
#define KM _THETA_[7]
#define E0 _THETA_[8]
#define EMAX _THETA_[9]
#define EC50 _THETA_[10]
#define n _THETA_[11]
#define MODELINCLUDEGUARD
#endif

// GLOBAL VARIABLES:


#define CP (CENT/VC)
#define CT (PERIPH/VP)
#define CLNL (VMAX/(KM+CP))
#define RESP (E0+EMAX*pow(CP,n)/(pow(EC50,n)+pow(CP,n)))
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
dxdt_CENT = KA1*EV1 + KA2*EV2 - (CL+CLNL+Q)*CP  + Q*CT;
dxdt_PERIPH = Q*CP - Q*CT;
END_ode

// TABLE CODE BLOCK:
BEGIN_table
capture(CP);
capture(RESP);
END_table
