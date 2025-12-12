
#include <stdio.h>
#include <stdlib.h>
int test() { return 42; }
int main() {
    int x = test();
    if (x == 40) {
        printf("works");
    }
    return 0;
}
