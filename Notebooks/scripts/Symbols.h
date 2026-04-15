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

* --- Symbol Limits ---
#ifndef `MAXLIMITS'
    #define MAXLIMITS "1"
    
* Limits for a single amplitude
    #define IMAX "40"        
    #define MUMAX "20"
    
* Buffer for squaring (2x the base)
    #define IMAX2 "80"       
    #define MUMAX2 "40"
    
* Limits on lines and independent 4-momenta
    #define MAXTRACE "10"    
    #define MAXVEC "10"      
#endif

* --- Explicit Declarations ---
Index mu1, ..., mu`MUMAX2';
Index i1, ..., i`IMAX2';
Index mu, i, k, k5=0, k6=0, k7=0;

Vector p, p1, ..., p`MAXVEC';
Vector q, q1, q2, q3;

Symbols m, s, t, u, cv, ca;
CF UB, U, VB, V, g, eps, epsM, fprop, phprop, Zprop, Wprop, prop, Fermiprop;

#endif
