#include <stdio.h>
int main() {
    for (int i = 0; i < 5; i = i + 1) {
        for (int j = 0; j < 5; j = j + 1) {
            printf("%d, %d\n", i, j);
        }
    }
    return 0;
}
