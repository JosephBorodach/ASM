#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
    //extern long MBPixelCalc(long, long);
    //extern double MBPixelCalc(double, double);
    extern int MBPixelCalc(double, double);
    if (argc != 3) {
        return -1;
    }
    //double x = atof(argv[1]);
    //double y = atof(argv[2]);
    double x = 1.0;
    double y = -1.12;
    //if (x < -2 || x > 0.47 || y < -1.12 || y > 1.12) {
    //    return -1;
    //}
    //printf("MBPixelCalc() returned %f.\n", MBPixelCalc(x, y));
    printf("MBPixelCalc() returned %d.\n", MBPixelCalc(x, y));
    return 0;
}