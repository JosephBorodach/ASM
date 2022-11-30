#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
    extern int MBPixelCalc(long, long);
    if (argc != 3) {
        return -1;
    }
    double x = atof(argv[1]);
    double y = atof(argv[2]);
    if (x < -2 || x > 0.47 || y < -1.12 || y > 1.12) {
        return -1;
    }
    long shift1 =  1;
    long shift2 =  1;
    shift1 = shift1 << 58;
    shift2 = shift2 << 58;
    long a = shift1 * x;
    long b = shift2 * y;
    printf("a: %ld\n", a);
    printf("b: %ld\n", b);
    printf("MBPixelCalc() returned %d.\n", MBPixelCalc(a, b));
    return 0;
}