#include <stdio.h>
#include <stdlib.h>

#include "test/testLib_extern.h"

int main(int argc, char** argv)
{
    unsigned i;

    print("[Init value]\r\n");
    print("g_uc_test_var = %c\r\n",     g_uc_test_var);
    print("g_us_test_var = %u\r\n",     g_us_test_var);
    print("g_ui_test_var = %u\r\n",     g_ui_test_var);
    print("g_ul_test_var = %lu\r\n",    g_ul_test_var);
    print("\r\n");

    print("g_sc_test_var = %c\r\n",     g_sc_test_var);
    print("g_ss_test_var = %d\r\n",     g_ss_test_var);
    print("g_si_test_var = %d\r\n",     g_si_test_var);
    print("g_sl_test_var = %ld\r\n",    g_sl_test_var);
    print("\r\n");
    print("\r\n");

    for(i = 0; i < 10; i++)
    {
        g_ui_test_var++;
        g_ui_test_var++;
        g_ui_test_var++;
        g_ui_test_var++;

        g_si_test_var++;
        g_si_test_var++;
        g_si_test_var++;
        g_si_test_var++;
    }

    print("pAfter value]\r\n");
    print("g_uc_test_var = %c\r\n",     g_uc_test_var);
    print("g_us_test_var = %u\r\n",     g_us_test_var);
    print("g_ui_test_var = %u\r\n",     g_ui_test_var);
    print("g_ul_test_var = %lu\r\n",    g_ul_test_var);
    print("\r\n");

    print("g_sc_test_var = %c\r\n",     g_sc_test_var);
    print("g_ss_test_var = %d\r\n",     g_ss_test_var);
    print("g_si_test_var = %d\r\n",     g_si_test_var);
    print("g_sl_test_var = %ld\r\n",    g_sl_test_var);
    print("\r\n");
    print("\r\n");

	return 0;
}
