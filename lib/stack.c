#include <stdio.h>
#include <stdlib.h>
#include "llist.h"
#include "stack.h"

s_stack_data* make_stack(void)
{
    s_stack_data *p;
    p = (s_stack_data*)malloc(sizeof(s_stack_data));
    p->root = (s_llist*)NULL;
    return p;
}
int init_stack(s_stack_data* p)
{ 
    if(p == NULL)
    {
        return -1;
    }
    return 0;
}

void* pop_stack(s_stack_data* p)
{
    if(p == NULL)
    {
        return NULL;
    }
    void* object = get_llist_object(p->root);
    p->root = rm_llist(p->root);
    return object;
}

void push_stack(s_stack_data* p, void* object)
{
    if(p == NULL)
    {
        return;
    }
    if(p->root == NULL)
    {
        p->root = open_llist();
    }
    else
    {
        p->root = mk_llist(p->root, LLIST_DIR_LEFT);
    }
    set_llist_object(p->root, object, NULL, LLIST_TYPE_SEPERATE);
}
