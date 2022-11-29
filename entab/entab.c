#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>

int main() {
    int character;
    int spaces = 0;
    bool newLine = true;
    while ((character = getchar()) != EOF) {
        if (character == '\n') {
            putchar('\n');
            spaces = 0;
            newLine = true;
        } else if (character == '\t') {
            newLine ? (spaces += 4 - (spaces % 4)) : putchar('\t');
        } else if (character == ' ') {
            newLine ? spaces++ : putchar(' ');
        } else {
            if (newLine) {
                while (spaces > 0) {
                    putchar('\t');
                    spaces -= 4;
                }
            }
            putchar(character);
            newLine = false;
            spaces = 0;
        }
    }
    return 0;
}
