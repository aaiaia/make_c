#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "queue.h"

s_queue* make_queue(void)
{
    s_queue* queue;

    queue = (s_queue*)calloc(1, sizeof(s_queue));
    queue->in   = (s_llist*)NULL;
    queue->out  = (s_llist*)NULL;

    return queue;
}

int init_queue(s_queue* queue)
{
    if(queue == NULL)
    {
        return -1;
    }
    return 0;
}

int put_queue(s_queue* queue, void* object)
{
    if(queue == NULL)
    {
        return -1;
    }

    if(queue->in == NULL)
    {
        s_llist* new_llist = open_llist();
        queue->in = new_llist;
        queue->out = new_llist;
    }
    else
    {
        queue->in = mk_llist(queue->in, LLIST_DIR_LEFT);
    }
    set_llist_object(queue->in, object, NULL, LLIST_TYPE_SEPERATE);

    return 0;
}

void* get_queue(s_queue* queue)
{
    if(queue == NULL)
    {
        return NULL;
    }
    void* object = get_llist_object(queue->out);
    queue->out = rm_llist(queue->out);
    if(queue->out == NULL)
    {
        queue->in = NULL;
    }
    return object;
}
