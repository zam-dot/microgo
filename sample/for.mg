@c {
    #include <stdio.h>
}

func main() {
    arr := [100, 200, 300]
    for i, v in arr {
        print("arr[%d] = %d\n", i, v)
    }

    arr2 := [10, 20, 30]
    for v in arr2 {
        print("value = %d\n", v)
    }

    for i in 0..5 {
        print("%d\n", i)
    }
}
