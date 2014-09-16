/*

A C version for comparison.

Kyumins-iMac:haskell-etudes math4tots$ time gcc -Wall sieve-of-eratosthenes.c && ./a.out 

real    0m0.025s
user    0m0.013s
sys 0m0.010s
1999993

Kyumins-iMac:haskell-etudes math4tots$ gcc -O2 -Wall sieve-of-eratosthenes.c && time ./a.out
1999993

real    0m0.016s
user    0m0.013s
sys 0m0.002s

 */
#include <stdio.h>
int sieve[2000000];

int main() {
    int i;
    for (i = 0; i < 2000000; i++) { sieve[i] = 1; }
    sieve[0] = sieve[1] = 0;
    
    for (i = 2; i*i < 2000000; i++) {
        if (sieve[i]) {
            int j;
            for (j = i * i; j < 2000000; j += i) {
                sieve[j] = 0;
            }
        }
    }
    
    for (i = 2000000 - 1; i >= 2; i--) {
        if (sieve[i]) {
            printf("%d\n", i);
            break;
        }
    }
}
