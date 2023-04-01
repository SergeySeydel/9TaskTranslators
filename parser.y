%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
 int yylex(void);
 void yyerror(const char* s);
//#include "lex.yy.c" // подключаем файл лексера
%}

%token INT
%token VOID
%token LBRACE
%token RBRACE 
%token LCBRACE 
%token RCBRACE 
%token COMMA 
%token DACOMMA 
%token VALUE 
%token NAME

//1|<func>::=<type>name(<type>name<p_1>){<p_2>}<p_2>
//2|<p_1>::= ,<type>name<p_1>
//3|<p_1>::= e
//4|<p_2>::=name(<p_3>);<p_2>
//5|<p_2>::= e
//6|<p_3>::= name|value
//7|<type>::= int|void


%union{
	char* token_NAME;
	int number;
	}
%type <number> INT
%type <token_NAME> NAME

%%
//1|<func>::=<type>name(<type>name<p_1>){<p_2>}<p_2>
func : type NAME LBRACE type NAME p_1 RBRACE LCBRACE p_2 RCBRACE p_2
	;
//2|<p_1>::= ,<type>name<p_1> | e
p_1 : COMMA type NAME p_1
	| 
	;
//4|<p_2>::=name(<p_3>);<p_2> | e
p_2 : NAME LBRACE p_3 RBRACE DACOMMA p_2
	| 
	;
//6|<p_3>::= name|value
p_3 : NAME
	| VALUE
	;
//7|<type>::= int|void
type : INT
	| VOID
	;

%%

void yyerror(const char* s) {
fprintf(stderr, "Error: %s\n", s);
}
int yywrap(){ return 1;}
int main() {

yyparse();
return 0;
}
