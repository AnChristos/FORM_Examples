#procedure PassarinoVeltmanRank1(k1, k2, q, m1,m2)
*-------------------------------------------------------------------------*
* Procedure: PassarinoVeltmanRank1
* Arguments: 
* k1, k2 : Internal (loop) momenta
* q      : External momentum transfer (q = k1 - k2)
* m1,m2  : Masses of the loop particles
*-------------------------------------------------------------------------*
*
* Map denominators to symbolic labels
id prop( - `m1'^2 + `k1'.`k1' ) = 1/Den0;
id prop( - `m2'^2 + `k2'.`k2' ) = 1/Den1;

* Linearize k2 in terms of k1 and q
id `k2' = `k1' - `q';
.sort:linearize-`k1';

* Scalarize dot products using the labels
id `k1'.`k1' = Den0 + `m1'^2;
.sort:scalarize-k1;

* Tensor Reduction 
id `k1'.v1?!{`k1'} = (`k1'.`q') * (v1.`q') * prop(`q'.`q');
id `k1'(mu1?)      = `k1'.`q' * `q'(mu1) * prop(`q'.`q');
.sort:tensor-reduction;

id `k1'.`q'  = 1/2*Den0 - 1/2*Den1 + 1/2*`q'.`q' + 1/2*`m1'^2 - 1/2*`m2'^2;
.sort:scalarize-q;

* Numerator/Denominator Cancellation
repeat;
    id Den0 * (1/Den0) = 1;
    id Den1 * (1/Den1) = 1;
endrepeat;

* Substitute Master Integrals
id (1/Den0) * (1/Den1) = B0(`q'.`q', `m1'^2, `m2'^2);
id 1/Den0 = A0(`m1'^2);
id 1/Den1 = A0(`m2'^2);
.sort:master-integral;

* Final Clean-up
id Den0 * B0(`q'.`q', `m1'^2, `m2'^2) = A0(`m2'^2);
id Den1 * B0(`q'.`q', `m1'^2, `m2'^2) = A0(`m1'^2);
id Den0 * A0(`m1'^2) = 0;
id Den1 * A0(`m2'^2) = 0;
.sort:cleanup;

#endprocedure