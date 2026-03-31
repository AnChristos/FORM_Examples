* Process: e+ e- -> mu+ mu-
Indices mu, nu, mu1, nu1;
Symbols s, t, u, e, pi, alpha, costh;
Vectors p1, p2, p3, p4;

* 1. Amplitude Squared (Diagrammatica Trace Rules)
Local Msq = (e^4 / s^2) * d_(mu, mu1) * d_(nu, nu1) * (g_(1, p2) * g_(1, mu) * g_(1, p1) * g_(1, nu)) *
    (g_(2, p3) * g_(2, mu1) * g_(2, p4) * g_(2, nu1));

Local dSigma = (1 / (64 * pi^2 * s)) * Msq;

tracen, 1;
tracen, 2;
contract; 

* 2. Physics & Normalization
id e^4 = 16 * pi^2 * alpha^2;
multiply 1/4; * Spin averaging (1/2 * 1/2)

* 3. Kinematics (Massless Limit)
id p1.p1 = 0; id p2.p2 = 0; id p3.p3 = 0; id p4.p4 = 0;
id p1.p2 = s/2; id p3.p4 = s/2;
id p1.p3 = -t/2; id p2.p4 = -t/2;
id p1.p4 = -u/2; id p2.p3 = -u/2;

* 4. Angular dependency
id t = -s/2 * (1 - costh);
id u = -s/2 * (1 + costh);

bracket alpha, s, costh;
Print;
.end
