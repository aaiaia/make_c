#include <stdio.h>
#include <stdlib.h>
#include "../queue.h"

#include "testLib_llist.h"

int main(int argc, char* argv[])
{
	s_queue* test = make_queue();
	printf("main for queue test.\r\n");

	if(init_queue(test) < 0)	printf("init_queue failed\n");

	_PRINT_LLIST_LIST("[START LIST]\r\n", test->in);
	put_queue(test, (void*)1u);
	_PRINT_LLIST_LIST("[START LIST] put\r\n", test->in);
	put_queue(test, (void*)2u);
	_PRINT_LLIST_LIST("[START LIST] put\r\n", test->in);
	put_queue(test, (void*)3u);
	_PRINT_LLIST_LIST("[START LIST] put\r\n", test->in);
	put_queue(test, (void*)4u);
	_PRINT_LLIST_LIST("[START LIST] put\r\n", test->in);

	printf("\n\n");

	_PRINT_LLIST_LIST("[START LIST]\r\n", test->in);
	printf("get %u\n", (unsigned int)get_queue(test));
	_PRINT_LLIST_LIST("[START LIST]\r\n", test->in);
	printf("get %u\n", (unsigned int)get_queue(test));
	_PRINT_LLIST_LIST("[START LIST]\r\n", test->in);
	printf("get %u\n", (unsigned int)get_queue(test));
	_PRINT_LLIST_LIST("[START LIST]\r\n", test->in);
	printf("get %u\n", (unsigned int)get_queue(test));
	_PRINT_LLIST_LIST("[START LIST]\r\n", test->in);
	printf("get %u\n", (unsigned int)get_queue(test));
	_PRINT_LLIST_LIST("[START LIST]\r\n", test->in);
	printf("get %u\n", (unsigned int)get_queue(test));
	_PRINT_LLIST_LIST("[START LIST]\r\n", test->in);
	printf("get %u\n", (unsigned int)get_queue(test));
	_PRINT_LLIST_LIST("[START LIST]\r\n", test->in);
	printf("get %u\n", (unsigned int)get_queue(test));
	_PRINT_LLIST_LIST("[START LIST]\r\n", test->in);


    return 0;
}
