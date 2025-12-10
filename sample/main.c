#include <stdio.h>
int add(int a, int b) { return a + b; }
int main() {
    int x = add(32, 2);
    printf("x = %d\n", x);
    return 0;
}
