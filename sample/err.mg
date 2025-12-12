@c {
    #include <stdio.h>
    #include <stdlib.h>
}

func test() int {
    return 42
}

func main() {
    var x = test()
    if x == 42 { print("works") }
}
