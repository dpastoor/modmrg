$PARAM
CL = 1, VC=10, KA1=1, KA2=1
Q = 2, VP=10, Q2 = 2, VP2 = 100
VMAX = 0, KM=2
$INIT EV1=0, CENT=0, PERIPH = 0,PERIPH2  = 0, EV2=0


$GLOBAL
#define CP (CENT/VC)
#define CT (PERIPH/VP)
#define CT2 (PERIPH2/VP2)
#define CLNL (VMAX/(KM+CP))

$ODE
dxdt_EV1 = -KA1*EV1;
dxdt_EV2 = -KA2*EV2;
dxdt_CENT = KA1*EV1 + KA2*EV2 - (CL+CLNL+Q+Q2)*CP  + Q*CT + Q2*CT2;
dxdt_PERIPH = Q*CP - Q*CT;
dxdt_PERIPH2 = Q2*CP - Q2*CT2;

$TABLE
table(CP)=CP;
