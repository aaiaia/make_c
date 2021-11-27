#ifndef _STACK_H_
#define _STACK_H_
#include "llist.h"

struct stack_data
{
    s_llist* root;
};
typedef struct stack_data s_stack_data;

s_stack_data* make_stack(void);
int init_stack(s_stack_data* root);
void* pop_stack(s_stack_data* p);
void push_stack(s_stack_data* p, void* object);
#endif
