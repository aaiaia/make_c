#ifndef _LLIST_H_
#define _LLIST_H_
enum linked_list_direction
{
    LLIST_DIR_DEFAULT,
    LLIST_DIR_PREV,
    LLIST_DIR_NEXT
};
typedef enum linked_list_direction e_llist_dir;
#define LLIST_DIR_LEFT  LLIST_DIR_PREV
#define LLIST_DIR_RIGHT LLIST_DIR_NEXT

enum linked_list_type
{
    LLIST_TYPE_TOGETHER,
    LLIST_TYPE_SEPERATE
};
typedef enum linked_list_type e_llist_type;

struct linked_list
{
    struct linked_list*     prev;
    struct linked_list*     next;
    enum linked_list_type   type;
    void*                   object;
    void                    (*fp_rmObj)(void** p);
    void*                   info;
    void                    (*fp_rmInfo)(void** p)
};
typedef struct linked_list s_llist;


s_llist* open_llist(void);
s_llist* close_llist(s_llist* p_llist);
s_llist* mk_llist(s_llist* p, e_llist_dir dir);
s_llist* rm_llist(s_llist* p);
s_llist* find_llist_end(s_llist* p, e_llist_dir dir);
void* get_llist_object(s_llist* p);
void* get_llist_info(s_llist* p);
int set_llist_object(s_llist* p, void* object, void* fp_rmObj, e_llist_type type);
int set_llist_info(s_llist* p, void* info, void* fp_rmInfo);
#endif
