
* Process: Running

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;
#include SquareAmplitude.h

Symbols e, Mmuon, Melec;
Vectors k, kf1, kf2;
Symbols MasterProp, fx;


Local MLO = (e^2) * (UB(i1, p3, Melec ) * g(i1, i2, mu1) * U(i2, p1, Melec))
            * phprop(mu1, mu2, q)
            * (UB(i3, p4, Mmuon) * g(i3, i4, mu2) * U(i4, p2, Mmuon));

Local MNLO = -1* (e^4) 
             * (UB(i1, p3, Melec) * g(i1, i2, mu1) * U(i2, p1, Melec)) 
             * phprop(mu1, mu3, q) 
             * g(i11, i12, mu3) * fprop(i12, i13, kf1, Melec) 
             * g(i13, i14, mu4) * fprop(i14, i11, kf2, Melec)
             * phprop(mu4, mu2, q)
             * (UB(i7, p4, Mmuon) * g(i7, i8, mu2) * U(i8, p2, Mmuon));

Local MTotal = MLO+MNLO;
#call squareamplitude(MLO, MsqLO)
#call squareamplitude(MNLO, MsqNLO)
#call squareamplitude(MTotal, MsqTotal)
.sort
Multiply 1/4;
.sort
Drop drop MsqNLO, MsqTotal, MLO, MNLO, MTotal ;
Local MInt = MsqTotal - MsqLO - MsqNLO;
.sort

* --- KINEMATIC DEFINITIONS: VACUUM POLARIZATION ---
* q  = p1 - p3           : Momentum transfer between electron and muon lines
* t  = q.q               : Mandelstam variable t (photon momentum squared)
* k  = loop momentum     : Integration variable for the fermion loop
* kf1 = k                : Momentum of the first fermion in the bubble
* kf2 = k - q            : Momentum of the second fermion in the bubble
* Replace the propagator function
id prop(q.q) = 1/t;
id prop(-Melec^2 + kf1.kf1) * prop(-Melec^2 + kf2.kf2) = MasterProp;
.sort
* kf1 effectively becomes fx * q
id kf1.p1 = fx * (t/2);
id kf1.p2 = fx * (-t/2);
id kf1.p3 = fx * (-t/2);
id kf1.p4 = fx * (t/2);
* kf2 effectively becomes (fx - 1) * q
id kf2.p1 = (fx - 1) * (t/2);
id kf2.p2 = (fx - 1) * (-t/2);
id kf2.p3 = (fx - 1) * (-t/2);
id kf2.p4 = (fx - 1) * (t/2);
* Internal loop propagator dot product
id kf1.kf2 = fx * (fx - 1) * t;
.sort
id Melec = 0;
id Mmuon = 0;
* --- MASSLESS APPROXIMATION ---
#call Mandelstam2To2(p1,p2,p3,p4,0,0,0,0)
.sort
id u = -s -t;
.sort

* Print 
Format;
Print+s MInt;
Print+s MsqLO;
* Save to file 
Format C;
#write <RunningLO.txt> "%e;", MsqLO;
#write <Running.txt> "%e;", MInt;
.sort

.end
