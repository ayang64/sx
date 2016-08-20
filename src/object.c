#include "list.h" 
struct list *
list_append(struct list **l, void *value)
{
	struct list *rc = xmalloc(sizeof (*rc));	

	rc->data = value;
	rc->next = NULL;

	while ((*l) != NULL)
		l = &(*l)->next;

	*l = rc;

	return *l;
}




