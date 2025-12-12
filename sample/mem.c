
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void test() {
    void *ptr = malloc(100);

    // Use it directly in C
    char *p = (char *)ptr;
    strcpy(p, "Test string");
    printf("Allocated: %s\n", p);
    free(ptr);
}
int main() {
    test();
    return 0;
}
