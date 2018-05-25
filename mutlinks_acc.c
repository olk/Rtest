#include <R.h>

int total;

int procpairs(int i, int * m, int n) {
    int sum = 0;
//#pragma acc parallel
//#pragma acc loop gang worker vector
    for ( int j = i + 1; j < n; ++j) {
        for ( int k = 0; k < n; ++k) {
            sum += m[n * k + i] * m[n * k + j];
        }
    }
    return sum;
}

void mutlinks( int * m, int * n, double * mlmean) {
    int nval = * n;
    total = 0;
#pragma acc kernels
    {
        int mysum = 0;
        for ( int i = 0; i < nval; ++i) {
            mysum += procpairs( 0, m, nval);
        }
#pragma acc atomic
        total += mysum;
    }
    int divisor = nval * (nval - 1)/2;
    * mlmean = ((float)total)/divisor;
}
