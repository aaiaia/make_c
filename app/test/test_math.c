#include <stdio.h>
#include <math.h>

#include "test/testLib_math.h"

int main(int argc, char** argv)
{
    double a = 3.0;
    double b = 4.0;
    double c;

    double pow3_a;
    double pow3_b;
    double pow3_c;

    c = testGetRightTriHypo(a, b);

    printf("a = %f\r\n", a);
    printf("b = %f\r\n", b);
    printf("c = %f\r\n", c);
    printf("\r\n");

    pow3_a = pow(a, 3.0);
    pow3_b = pow(b, 3.0);
    pow3_c = pow(c, 3.0);

    printf("pow3_a = %f\r\n", pow3_a);
    printf("pow3_b = %f\r\n", pow3_b);
    printf("pow3_c = %f\r\n", pow3_c);
    printf("\r\n");

    return 0;
}
