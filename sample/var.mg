@c {
    #include <stdio.h>
}

func main() {
    arr := [1, 2, 3, 4, 5]
    
    // Print what len generates
    print("len(arr) = %d\n", len(arr))
    
    // Also print sizeof manually
    @c {
        printf("sizeof(arr) = %zu\n", sizeof(arr));
        printf("sizeof(arr[0]) = %zu\n", sizeof(arr[0]));
        printf("sizeof(arr)/sizeof(arr[0]) = %zu\n", sizeof(arr)/sizeof(arr[0]));
    }
    
    return 0
}
