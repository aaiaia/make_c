#include <stdio.h>
#include <stdlib.h>
#include "../stack.h"

void _PRINT_S(s_llist* _s)
{
	{
		if(_s!=NULL)	printf("prev=0x%08x, loc=0x%08x, object=0x%x next=0x%08x\r\n",_s->prev , _s, _s->object, _s->next);
		else		printf("Empty\r\n");
	}
}

void _PRINT_HEAD(s_llist* _s)
{
	{
		s_llist* _head;
		_head=find_llist_end(_s, LLIST_DIR_PREV);
		printf("head info: ");
		_PRINT_S(_head);
	}
}

void _PRINT_LIST_S(const char* str, s_llist* _s)
{
	{
		s_llist* _head;
		s_llist* _tmp;
		_head = find_llist_end(_s, LLIST_DIR_PREV);
		printf("%s", str);
		if(_head!=NULL)
		{
			_PRINT_S(_head);
			_tmp=_head->next;
			while(_tmp!=NULL)
			{
				_PRINT_S(_tmp);
				_tmp=_tmp->next;
			}
			printf("\r\n");
		}
		else
		{
			printf("Empty List\r\n");
		}
	}
}

int main(int argc, char* argv[])
{
    s_stack_data* test = make_stack();
	printf("main for stack test.\r\n");

	if(init_stack(test) < 0)	printf("init_stack failed\n");

	_PRINT_LIST_S("[START LIST]\r\n", test->root);
	push_stack(test, (void*)1u);
	_PRINT_LIST_S("[START LIST] push\r\n", test->root);
	push_stack(test, (void*)2u);
	_PRINT_LIST_S("[START LIST] push\r\n", test->root);
	push_stack(test, (void*)3u);
	_PRINT_LIST_S("[START LIST] push\r\n", test->root);
	push_stack(test, (void*)4u);
	_PRINT_LIST_S("[START LIST] push\r\n", test->root);

	printf("\n\n");

	_PRINT_LIST_S("[START LIST]\r\n", test->root);
	printf("pop %u\n", (unsigned int)pop_stack(test));
	_PRINT_LIST_S("[START LIST]\r\n", test->root);
	printf("pop %u\n", (unsigned int)pop_stack(test));
	_PRINT_LIST_S("[START LIST]\r\n", test->root);
	printf("pop %u\n", (unsigned int)pop_stack(test));
	_PRINT_LIST_S("[START LIST]\r\n", test->root);
	printf("pop %u\n", (unsigned int)pop_stack(test));
	_PRINT_LIST_S("[START LIST]\r\n", test->root);
	printf("pop %u\n", (unsigned int)pop_stack(test));
	_PRINT_LIST_S("[START LIST]\r\n", test->root);
	printf("pop %u\n", (unsigned int)pop_stack(test));
	_PRINT_LIST_S("[START LIST]\r\n", test->root);
	printf("pop %u\n", (unsigned int)pop_stack(test));
	_PRINT_LIST_S("[START LIST]\r\n", test->root);
	printf("pop %u\n", (unsigned int)pop_stack(test));
	_PRINT_LIST_S("[START LIST]\r\n", test->root);

	printf("\n\n");

	for(unsigned int i=100; i<200; i++)
	{
		push_stack(test, (void*)i);
	}
	_PRINT_LIST_S("[START LIST] push, 100~199\r\n", test->root);

	printf("\n\n");

	for(unsigned int i=0; i<102; i++)
	{
		printf("pop %u\n", (unsigned int)pop_stack(test));
	}
	_PRINT_LIST_S("[START LIST] pop, 102\r\n", test->root);

    return 0;
}
