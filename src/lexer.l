%{
#include <stdio.h>
#include "object.h"
#include "parser.tab.h"
#include "log.h"
%}

%option   8bit bison-bridge bison-locations reentrant
%option   warn nodefault caseless fast
%option   outfile="lexer.c" header-file="lexer.h"

%%

\"(\\.|[^"])*\"|\'(\\.|[^'])*\'	{
											pr("yyleng = %lu\n", yyleng);
											char *temp = strndup(yytext + 1, yyleng - 2);
											yylval->object = object_new(OBJECT_STRING, NULL, temp);
											free(temp);
											return ATOM;
										}

[^[:space:]^(^)]+		{
											yylval->object = object_new(OBJECT_ATOM, NULL, yytext);
											return ATOM;
										}

[()]								{
											return yytext[0];
										}

[[:space:]]+				; /* ignore whitespace. */

%%
