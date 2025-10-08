%option noyywrap nodefault
%{
  #include "parser.tab.h"
  #include <stdlib.h>
%}

WS   [ \t]+
NUM  ([0-9]+(\.[0-9]+)?|\.[0-9]+)

%%
{WS}          ;
{NUM}         { yylval.num = strtod(yytext, NULL); return NUMBER; }
"("           return '(';
")"           return ')';
"+"           return '+';
"-"           return '-';
"*"           return '*';
"/"           return '/';
\n            return '\n';
.             ;  /* ignore anything else */
%%
