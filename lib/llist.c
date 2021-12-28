#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "llist.h"

s_llist* open_llist(void)
{
	s_llist* p = (s_llist*)calloc(1, sizeof(s_llist));
	memset(p, 0u, sizeof(s_llist));
	return p;
}

s_llist* close_llist(s_llist* p)
{
	s_llist* _p_tg;
	s_llist* _p_tmp;

	if(p != NULL)
	{
		/* Remove prev side llist */
		_p_tg = p->prev;
		while(_p_tg != NULL)
		{
			_p_tmp = _p_tg->prev;
			rm_llist(_p_tg);
			_p_tg = _p_tmp;
		}
		/* Remove next side llist */
		_p_tg = p->next;
		while(_p_tg != NULL)
		{
			_p_tmp = _p_tg->next;
			rm_llist(_p_tg);
			_p_tg = _p_tmp;
		}
		/* Remove center llist */
		rm_llist(p);
	}
	else
	{
		/* Do nothing */
	}

	return NULL;
}

s_llist* mk_llist(s_llist* p, e_llist_dir dir)
{
	s_llist* _p_new;
	s_llist* _p_tmp;
	if(p == NULL)
	{
		return open_llist();
	}
	else
	{
		switch(dir)
		{
			case LLIST_DIR_PREV:
			{
				_p_new = open_llist();
				_p_tmp = p->prev;

				//link new and cur
				p->prev = _p_new;
				_p_new->next = p;

				if(_p_tmp != NULL)	
				{
					_p_tmp->next=_p_new;
					_p_new->prev=_p_tmp;
				}
				return _p_new;
			}

			case LLIST_DIR_NEXT:
			{
				_p_new = open_llist();
				_p_tmp = p->next;

				//link new and cur
				p->next = _p_new;
				_p_new->prev = p;

				if(_p_tmp != NULL)	
				{
					_p_tmp->prev = _p_new;
					_p_new->next = _p_tmp;
				}
				return _p_new;
			}

			default:
			{
				return p;
			}
		}
	}
}

s_llist* rm_llist(s_llist* p)
{
	s_llist* _next;
	s_llist* _prev;
	
	if(p != NULL)
	{
		_next = p->next;
		_prev = p->prev;

		/* Linking next and prev side */
		if	(_next != NULL)		_next->prev=_prev;
		if	(_prev != NULL)		_prev->next=_next;

		/* Remove object */
		if	(p->object != NULL)
		{
			switch(p->type)
			{
				case LLIST_TYPE_TOGETHER:
					p->fp_rmObj(&(p->object));
					break;
				case LLIST_TYPE_SEPERATE:
					break;
				default:
					break;
			}
		}
		/* Remove info */
		if	(p->info != NULL)
		{
			p->fp_rmInfo(&(p->info));
		}
		/* Remove s_llist */
		free(p);
		/* Set return value */
		if		(_next != NULL)	return _next;
		else if	(_prev != NULL)	return _prev;
		else					return NULL;
	}
	else
	{
		return NULL;
	}	

}

s_llist* find_llist_end(s_llist* p, e_llist_dir dir)
{
	if(p==NULL)
	{
		return NULL;
	}
	else
	{
		s_llist* _tmp;
		switch(dir)
		{
			case LLIST_DIR_PREV:
			{
				for(_tmp=p; _tmp->prev!=NULL; _tmp=_tmp->prev);
			}
			break;

			case LLIST_DIR_NEXT:
			{
				for(_tmp=p; _tmp->next!=NULL; _tmp=_tmp->next);
			}
			break;

			default:
			{
				_tmp = p;
			}
			break;
		}
		return _tmp;
	}
}

void* get_llist_object(s_llist* p)
{
    if(p==NULL)
    {
        return NULL;
    }
    return p->object;
}

void* get_llist_info(s_llist* p)
{
    if(p==NULL)
    {
        return NULL;
    }
    return p->info;
}

int set_llist_object(s_llist* p, void* object, void* fp_rmObj, e_llist_type type)
{
    if(p==NULL)
    {
        return -1;
    }
    p->object = object;
	p->fp_rmObj = fp_rmObj;
	p->type = type;
    return 0;
}

int set_llist_info(s_llist* p, void* info, void* fp_rmInfo)
{
    if(p==NULL)
    {
        return -1;
    }
    p->info = info;
	p->fp_rmInfo = fp_rmInfo;
    return 0;
}
