%option noyywrap nodefault
%{
#include <stdio.h>
#include <stdlib.h>

/* Helper to print token and its text */
static void tok(const char* type) {
    printf("%-12s : %s\n", type, yytext);
}
%}

/* --------- Patterns (regular expressions) ---------- */
DIGIT           [0-9]
ID_START        [A-Za-z_]
ID_CONT         [A-Za-z0-9_]
WS              [ \t\r\n]+
LINE_COMMENT    "//".*
BLOCK_COMMENT   "/*"([^*]|\*+[^*/])*\*+"/"

/* --------- Rules ---------- */
%%
{WS}            ;                           /* skip whitespace */

{LINE_COMMENT}  ;                           /* skip // comments */
{BLOCK_COMMENT} ;                           // skip /* ... */

"int"           { tok("KEYWORD"); }
"return"        { tok("KEYWORD"); }
"if"            { tok("KEYWORD"); }
"else"          { tok("KEYWORD"); }

{ID_START}{ID_CONT}*   { tok("IDENT"); }    /* identifiers */

{DIGIT}+        { tok("NUMBER"); }          /* integers */

"=="|"!="|"<="|">="    { tok("OP"); }
"="|"+"|"-"|"*"|"/"    { tok("OP"); }
[(){};,]             { tok("PUNC"); }

.               { tok("UNKNOWN"); }         /* Anything else -> report single unexpected char */
%%

int main(void) {
    yylex();    /* start scanning stdin */
    return 0;
}
