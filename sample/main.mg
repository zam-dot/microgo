@c { #include <stdio.h> }

func add(a: int, b: int) int {
    return a + b
}

func main() {
    var x : int = add(32, 2)
    print("x = %d\n", x)
}
