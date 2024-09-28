#include <stdio.h>
#include <assert.h>

int is_prime(long long num) {
    if (num <= 1) return 0;
    for (long long i = 2; i * i <= num; i++) {
        if (num % i == 0) return 0;
    }
    return 1;
}

long long largest_prime_factor(long long num) {
    long long i;
    for (i = 2; i * i <= num; i++) {
        if (num % i == 0 && is_prime(i)) {
            num /= i;
            i--;
        }
    }
    return num;
}

int main() {
    long long num = 600851475143;
    long long largest_factor = largest_prime_factor(num);

    printf("The largest prime factor of %lld is %lld\n", num, largest_factor);
    assert(largest_factor == 6857);

    return 0;
}
