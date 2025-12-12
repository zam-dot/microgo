@c { 
    #include <stdio.h> 
    #include <stdlib.h>
}

func test() {
    var x = 2
    switch(x) {
    case 1:    print("one")
    case 2, 3: print("two or three")
    default:   print("other")
    }
}

func main() {
    test()
}
