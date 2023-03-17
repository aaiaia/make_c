#include <math.h>
#include "test/testLib_math.h"

int testAddInt(int a , int b)
{
    return a + b;
}

double testGetRightTriHypo(double a, double b)
{
    double c_pow;
    double c;

    c_pow = pow(a, 2.0) + pow(b, 2.0);
    c =  sqrt(c_pow);

    return c;
}
