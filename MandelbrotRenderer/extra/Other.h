/* example.c */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int main(int argc, char *argv[]) {
    //MY CURRENT CALC LOSES OUT ON LAST THREE DIGITS
    extern int MBPixelCalc(long,long);
    if (argc != 3) {
        printf("please input exactly 2 numbers.\n");
        return -1;
    }
    char * fake;
    char * take;
    double first_number;
    double second_number;
    first_number = strtod(argv[1], &fake);
    second_number = strtod(argv[2], &take);

    if (first_number < -2 || first_number > 0.47) {
        printf("X value out of range. please try again.\n");
        return -1;
    }
    if (second_number < -1.12 || second_number > 1.12) {
        printf("Y value out of range. please try again.\n");
        return -1;
    }
    printf("the double type numbers are %f and %f.\n", first_number, second_number);
    //convert command line numbers to long
    //make data type
    //example: -1.12
    // -1 . 14/100
    //-2 -> 2-e (1.9999999)
    long a;
    //make empty 64 bit string to hold bits
    char ret_a[65];
    ret_a[64] = '\0';
    char *faked_a;
    double needed_decimals_a;
    printf("number after it was converted to double is %f\n", first_number);
    if (first_number < 0) {
        ret_a[0] = '1'; // -32
        ret_a[1] = '1'; // 16
        ret_a[2] = '1'; // 8
        ret_a[3] = '1'; // 4
        ret_a[4] = '1'; // 2, first possible value
        if (first_number >= -1) { // under
            ret_a[5] = '1';
            if (first_number <= -1) {
                needed_decimals_a = (first_number * -1) - 1;
            }
            else {
                needed_decimals_a = first_number * -1; //ex: -0.5 -> -0.5 *-1 = 0.5
            }
        }
        else { // between -1 and -2
            ret_a[5] = '0';
            //get numeric value from -2, that is decimals
            //example -1.12345
            needed_decimals_a = (first_number * -1) - 1;
            printf("decimals are %f", needed_decimals_a);
        }
    }
    else if (first_number > 0) {
        printf("number is greater than 0\n");
        //2->7 is decimal
        ret_a[0] = '0'; // 0 (-32)
        ret_a[1] = '0'; // 0 (16)
        ret_a[2] = '0'; // 0 (😎
        ret_a[3] = '0'; // 0 (4)
        ret_a[4] = '0'; // 0 (2)
        ret_a[5] = '0'; // 0
        //decimals are rest of value
        if (first_number >= 1) {
            printf("first number was %f\n", first_number);
            needed_decimals_a = first_number - 1;
            printf("now decimals are %f\n", needed_decimals_a);
        }
        else {
            needed_decimals_a = first_number;
        }
        printf("it was less than one and decimals are %f\n", needed_decimals_a);
    }
    printf("needed decimals for a is %f\n", needed_decimals_a);
    for (int i = 1; i < 59; i++) {
        if (needed_decimals_a - 1/pow(2,i) >= 0) {// if you can subtract number and its still
            printf("current decimals is %f\n", needed_decimals_a);
            needed_decimals_a -= 1/pow(2,i);      //meaning this spot in the decimals bigger than this exponent
            printf("it subtracted %f and now decimals is %f\n", 1/pow(2,i), needed_decimals_a);
            ret_a[5 + i] = '1';                    //for example decimals is .8, first theoretical is 1/2, and .8 -.5 is > 0
        }                                        // so put a 1 at first decimal spot (XXXXXX.1XXXXXXX)
        else {
            ret_a[5 + i] = '0';
        }
        printf("i is up to %i and value is %c\n", i, ret_a[5 + i]);
    }
    a = strtoll(ret_a,&faked_a,2);
    long b;
    //make empty 64 bit string to hold bits
    char ret_b[65];
    ret_b[64] = '\0';
    char *faked_b;
    double needed_decimals_b;
    printf("number after it was converted to double is %f\n", second_number);
    if (second_number < 0) {
        ret_b[0] = '1'; // -32
        ret_b[1] = '1'; // 16
        ret_b[2] = '1'; // 8
        ret_b[3] = '1'; // 4
        ret_b[4] = '1'; // 2, first possible value
        if (second_number > -1) { // under
            ret_b[5] = '1';
            needed_decimals_b = second_number * -1; //ex: -0.5 -> -0.5 *-1 = 0.5
        }
        else { // between -1 and -2
            ret_b[5] = '0';
            needed_decimals_b = (second_number * -1) - 1;
        }
    }
    else if (second_number > 0) {
        printf("number is greater than 0\n");
        ret_b[0] = '0'; // 0 (-32)
        ret_b[1] = '0'; // 0 (16)
        ret_b[2] = '0'; // 0 (😎
        ret_b[3] = '0'; // 0 (4)
        ret_b[4] = '0'; // 0 (2)
        if (second_number >= 1) { // +1? , first possible value
            ret_b[5] = '1'; // 1
            //decimals are 1 - num

            needed_decimals_b = second_number - 1;
            printf("it was greater than one and decimals are %f\n", needed_decimals_b);
        }
        else {
            ret_b[5] = '0'; // 0
            //decimals are rest of value
            needed_decimals_b = second_number;
            printf("it was less than one and decimals are %f\n", needed_decimals_b);
        }
    }
    //decimal part
    //CHECK ON REPEATING NUMBERS
    //printf("needed decimals is %f\n", needed_decimals_b);
    for (int i = 1; i < 59; i++) {
        if (needed_decimals_b - (1/pow(2,i)) >= 0) {// if you can subtract number and its still
            //printf("current decimals is %f\n", needed_decimals_b);
            needed_decimals_b -= (1/pow(2,i));      //meaning this spot in the decimals bigger than this exponent
            //printf("it subtracted %f and now decimals is %f\n", 1/pow(2,i), needed_decimals_b);
            ret_b[5 + i] = '1';                    //for example decimals is .8, first theoretical is 1/2, and .8 -.5 is > 0
        }                                        // so put a 1 at first decimal spot (XXXXXX.1XXXXXXX)
        else {
            ret_b[5 + i] = '0';
        }
        printf("i is up to %i and value is %c\n", i, ret_b[5 + i]);
    }
    b = strtoll(ret_b,&faked_b,2);
    printf("first number given was %f and its bits are %s\n", first_number, ret_a);
    printf("first number given was %f and its bits are %s\n", second_number, ret_b);
    printf("It took %i iterations.\n", MBPixelCalc(a,b));
    return 0;
}