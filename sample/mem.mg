@c {
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
}

func test() {
    // Allocate memory
    var ptr = getmem(100)
    
    @c {
        // Use it directly in C
        char* p = (char*)ptr;
        strcpy(p, "Test string");
        printf("Allocated: %s\n", p);
    }
    
    // Free it
    freemem(ptr)
}

func main() {
    test()
}
