#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>

int main() {
    int spaces = 0;
    int character;
    bool newLine = true;
    // while not at the end of the file
    while ((character = getchar()) != EOF) {
        // new character line
        if (character == '\n') {
            putchar('\n');
            spaces = 0;
            newLine = true;
        }
        else if (!newLine && isblank(character)) {
            putchar(' ');
        }
        else if (isblank(character)) {
            spaces++;
        }
        else if (character == '\t') {
            putchar('\t');
        }
        else {
            if (newLine) {
                int counter = spaces;
                while (counter > 0) {
                    putchar('\t');
                    counter -= 4;
                }
            }
            putchar(character);
            newLine = false;
            spaces = 0;
        }
    }
    return 0;
}
