
#include <stdio.h>
int main() {
    int arr[] = {1, 2, 3, 4, 5};
    printf("len(arr) = %lu\n", sizeof(arr) / sizeof(arr[0]));

    printf("sizeof(arr) = %zu\n", sizeof(arr));
    printf("sizeof(arr[0]) = %zu\n", sizeof(arr[0]));
    printf("sizeof(arr)/sizeof(arr[0]) = %zu\n", sizeof(arr) / sizeof(arr[0]));
    return 0;
    return 0;
}
