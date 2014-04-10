#include <stdlib.h>
#include <stdio.h>
#include <math.h>

double A1 = 0.0765;
double A2 = 2.0997;
double A3 = 2.9779;
double A4 = 2.6524;

double f (double x){
    return A1*(x - A2)/(exp(A3*(x- A4)) + 1.0);
}

int main() {
    
    int i;
    double lspc = 5.8;
    //double lspc = 6.49;
    double aa_to_au = 0.52917720859;
    double scale;
    scale = 8.0*atan(1.0)*aa_to_au/lspc;
    scale *= scale;
    
    for (i=0; i<12; i++)  printf("%d\t%.2lf\n", i, 2.0*f(scale*(double)i));
    
    exit(EXIT_SUCCESS);
}
