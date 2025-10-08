all: calc

parser.tab.c parser.tab.h: parser.y
	bison -d -o parser.tab.c parser.y

lex.yy.c: lexer.l parser.tab.h
	flex -o lex.yy.c lexer.l

calc: parser.tab.c lex.yy.c
	gcc -O2 -Wall -Wextra -o calc parser.tab.c lex.yy.c -lfl

clean:
	rm -f calc parser.tab.c parser.tab.h lex.yy.c
.PHONY: all clean
