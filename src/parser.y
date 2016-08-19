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
%parse-param {yyscan_t s}

%union {
	char *atom;
	struct list *node;
}

%token	ATOM

%%

sexps	:	sexp
				| sexps sexp
				;

sexp	:	'('	list ')'
				{ printf("SEXPR: %s\n", $<atom>2); }
				;

list	:	node
				| list node
				;

node	:	atom
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

		yylex_init(&s);
		yyparse(s);
		yylex_destroy(s);
}
