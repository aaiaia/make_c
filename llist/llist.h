#ifndef _LLIST_H_
#define _LLIST_H_
enum linked_list_direction
{
	LLIST_DIR_DEFAULT,
	LLIST_DIR_PREV,
	LLIST_DIR_NEXT
};
typedef enum linked_list_direction e_llist_dir;
#define LLIST_DIR_LEFT	LLIST_DIR_PREV
#define LLIST_DIR_RIGHT	LLIST_DIR_NEXT

struct linked_list
{
	struct linked_list*	prev;
	struct linked_list*	next;
	void*				object;
};
typedef struct linked_list s_llist;


s_llist* open_llist(void);
s_llist* close_llist(s_llist* p_llist);
s_llist* mk_llist(s_llist* p, e_llist_dir dir);
s_llist* rm_llist(s_llist* p);
s_llist* find_llist_end(s_llist* p, e_llist_dir dir);
void* get_llist_object(s_llist* p);
int set_llist_object(s_llist* p, void* object);
#endif
