@c {#include <stdio.h>}

@c {
    // Function declaration
    int add(int a, int b);
    
    // Function definition  
    int add(int a, int b) {
        return a + b;
    }
}

func main() {
    var result = 0
    @c {
        result = add(1, 2);
    }
    print("%d\n", result)
}
