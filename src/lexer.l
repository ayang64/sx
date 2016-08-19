%{
#include <stdio.h>
#include "lexer.h"
#include "parser.tab.h"
%}

%option   8bit bison-bridge bison-locations reentrant
%option   warn nodefault caseless fast
%option   outfile="lexer.c" header-file="lexer.h"

%%

[()]					{	return yytext[0]; }

[^[:space:]]	{	yylval->atom = strdup(yytext); return ATOM; }

[[:space:]]+	;

%%
