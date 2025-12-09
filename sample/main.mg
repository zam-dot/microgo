@c { #include <stdio.h> }

// Sum 1 to 10
func main() {
    for (var i = 0; i < 5; i = i + 1) {
        for (var j = 0; j < 5; j = j + 1) {
            print("%d, %d\n", i, j);
        }
    }
}
