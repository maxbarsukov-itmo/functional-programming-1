#include <stdio.h>
#include <assert.h>

int main() {
    int size = 1001;
    int sum = 1;
    int num = 1;
    int increment = 2;

    for (int i = 3; i <= size; i += 2) {
        for (int j = 0; j < 4; j++) {
            num += increment;
            sum += num;
        }
        increment += 2;
    }

    printf("The sum of the numbers on the diagonals is %d\n", sum);
    assert(sum == 669171001);

    return 0;
}
