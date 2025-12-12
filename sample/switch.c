
#include <stdio.h>
void test() {
    int x = 2;
    switch (x) {
        case 1:  printf("one"); break;
        case 2:
        case 3:  printf("two or three"); break;
        default: printf("other"); break;
    }
}
int main() {
    test();
    return 0;
}
