
* Process: e+ e- -> mu+ mu-
#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;
Symbol d,ep , Scale;
Dimension d;
#include FeynHelpers.h
CF log;

load QEDBubble.sav;
Local QEDBubble = BubbleToStore;
.sort
Drop BubbleToStore;
.sort
Print +s QEDBubble;
.sort

* Physical constants
Symbols e, pi, alpha, x;

Local M = (e^2) * (VB(i1, p2, 0) * g(i1, i2, mu1) * U(i2, p1, 0)) 
                * ( phprop(mu1, mu2, q) + QEDBubble / ((q.q)*(q.q)) )
                * (UB(i3, p3, 0) * g(i3, i4, mu2) * V(i4, p4, 0));
#call squareamplitude(M, Msq)
.sort
* Spin averaging (1/2 * 1/2)
multiply 1/4; 
* coupling
id e^4 = 16 * pi^2 * alpha^2;
* Drop higher-order terms (NNLO)
id alpha^4 = 0;
.sort
* propagator handling
id prop(x?) = (x)^-1;
id (q.q)^-1 = (s)^-1;
repeat;
    id q = p1 + p2;
endrepeat;
* Kinematics 
#call Mandelstam2To2(p1,p2,p3,p4,0,0,0,0)
.sort
* Vector integral coefficient
id B1(q.q,Melec,Melec) = -1/2 * B0(s,Melec,Melec);
id B11(q.q,Melec,Melec) = (A0(Melec) - 2*B00(s,Melec,Melec)) / (2*s);
id B00(q.q,Melec,Melec) = (A0(Melec) + (2*Melec^2 - s/2)*B0(s,Melec,Melec)) / (2*(d-1));
id B0(q.q,Melec,Melec) = B0(s,Melec,Melec);
.sort
id A0(Melec) = Melec^2 * (ep^-1 - log(Melec^2/Scale^2) + 1);
id B0(s,Melec,Melec) = ep^-1 - log(s/Scale^2) + 2;
.sort
id d = 4 - 2*ep;
id ( - 2 + 2*d)^-1 = 1/6 * (1 + (2/3)*ep);
id ( - 2 + 2*d)^-2 = 1/36 * (1 + (4/3)*ep);
.sort
* cleanup (but not the log M^2 or ep^1 pole)
id Melec^2*s^-1 = 0;
id ep^2 = 0;
id ep = 0;
.sort
bracket alpha, pi, s;
Print +s Msq;

.end
