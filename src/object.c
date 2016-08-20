#include <stdio.h>
#include "log.h"
#include "object.h" 

struct list *
list_append(struct list **l, void *value)
{
	struct list *rc = xcalloc(1, sizeof (*rc));	

	rc->data = value;
	rc->next = NULL;

	while ((*l) != NULL) {
		putchar('.');
		l = &(*l)->next;
	}
	putchar('\n');

	*l = rc;

	return *l;
}

char *
object_string(struct object *obj)
{
	assert(obj != NULL);

	if (obj->type == OBJECT_NIL)
		return "*NIL*";
	else if (obj->type == OBJECT_LIST)
		return "*LIST*";
	else if (obj->type == OBJECT_STRING)
		return obj->value.string;
	else if (obj->type == OBJECT_ATOM)
		return obj->value.string;

	return "*NO-STRING-REPRESENTATION*";
}

struct object *
object_append(struct object *head, struct object *c)
{
	assert(head != NULL);
	assert(head->type == OBJECT_LIST);

	printf(" - APPENDING %s - ", object_string(c));

	list_append(&head->value.head, c);

	return head;
}


struct object *
object_new(enum object_type type, char *name, void *value)
{
	struct object *rc = xcalloc(1, sizeof (*rc));
	rc->type = type;
	rc->name = name;

	switch (rc->type) {
		case OBJECT_NIL:
			rc->value.string = "*nil*";
			pr("Creating a NIL object.\n");
			break;

		case OBJECT_STRING:
			pr("Thank you for creating an atom.\n");
			assert(value != NULL);
			rc->value.string = value; 
			break;

		case OBJECT_ATOM:
			pr("Thank you for creating an atom.\n");
			assert(value != NULL);
			rc->value.string = value; 
			break;

		case OBJECT_LIST:
			pr("Thank you for creating a list.\n");
			rc->value.head = NULL;
			break;

		case OBJECT_ATTRIBUTE:
		case OBJECT_FUNCTION:
		case OBJECT_INTEGER:
		case OBJECT_SPECIAL_FORM:
		case OBJECT_SYMBOL:
		default:
			break;
	}

	return rc;
}

