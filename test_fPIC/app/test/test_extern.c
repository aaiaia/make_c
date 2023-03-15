#include <stdio.h>
#include <stdlib.h>

#include "test/testLib_extern.h"

int main(int argc, char** argv)
{
    unsigned i;

    printf("[Init value]\r\n");
    printf("g_uc_test_var = %c\r\n",    g_uc_test_var);
    printf("g_us_test_var = %u\r\n",    g_us_test_var);
    printf("g_ui_test_var = %u\r\n",    g_ui_test_var);
    printf("g_ul_test_var = %lu\r\n",   g_ul_test_var);
    printf("\r\n");

    printf("g_sc_test_var = %c\r\n",    g_sc_test_var);
    printf("g_ss_test_var = %d\r\n",    g_ss_test_var);
    printf("g_si_test_var = %d\r\n",    g_si_test_var);
    printf("g_sl_test_var = %ld\r\n",   g_sl_test_var);
    printf("\r\n");
    printf("\r\n");

    for(i = 0; i < 10; i++)
    {
        g_uc_test_var++;
        g_us_test_var++;
        g_ui_test_var++;
        g_ul_test_var++;

        g_sc_test_var++;
        g_ss_test_var++;
        g_si_test_var++;
        g_sl_test_var++;
    }

    printf("[Incese in 'main()']\r\n");
    printf("g_uc_test_var = %c\r\n",    g_uc_test_var);
    printf("g_us_test_var = %u\r\n",    g_us_test_var);
    printf("g_ui_test_var = %u\r\n",    g_ui_test_var);
    printf("g_ul_test_var = %lu\r\n",   g_ul_test_var);
    printf("\r\n");

    printf("g_sc_test_var = %c\r\n",    g_sc_test_var);
    printf("g_ss_test_var = %d\r\n",    g_ss_test_var);
    printf("g_si_test_var = %d\r\n",    g_si_test_var);
    printf("g_sl_test_var = %ld\r\n",   g_sl_test_var);
    printf("\r\n");
    printf("\r\n");

    testIncreaseTestVar();
    printf("[Incese in 'testIncreaseTestVar()']\r\n");
    printf("g_uc_test_var = %c\r\n",    g_uc_test_var);
    printf("g_us_test_var = %u\r\n",    g_us_test_var);
    printf("g_ui_test_var = %u\r\n",    g_ui_test_var);
    printf("g_ul_test_var = %lu\r\n",   g_ul_test_var);
    printf("\r\n");

    printf("g_sc_test_var = %c\r\n",    g_sc_test_var);
    printf("g_ss_test_var = %d\r\n",    g_ss_test_var);
    printf("g_si_test_var = %d\r\n",    g_si_test_var);
    printf("g_sl_test_var = %ld\r\n",   g_sl_test_var);
    printf("\r\n");
    printf("\r\n");

    testDecreaseTestVar();
    printf("[Incese in 'testIncreaseTestVar()']\r\n");
    printf("g_uc_test_var = %c\r\n",    g_uc_test_var);
    printf("g_us_test_var = %u\r\n",    g_us_test_var);
    printf("g_ui_test_var = %u\r\n",    g_ui_test_var);
    printf("g_ul_test_var = %lu\r\n",   g_ul_test_var);
    printf("\r\n");

    printf("g_sc_test_var = %c\r\n",    g_sc_test_var);
    printf("g_ss_test_var = %d\r\n",    g_ss_test_var);
    printf("g_si_test_var = %d\r\n",    g_si_test_var);
    printf("g_sl_test_var = %ld\r\n",   g_sl_test_var);
    printf("\r\n");
    printf("\r\n");

	return 0;
}
