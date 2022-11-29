#include <stdio.h>
#include <stdlib.h>
int main(void) {
    extern int test();
    test();
    return 0;
}