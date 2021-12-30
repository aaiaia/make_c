#ifndef _QUEUE_H_
#define _QUEUE_H_

#include <dataType/llist.h>

struct queue
{
    s_llist *out;
    s_llist *in;
};
typedef struct queue s_queue;

s_queue* make_queue(void);
int init_queue(s_queue* queue);
int put_queue(s_queue* queue, void* object);
void* get_queue(s_queue* queue);
#endif
