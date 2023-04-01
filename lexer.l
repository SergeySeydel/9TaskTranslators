%{
#include <stdio.h>
#include "parser.tab.h"
%}



%%


"int" { return INT; }
"void" { return VOID; }
"(" { return LBRACE; }
")" { return RBRACE; }
"," { return COMMA; }
";" { return DACOMMA; }
"{" { return LCBRACE; }
"}" { return RCBRACE; }
[0-9]+ {yylval.number = atoi(yytext); return VALUE; }
[a-zA-Z][a-zA-Z0-9]* { size_t len = strlen(yytext);
	  yylval.token_NAME = malloc(len+1);
	  printf("%s\n", yytext);
	  sscanf(yytext, "%s", yylval.token_NAME);  
	  return NAME; 
	}
[ \t\n] { }
. { fprintf(stderr, "Unknown token: %s\n", yytext);}

%%

  