%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h> // Required for pow()

int yylex(void);
int yyerror(const char *s);
%}

%union{
    double val;  // Define yylval
}

// Terminals

%token <val> NUMBER FLOAT  					// Tokens use yylval.val
%token PLUS MINUS TIMES DIVIDE LPAREN RPAREN NEWLINE EXPONENT 

// Non-terminal

%type <val> expr

// Precedence

%left PLUS MINUS  
%left TIMES DIVIDE 
%right EXPONENT  // Exponentiation has right-associative precedence
%left LPAREN 

%%

program:
	// Empty rule to start with a prompt
	{ printf("Enter an arithmetic expression: "); }

	| program expr NEWLINE{ 
		printf("Result: %f\n", $2); 
		printf("Enter an arithmetic expression: ");
	}

	| program error NEWLINE{ 
		printf("Enter an arithmetic expression: "); 
		yyclearin;  // Discard invalid input
	}
;

expr:

	expr PLUS expr		{$$ = $1 + $3;}
	| expr MINUS expr		{$$ = $1 - $3;}
	| expr TIMES expr		{$$ = $1 * $3;}
	| expr DIVIDE expr	{
					if($3 == 0){
						yyerror("Division by zero error.");
						return(1);
					}
					else{
						$$ = $1 / $3;
					}
				}
 	| expr EXPONENT expr   {$$ = pow($1, $3);} // Exponentiation using pow()
	| LPAREN expr RPAREN	{$$ = $2;}
	| NUMBER		{$$ = $1;}
	| FLOAT {$$ = $1;}
;

%%

// Error handling
int yyerror(const char *s){
	fprintf(stderr, "Error: %s\n", s);
	return 1;
}

// Run the parser
int main(){
	yyparse();
	return 0;
}
