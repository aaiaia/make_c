#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "llist.h"

s_llist* open_llist(void)
{
	s_llist* p = (s_llist*)calloc(1, sizeof(s_llist));
	memset(p, 0u, sizeof(s_llist));
	p->prev = NULL;
	p->next = NULL;
	p->object = NULL;
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
			free(_p_tg);
			_p_tg = _p_tmp;
		}

		/* Remove next side llist */
		_p_tg = p->next;
		while(_p_tg != NULL)
		{
			_p_tmp = _p_tg->next;
			free(_p_tg);
			_p_tg = _p_tmp;
		}
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
		return NULL;
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

		if	(_next != NULL)		_next->prev=_prev;
		if	(_prev != NULL)		_prev->next=_next;

		if	(p->object != NULL)	free(p->object);

		free(p);
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

int set_llist_object(s_llist* p, void* object)
{
    if(p==NULL)
    {
        return -1;
    }
    p->object = object;
    return 0;
}
