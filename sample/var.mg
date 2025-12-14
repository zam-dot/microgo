@c {
    #include <stdio.h>
}

func say(msg: string) {
    print("%s\n", msg)
}

func main() {
    var ptr* = malloc(100)
    defer freemem(ptr)
    defer say("See you")
    
    say("Hello")
}
