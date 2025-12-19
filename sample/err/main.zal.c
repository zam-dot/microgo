
#include <stdio.h>
#include <stdlib.h>
int divide(int a, int b, char **error_out) {
    *error_out = NULL;
    if (b == 0) {
        *error_out = "division by zero";
        return 0;
    }
    *error_out = NULL;
    return a / b;
}
int main() {
    int, char *result, err = divide(10, 2);
    if (err != NULL) {
        printf("Error: %s\n", err);
    } else {
        printf("Result: %d\n", result);
    }
    int, char *result2, err2 = divide(10, 0);
    if (err2 != NULL) {
        printf("Error: %s\n", err2);
    }
    return 0;
}
