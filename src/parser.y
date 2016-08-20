%{
#include <stdio.h>

/* FIXME -- i wish i didn't have to typedef yyscan_t here.  someone please help! */
typedef void * yyscan_t;

#include "object.h"
#include "parser.tab.h"
#include "lexer.h"
#include "log.h"
%}

%locations
%define				api.pure full
%lex-param 		{yyscan_t s}
%parse-param	{yyscan_t s} {struct object **tree}

%union {
	struct object *object;
}

%token	ATOM

%%

sexps	: sexp
				{ pr("tree = %p\n", *tree); } 
				| sexps sexp
				;

sexp	:	'('	list ')'
				{

					if ($<object>2->type != OBJECT_LIST) {
						printf("NOT A LIST!\n");
						abort();
					}
					pr("SEXP-LIST_OBJECT: %p\n", $<object>2);

					for (struct list *cur = $<object>2->value.head; cur != NULL; cur = cur->next) {
						struct object *curobj = cur->data;
						if (curobj != NULL)
							pr("  -> %s\n", object_string(curobj));
					}
				}
				;

list	:	node
				{
					pr("Creating new list and appending %s to it.\n", object_string($<object>1));
					$<object>$ = object_new(OBJECT_LIST, NULL, NULL);
					object_append($<object>$, $<object>1);
				}
				| list node
				{ $<object>$ = object_append($<object>$, $<object>1); }
				;

node	:	atom
				| sexp
				;

atom	:	%empty
				{ $<object>$ = object_new(OBJECT_NIL, NULL, NULL); ; pr("*NULL-ATOM*\n"); }
				| ATOM
				{ pr("ATOM: %s\n", object_string($<object>1)); }
				;
%%

int
main(int argc __attribute__ ((unused)) , char *argv[] __attribute__ ((unused)))
{
    yyscan_t  s;
		yylex_init(&s);

		struct object *tree = NULL;
		yyparse(s, &tree);

		yylex_destroy(s);
}
