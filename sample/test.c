
#include <stdio.h>
#include <stdlib.h>
int main() {
    int arr[] = {1, 2, 3};
    for (int i = 0; i < sizeof(arr) / sizeof(arr[0]); i = i + 1) {
        printf("%d", i);
    }
    return 0;
}
