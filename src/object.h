#pragma once

#include <stdlib.h>
#include "xmalloc.h"

/* should we store the size of the data block? */
struct list {
	struct list *next;
	void *data;
};

enum node_type { NODE_LIST, NODE_ATTRIBUTE, NODE_FUNCALL, NODE_ATOM };

struct node {
	enum node_type t;
	char *atom;
	struct list *nodes;
};

