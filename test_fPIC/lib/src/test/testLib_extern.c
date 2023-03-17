#include "test/testLib_extern.h"

unsigned char   g_uc_test_var = '0' ;
unsigned short  g_us_test_var = 10  ;
unsigned int    g_ui_test_var = 20U ;
unsigned long   g_ul_test_var = 30UL;

signed char     g_sc_test_var = '9' ;
signed short    g_ss_test_var = -10 ;
signed int      g_si_test_var = -20 ;
signed long     g_sl_test_var = -30L;

signed int          l_si_test_var = 0;
static signed int   ls_si_test_var = 0;

void testIncreaseTestVar(void)
{
    unsigned int i;

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

        l_si_test_var++;
        ls_si_test_var++;
    }
}

void testDecreaseTestVar(void)
{
    unsigned int i;

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

        l_si_test_var++;
        ls_si_test_var++;
    }
}
