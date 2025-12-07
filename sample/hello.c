#include <stdio.h>


// Function declaration
int add(int a, int b);

// Function definition
int add(int a, int b) { return a + b; }

int main() {
    int result = 0;

    result = add(1, 2);
    printf("%d\n", result);
    return 0;
}
