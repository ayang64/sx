#pragma once

#include <stdlib.h>
#include "xmalloc.h"

/* should we store the size of the data block? */
struct list {
	struct list *next;
	void *data;
};

enum object_type {
	OBJECT_ATOM,
	OBJECT_ATTRIBUTE,
	OBJECT_FUNCTION,
	OBJECT_INTEGER,
	OBJECT_LIST,
	OBJECT_NIL,
	OBJECT_SPECIAL_FORM,
	OBJECT_STRING,
	OBJECT_SYMBOL,
};

struct object {
	enum object_type type;
	char *name;							/* can be anonymous */
	union {
		char *string;
		long long integer;
		long double real;
		struct list *head;
	} value;
};

