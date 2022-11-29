// https://github.com/mrmcsoftware/FractalAsm
// https://en.wikipedia.org/wiki/Plotting_algorithms_for_the_Mandelbrot_set#Unoptimized_na%C3%AFve_escape_time_algorithm
#include <stdio.h>
#include <stdlib.h>
#include "tester.c"
//extern int MBPixelCalc(long, long);

int main(void) {
    tester(./tester 1.0 1.0);
    long vals = 0;
    printf("%ld\n", vals);
    /*
    int x = 0;
    int y = 0;
    int x0 = (x); // scaled x coordinate of pixel (scaled to lie in the Mandelbrot X scale (-2.00, 0.47))
    int y0 = (y); // scaled y coordinate of pixel (scaled to lie in the Mandelbrot Y scale (-1.12, 1.12))
    for (int i = 0; (x * x + y * y) <= (2 * 2) & i < 1000; i++) {
        int temp = (x * x) - (y * y) + x0;
        y = (2 * x * y) + y0;
        x = temp;
    }
    */
    return 0;
}

/*
gcc mandelbrot.c tester.c -DEXTERNAL_DRIVER
*/

/*
#include <stdio.h>
int main(int argc, char *argv[]) {
    char * fake;
    char * take;
    double x;
    double y;
    // takes string & converts to double
    x = strtod(argv[1], &fake);
    y = strtod(argv[2], &take);
    for each pixel (Px, Py) {
        x0 := scaled x coordinate of pixel (scaled to lie in the Mandelbrot X scale (-2.00, 0.47))
        y0 := scaled y coordinate of pixel (scaled to lie in the Mandelbrot Y scale (-1.12, 1.12))
        x := 0.0
        y := 0.0
        iteration := 0
        max_iteration := 1000
        while (x*x + y*y ≤ 2*2 AND iteration < max_iteration) do
            xtemp := x*x - y*y + x0
            y := 2*x*y + y0
            x := xtemp
            iteration := iteration + 1
        color := palette[iteration]
        plot(Px, Py, color)
    }
}
*/
/*
// C++ implementation for mandelbrot set fractals
#include <graphics.h>
#include <stdio.h>
#define MAXCOUNT 30
// Driver code
int main() {
    // gm is Graphics mode which is
    // a computer display mode that
    // generates image using pixels.
    // DETECT is a macro defined in
    // "graphics.h" header file
    int gd = DETECT, gm, errorcode;

    float left, top, xside, yside;

    // setting the left, top, xside and yside
    // for the screen and image to be displayed
    left = -1.75;
    top = -0.25;
    xside = 0.25;
    yside = 0.45;
    char driver[] = "";

    // initgraph initializes the
    // graphics system by loading a
    // graphics driver from disk
    initgraph(&gd, &gm, driver);

    // Function calling
    float xscale, yscale, zx, zy, cx, tempx, cy;
    int x, y, i, j;
    int maxx, maxy, count;

    // getting maximum value of x-axis of screen
    maxx = getmaxx();

    // getting maximum value of y-axis of screen
    maxy = getmaxy();

    // setting up the xscale and yscale
    xscale = xside / maxx;
    yscale = yside / maxy;

    // calling rectangle function
    // where required image will be seen
    rectangle(0, 0, maxx, maxy);

    // scanning every point in that rectangular area.
    // Each point represents a Complex number (x + yi).
    // Iterate that complex number
    for (y = 1; y <= maxy - 1; y++) {
        for (x = 1; x <= maxx - 1; x++)
        {
            // c_real
            cx = x * xscale + left;

            // c_imaginary
            cy = y * yscale + top;

            // z_real
            zx = 0;

            // z_imaginary
            zy = 0;
            count = 0;

            // Calculate whether c(c_real + c_imaginary) belongs
            // to the Mandelbrot set or not and draw a pixel
            // at coordinates (x, y) accordingly
            // If you reach the Maximum number of iterations
            // and If the distance from the origin is
            // greater than 2 exit the loop
            while ((zx * zx + zy * zy < 4) && (count < MAXCOUNT))
            {
                // Calculate Mandelbrot function
                // z = z*z + c where z is a complex number

                // tempx = z_real*_real - z_imaginary*z_imaginary + c_real
                tempx = zx * zx - zy * zy + cx;

                // 2*z_real*z_imaginary + c_imaginary
                zy = 2 * zx * zy + cy;

                // Updating z_real = tempx
                zx = tempx;

                // Increment count
                count = count + 1;
            }

            // To display the created fractal
            putpixel(x, y, count);
        }
    }

    getch();

    // closegraph function closes the
    // graphics mode and deallocates
    // all memory allocated by
    // graphics system
    closegraph();
    return 0;
}
*/
/*
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>

int main(int argc, char* argv[])
{
    if (argc != 8) {
        printf("Usage:   %s <xmin> <xmax> <ymin> <ymax> <maxiter> <xres> <out.ppm>\n", argv[0]);
        printf("Example: %s 0.27085 0.27100 0.004640 0.004810 1000 1024 pic.ppm\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    const double xmin = atof(argv[1]);
    const double xmax = atof(argv[2]);
    const double ymin = atof(argv[3]);
    const double ymax = atof(argv[4]);

    const uint16_t maxiter = (unsigned short)atoi(argv[5]);

    const int xres = atoi(argv[6]);
    const int yres = (xres*(ymax-ymin))/(xmax-xmin);

    const char* filename = argv[7];

    // Open the file and write the header.
    FILE * fp = fopen(filename,"wb");
    char *comment="# Mandelbrot set"; //comment should start with #

    // write ASCII header to the file
    fprintf(fp,
            "P6\n# Mandelbrot, xmin=%lf, xmax=%lf, ymin=%lf, ymax=%lf, maxiter=%d\n%d\n%d\n%d\n",
            xmin, xmax, ymin, ymax, maxiter, xres, yres, (maxiter < 256 ? 256 : maxiter));

    // Precompute pixel width and height.
    double dx=(xmax-xmin)/xres;
    double dy=(ymax-ymin)/yres;

    double x, y; // Coordinates of the current point in the complex plane.
    double u, v; // Coordinates of the iterated point.
    int i,j; // Pixel counters
    int k; // Iteration counter
    for (j = 0; j < yres; j++) {
        y = ymax - j * dy;
        for(i = 0; i < xres; i++) {
            double u = 0.0;
            double v= 0.0;
            double u2 = u * u;
            double v2 = v*v;
            x = xmin + i * dx;
            // iterate the point
            for (k = 1; k < maxiter && (u2 + v2 < 4.0); k++) {
                v = 2 * u * v + y;
                u = u2 - v2 + x;
                u2 = u * u;
                v2 = v * v;
            };
            // compute  pixel color and write it to file
            if (k >= maxiter) {
                // interior
                const unsigned char black[] = {0, 0, 0, 0, 0, 0};
                fwrite (black, 6, 1, fp);
            }
            else {
                // exterior
                unsigned char color[6];
                color[0] = k >> 8;
                color[1] = k & 255;
                color[2] = k >> 8;
                color[3] = k & 255;
                color[4] = k >> 8;
                color[5] = k & 255;
                fwrite(color, 6, 1, fp);
            };
        }
    }
    fclose(fp);
    return 0;
}
 */