/*
 * We assume that memory allocation failures are catastrophic errors from which there is no reasonable way to
 * recover.
 *
 * So we wrap malloc() and friends with a macro that assert() that the results are non-NULL.
 *
 */ 

#pragma once

#include <stdlib.h>
#include <assert.h>

/* depends on the gnu statement expression extension. */

#define _xfunc(f,...)		({ void *rc = f(__VA_ARGS__); assert (rc != NULL); rc;  })
#define xmalloc(s)			_xfunc(malloc,s)
#define xrealloc(p,s)		_xfunc(realloc,p,s)
#define xcalloc(nmemb, size)	_xfunc(calloc,nmemb,size)
