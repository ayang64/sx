%{
#include <stdio.h>

#include "parser.tab.h"
#include "lexer.h"

%}

%locations
%define api.pure full
%lex-param {yyscan_t s}
%parse-param {yyscan_t s}

%union {
	char *atom;
}

%token	ATOM

%%

word:		ATOM
				{
					printf("%s\n", $<atom>1);
				}
	
%%

int
main(int argc __attribute__ ((unused)) , char *argv[] __attribute__ ((unused)))
{
    yyscan_t s;

		yylex_init(&s);
		yyparse(s);
		yylex_destroy(s);

}
