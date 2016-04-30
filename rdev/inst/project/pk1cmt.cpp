$PARAM
CL=1, VC=10, KA1=1, KA2=1
VMAX = 0, KM=2
$INIT EV1=0, CENT=0, EV2=0

$GLOBAL
#define CP (CENT/VC)
#define CT (PERIPH/VP)
#define CLNL (VMAX/(KM+CP))


$ODE
dxdt_EV1 = -KA1*EV1;
dxdt_EV2 = -KA2*EV2;
dxdt_CENT = KA1*EV1 + KA2*EV2 - (CL+CLNL)*CP;

$TABLE
table(CP) = CP;
