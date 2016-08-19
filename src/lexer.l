%{
#include <stdio.h>
#include "parser.tab.h"
%}

%option   8bit bison-bridge bison-locations reentrant
%option   warn nodefault caseless fast
%option   outfile="lexer.c" header-file="lexer.h"

%%

\"(\\.|[^"])*\"|\'(\\.|[^'])*\'	{ yylval->atom = strndup(yytext + 1, yyleng - 2); return ATOM; }
[^[:space:]^(^)]+								{	yylval->atom = strdup(yytext); return ATOM; }

[()]														{	return yytext[0]; }

[[:space:]]+										; /* ignore whitespace. */

%%
