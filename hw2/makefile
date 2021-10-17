all:	clean y.tab.c lex.yy.c
	gcc lex.yy.c y.tab.c -ly -lfl -o calc

y.tab.c:
	bison -y -d B075020033.y

lex.yy.c:
	flex B075020033.l

clean:
	rm -f calc lex.yy.c y.tab.c y.tab.h
