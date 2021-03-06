modmrg
======

# *DEPRECATED* syntax in many of these models now, use internal model library to mrgsolve or other references!

A package of models in `mrgsolve` format.

Installation
------------

``` r
devtools::install_github("metrumresearchgroup/modmrg", subdir="rdev")
```

Dependencies
------------

`modmrg` depends on `mrgsolve`. **NOTE**: we are still working out the necessary policies to make sure that `modmrg` is compatible with `mrgsolve`. For now, it is best to use the latest dev versions of both packages.

Models
------

1.  PK: 1, 2, 3 compartment
    -   All with dual-absorption and linear + non-linear elimination pathways

2.  PD (all with 2-cmt PK):
    -   Indirect response type 1, 2, 3, 4
    -   Direct EMAX model
    -   Effect compartment model

3.  TMDD
4.  Viral dynamic 1- and 2-strain models

Help
----

``` r
?modmrg
```

Examples
--------

### 2-Compartment PK model

``` r
library(modmrg)
```

    . Loading required package: mrgsolve

    . mrgsolve: Community Edition

    . www.github.com/metrumresearchgroup

    . 
    . Attaching package: 'modmrg'

    . The following object is masked from 'package:mrgsolve':
    . 
    .     pkmodel

``` r
mod <- pk2cmt()

mod
```

    . 
    . 
    . -------- mrgsolve model object (unix) --------
    .   Project: /Users/kyleb/Rlibs/lib/modmrg/project
    .   source:        pk2cmt.cpp
    .   shared object: modmrg (loaded)
    . 
    .   compile date:  05/02 10:26
    .   Time:          start: 0 end: 24 delta: 1
    .   >              add: <none>
    .   >              tscale: 1
    . 
    .   Compartments:  EV1 CENT PERIPH EV2 [4]
    .   Parameters:    CL VC KA1 KA2 Q VP
    .   >              VMAX KM [8]
    .   Omega:         0x0 
    .   Sigma:         0x0 
    . 
    .   Solver:        atol: 1e-08 rtol: 1e-08
    .   >              maxsteps: 2000 hmin: 0 hmax: 0

``` r
param(mod)
```

    . 
    .  Model parameters (N=8):
    .  name value . name value
    .  CL   1     | Q    2    
    .  KA1  1     | VC   10   
    .  KA2  1     | VMAX 0    
    .  KM   2     | VP   10

``` r
init(mod)
```

    . 
    .  Model initial conditions (N=4):
    .  name       value . name         value
    .  CENT (2)   0     | EV2 (4)      0    
    .  EV1 (1)    0     | PERIPH (3)   0

``` r
mod %>%
  ev(amt=250, ii=48, addl=10) %>% 
  mrgsim(end=1000 )%>% 
  plot
```

![](img/README-unnamed-chunk-4-1.png)

### Indirect response model

``` r
mod <- irm1()
see(mod)
```

    . 
    . Model file:  irm1.cpp 
    .  $PARAM
    .  CL=1, VC=10, KA1=0.5, KA2=0.5
    .  Q = 0, VP=10
    .  KIN = 10, KOUT=2, IC50 = 2, IMAX=1
    .  VMAX = 0, KM=2, n=1
    .  
    .  $INIT EV1 = 0, CENT= 0, PERIPH = 0, RESP = 5, EV2=0
    .  
    .  
    .  $GLOBAL
    .  #define CP (CENT/VC)
    .  #define CT (PERIPH/VP)
    .  #define CLNL (VMAX/(KM+CP))
    .  #define INH (IMAX*pow(CP,n)/(pow(IC50,n)+pow(CP,n)))
    .  
    .  $MAIN
    .  RESP_0 = KIN/KOUT;
    .  
    .  $ODE
    .  dxdt_EV1 = -KA1*EV1;
    .  dxdt_EV2 = -KA2*EV2;
    .  dxdt_CENT = KA1*EV1 + KA2*EV2 - (CL+CLNL+Q)*CP  + Q*CT;
    .  dxdt_PERIPH = Q*CP - Q*CT;
    .  dxdt_RESP = KIN*(1-INH) - KOUT*RESP;
    .  
    .  $TABLE
    .  table(CP)=CP;

``` r
mod %>% 
  param(CL=0.5, n=2.5, IMAX=0.85) %>%
  ev(amt=750) %>% 
  Req(RESP) %>% 
  knobs(IC50=seq(5,55,10), delta=0.1, end=96) %>%
  plot
```

![](img/README-unnamed-chunk-5-1.png)

### PK model with analytical solution (not based on ODEs)

``` r
mod <- modmrg::pkmodel(ncmt=2) %>% param(Q=1, V2=8) %>% Req(CP)
mod %>% ev(amt=1000,rate=1000/100) %>% mrgsim(end=336) %>% plot
```

![](img/README-unnamed-chunk-6-1.png)

### Extract the code from any model

``` r
mod <- viral2()

modmrg:::code(mod)
```

    .  [1] "$PARAM"                                                                  
    .  [2] "p= 25, fit=0.75, c = 8"                                                  
    .  [3] "delta=0.4, s=0, d=1/300, beta=5.5E-8"                                    
    .  [4] "N = 6.5E6, shift=10, AUC=0, IC50=2"                                      
    .  [5] "mu=6.14E-5, Tmax = 1.3E7, rho = 1.25"                                    
    .  [6] ""                                                                        
    .  [7] "$INIT"                                                                   
    .  [8] "expos=0, T = 1126801, I = 1126801, V = 8148974"                          
    .  [9] "VM = 87.8, IM = 12.1"                                                    
    . [10] ""                                                                        
    . [11] "$SET delta=0.2"                                                          
    . [12] ""                                                                        
    . [13] "$GLOBAL"                                                                 
    . [14] "#define a (s + rho*T_0*(1-((T_0+N)/Tmax)) - d*T_0)"                      
    . [15] "#define b (beta*T_0 * ((1-fit)/(1-mu-fit)) * (1+(rho*T_0)/(delta*Tmax)))"
    . [16] "#define eps (expos/(IC50+expos))"                                        
    . [17] "#define epsm (expos/(IC50*shift+expos))"                                 
    . [18] ""                                                                        
    . [19] "$MAIN"                                                                   
    . [20] "T_0 = c*delta/((1-mu)*beta*p);"                                          
    . [21] "V_0 = a/b;"                                                              
    . [22] "I_0 = (beta/delta)*V_0 * T_0;"                                           
    . [23] "VM_0 = V_0*(mu)/(1-mu-fit);"                                             
    . [24] "IM_0 = (beta/delta) * VM_0 * T_0;"                                       
    . [25] "expos_0 = AUC;"                                                          
    . [26] ""                                                                        
    . [27] ""                                                                        
    . [28] "$ODE"                                                                    
    . [29] "dxdt_T = s+rho*T*(1-((T+I+IM+N)/Tmax)) - d*T - beta*V*T - beta*VM*T;"    
    . [30] "dxdt_I = beta*V*T - delta*I;"                                            
    . [31] "dxdt_V = (1-mu)*(1-eps)*p*I - c*V;"                                      
    . [32] "dxdt_IM = beta*VM*T - delta*IM;"                                         
    . [33] "dxdt_VM = mu*(1-eps)*p*I + (1-epsm)*fit*p*IM - c*VM;"                    
    . [34] "dxdt_expos = 0;"                                                         
    . [35] ""                                                                        
    . [36] "$TABLE"                                                                  
    . [37] "table(logVT) = log10(V+VM);"                                             
    . [38] "table(logV) = log10(V);"                                                 
    . [39] "table(logVM) = log10(VM);"                                               
    . [40] "table(logIT) = log10(IM+I);"                                             
    . [41] "table(logChange) = log10(VM+V) - log10(VM_0 + V_0);"                     
    . [42] ""
