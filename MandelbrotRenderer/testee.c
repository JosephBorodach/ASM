#include <stdio.h>
#include <stdlib.h>
int main(void) {
    extern int test();
    test(9223372036854775807, 9223372036854775807);
    return 0;
}