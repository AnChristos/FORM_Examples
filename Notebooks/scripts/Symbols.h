#ifndef `SYMBOLSH'
#define SYMBOLSH "1"
*-------------------------------------------------------------------------*
* Symbols.h
* 
* Based on material from:  
* https://www.nikhef.nl/~form/maindir/courses/uam2019/uam2019.html
*-------------------------------------------------------------------------*

*-------------------------------------------------------------------------*
* Symbols.h - Clean Explicit Version
*-------------------------------------------------------------------------*

* --- Preprocessor Limits ---
#ifndef `MAXLIMITS'
    #define MAXLIMITS "1"
    #define IMAXIND "40"
    #define MUMAXIND "20"
    #define MAXVEC "10"
#endif

* --- Indices ---
* Lorentz indices (mu1, mu2, ...)
Index mu, mu1, ..., mu`MUMAXIND';
* Spinor/Trace indices (i1, i2, ...)
Index i, i1, ..., i`IMAXIND';
* Gamma-5/6/7 structure indices
Index k5=0, k6=0, k7=0;
Index k;
* --- 4- vectors ---
Vector p, p1, ..., p`MAXVEC';
Vector q, q1, q2, q3;
* --- Symbols ---
Symbols m, s, t, u, cv, ca;
* --- Functions ---
CF UB, U, VB, V, g;
CF eps, epsM, fprop, phprop, Zprop, Wprop, prop, Fermiprop;

#endif
