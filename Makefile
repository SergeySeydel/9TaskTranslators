all: my
my: lexer.l parser.y
	bison -t -d parser.y
	flex --debug lexer.l
	cc lex.yy.c parser.tab.c -g
	./a.exe < testfile.test
