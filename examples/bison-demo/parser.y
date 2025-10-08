%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s) { fprintf(stderr, "parse error: %s\n", s); }
%}

%union { double num; }
%token <num> NUMBER
%type  <num> expr

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

input
  : /* empty */
  | input '\n'
  | input expr '\n'     { printf("%.10g\n", $2); }
  ;

expr
  : NUMBER
  | expr '+' expr       { $$ = $1 + $3; }
  | expr '-' expr       { $$ = $1 - $3; }
  | expr '*' expr       { $$ = $1 * $3; }
  | expr '/' expr       { $$ = ($3 == 0 ? (fprintf(stderr,"div by zero\n"), 0) : $1 / $3); }
  | '-' expr %prec UMINUS { $$ = -$2; }
  | '(' expr ')'        { $$ = $2; }
  ;

%%

int main(void) { return yyparse(); }
