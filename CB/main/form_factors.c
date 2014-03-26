#include <stdlib.h>
#include <stdio.h>
#include <math.h>

double f (double x){
    return 0.0765*(x - 2.0997)/(exp(2.9779*(x- 2.6524)) + 1.0);
}

int main(){
    
    int i;
    for (i=1; i<12; i++)
        printf("%d\t%.7lf\n", i, f((double)i));
    
    exit(EXIT_SUCCESS);
}
