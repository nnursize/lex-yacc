%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>

int yyerror(const char *errormsg);
%}

%%

[0-9]+		   { yylval.val = atoi(yytext); return NUMBER; }
[0-9]+\.[0-9]*     { yylval.val = atof(yytext); return FLOAT; }  // Match floats
"+"                { return PLUS; }
"-"                { return MINUS; }
"*"                { return TIMES; }
"/"                { return DIVIDE; }
\^|\*\*            { return EXPONENT; } // Added exponentiation operator
"("                { return LPAREN; }
")"                { return RPAREN; }
\n                 { return NEWLINE; } // Handle end of input
\r                 ;
[ \t]+             ;  // Ignore spaces and tabs
.                  { 
                     fprintf(stderr, "Unknown character: %s\n", yytext); 
                     yyerror("Lexical error");
                   }

%%

int yywrap(void){
    return 0;  
}
