#include <stdio.h>
#include <stdlib.h>
int main(void) {
    extern int test();
    test(288230376151711744, 288230376151711744);
    return 0;
}