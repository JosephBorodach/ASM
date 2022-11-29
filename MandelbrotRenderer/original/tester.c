#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
    extern int MBPixelCalc(long, long);
    if (argc != 3) {
        return -1;
    }
    double x, y;
    sscanf(argv[1], "%lf", &x), sscanf(argv[2], "%lf", &y);
    if (x < -2 || x > 0.47 || y < -1.12 || y > 1.12) {
        return -1;
    }
    long a, b;
    char x_bits[65], y_bits[65];
    x_bits[64] = '\0', y_bits[64] = '\0';
    for (int i = 0; i < 2; i++) {
        double z, decimals;
        if (i == 0) { 
            z = x;
        } else {
            z = y;
        }
        char c;
        if (z > 0) {
            c = '0';
            if (z >= 1) {
                decimals = z - 1;
            } else {
                decimals = z;
            }
        } else {
            c = '1';
            if (z >= -1) {
                decimals = 1 + z;
            }
            else {
                decimals = (z * -1) - 1;
            }
        }
        char rets[65];
        rets[64] = '\0';
        for (int idx = 0; idx < 64; idx++) {
            if (idx < 6) {
                rets[idx] = c;
            } else {
                double t = 2;
                for (int itr = 1, e = (idx - 5); itr < e; itr++) {
                    t *= 2;
                }
                double d = 1 / t;
                c = '0';
                if (decimals - d >= 0) {
                    decimals -= d;
                    c = '1';
                }
                rets[idx] = c;
            }
        }
        if (z < -1) {
            rets[5] = '0';
        } else if (z >= 1) {
            rets[5] = '1';
        }
        if (i == 0) {
            x = z;
            for (int i = 0; i < 64; i++) {
                x_bits[i] = rets[i];
            }
            char *fake;
            a = strtoll(x_bits, &fake, 2);
        }
        if (y == x || i == 1) {
            y = z;
            for (int i = 0; i < 64; i++) {
                y_bits[i] = rets[i];
            }
            char *fake;
            b = strtoll(y_bits, &fake, 2);
            break;
        }
    }
    printf("%f & %s\n", x, x_bits);
    printf("%f & %s\n", y, y_bits);
    printf("a: %ld\n", a);
    printf("b: %ld\n", b);
    printf("MBPixelCalc() returned %d.\n", MBPixelCalc(a,b));
    return 0;
}
// 1) Uses a for loop to avoid duplicating code:
//      The first iteration addresses x and the second address y
//      The 1st and 2nd arguments accordingly.
// 2) The for loop will terminate early if the variables passed in are the same
//      In which case, y's values are simply set to x's values
//trying to find a work around strtoll
//a = 0;
//for (int i = 0; i < 64; i++) {
//    a = (a * 10) + (x_bits[i] - '0');
//}
// gcc -g tester.c MBPixelCalc.s -o tester
// ./tester 0.25 -1.25