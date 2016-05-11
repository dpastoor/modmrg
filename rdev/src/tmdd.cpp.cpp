//* MRGSOLVE file
#include "modelheader.h"
#ifndef MODELINCLUDEGUARD
#define INITFUN___ _model_tmdd_main__
#define ODEFUN___ _model_tmdd_ode__
#define TABLECODE___ _model_tmdd_table__
#define _nEQ 6
#define _nPAR 11
#define EV1 _A_[0]
#define CENT _A_[1]
#define TISS _A_[2]
#define REC _A_[3]
#define RC _A_[4]
#define EV2 _A_[5]
#define EV1_0 _A_0_[0]
#define CENT_0 _A_0_[1]
#define TISS_0 _A_0_[2]
#define REC_0 _A_0_[3]
#define RC_0 _A_0_[4]
#define EV2_0 _A_0_[5]
#define dxdt_EV1 _DADT_[0]
#define dxdt_CENT _DADT_[1]
#define dxdt_TISS _DADT_[2]
#define dxdt_REC _DADT_[3]
#define dxdt_RC _DADT_[4]
#define dxdt_EV2 _DADT_[5]
#define KPT _THETA_[0]
#define KTP _THETA_[1]
#define VC _THETA_[2]
#define KA1 _THETA_[3]
#define KA2 _THETA_[4]
#define KEL _THETA_[5]
#define R0 _THETA_[6]
#define KDEG _THETA_[7]
#define KINT _THETA_[8]
#define KON _THETA_[9]
#define KOFF _THETA_[10]
#define MODELINCLUDEGUARD
#endif

// GLOBAL VARIABLES:


namespace tmdd {
  double _dxdt_CP=0;
  double TMDDR0 = 0;  
}
#define KSYN (R0*KDEG)
#define CP (CENT/VC)
typedef double localdouble;
typedef int localint;
typedef bool localbool;

// MAIN CODE BLOCK:
BEGIN_main
REC_0 = R0;
tmdd::TMDDR0 = _R(3);

END_main

// DIFFERENTIAL EQUATIONS:
BEGIN_ode
dxdt_EV1 = -KA1*EV1;
dxdt_EV2 = -KA2*EV2;
tmdd::_dxdt_CP = (tmdd::TMDDR0+KA1*EV1 + KA2*EV2)/VC - (KEL+KPT)*CP - KON*CP*REC + KOFF*RC + KTP*TISS/VC;
dxdt_CENT = tmdd::_dxdt_CP * VC;
dxdt_TISS = KPT*CP*VC - KTP*TISS;
dxdt_REC = KSYN - KDEG*REC - KON*CP*REC + KOFF*RC;
dxdt_RC = KON*CP*REC - (KINT+KOFF)*RC;
END_ode

// TABLE CODE BLOCK:
BEGIN_table
table(TOTAL) = REC+RC;
capture(CP);
END_table
