%{
#include <stdio.h>

typedef void * yyscan_t;

#include "list.h"
#include "parser.tab.h"
#include "lexer.h"
%}

%locations
%define api.pure full
%lex-param {yyscan_t s}
%parse-param {yyscan_t s} {struct node **tree}

%union {
	char *atom;
	struct node *node;
}

%token	ATOM

%%

sexps	: sexp
				| sexps sexp
				;

sexp	:	'('	list ')'
				{ printf("SEXPR: %p\n", $<atom>2); }
				;

list	:	node
				| list node
				;

node	:	{ $<node>$ = NULL; }
				atom
				| sexp
				;

atom	:	%empty
				{ $<atom>$ = NULL; printf("*NULL-ATOM*\n"); }
				| ATOM
				{ printf("ATOM: %s\n", $<atom>1); }
				;
%%

int
main(int argc __attribute__ ((unused)) , char *argv[] __attribute__ ((unused)))
{
    yyscan_t  s;

		struct node *tree = NULL;

		yylex_init(&s);
		yyparse(s, &tree);
		yylex_destroy(s);
}
