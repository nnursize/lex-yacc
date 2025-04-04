# lex-yacc
Simple calculator design (lex and yacc)

BIL-395 HW-1
Nursize Turan
201104091


PS: I work on Windows so I use flex and bison since lex and yacc not supported directly in Windows.


I first design the lex code by implementing the instructions step by step.


* Lex Code Design:


    - The lexer identifies tokens based on the given arithmetic expressions.
    
    - It supports both integer (NUMBER) and floating-point (FLOAT) numbers, assigning their values to yylval.val to pass them to the parser.
    
    - Spaces and tabs are ignored by the lexer.
    
    - The lexer is designed to recognize valid numbers, arithmetic operators, and parentheses. So, if an unexpected character appears, it triggers an error message.
    
    Additional Details:
    
    atoi is used for integer conversion, atof is used for floating-point conversion.
    
    FLOAT is explicitly defined for floating-point number support.
    
    NEWLINE is treated as an end-of-expression signal, ensuring that the expression result is printed after pressing enter.



Then I started to design yacc code by following insturctions step by step.


* Yacc Code Design:


    - The Yacc file defines the grammar rules for arithmetic expressions.
    
    - The parser provides error messages without terminating execution.
    
    - Tokens are used to represent arithmetic expressions, and precedence rules are applied to follow mathematical conventions.
    
    - Operations follow a left-to-right evaluation order, except exponentiation, which has right-associativity.
    
    - FLOAT is treated similarly to NUMBER in expressions.
    
    - %union is used to store token values, with double val handling both integers and floating-point numbers.
    
    - The program is designed to handle multiple expressions in a single run.
    
    - NEWLINE is used as an end-of-expression signal.
    
    Expression Rules:
    
    $1 → Represents the first part of the rule.
    
    $2 → Represents the middle part (e.g., value inside parentheses).
    
    $3 → Represents the third part of the rule.


To run code in Windows;
1) install flex, bison, dev-cpp
2) go to the path of calculator.l and calculator.y and run the command givn below using cmd;
3) flex calculator.l
4) bison -d calculator.y (Different from Linux yacc (y.tab.c and y.tab.h), bison creates calculator.tab.c and calculator.tab.h)
5) gcc lex.yy.c calculator.tab.c -o calculator
6) calculator

To run code in Linux;
1) sudo apt install flex bison
2) go to the path of calculator.l and calculator.y
3) lex calculator.l
4) yacc -d calculator.y
5) gcc lex.yy.c y.tab.c -o calculator -lm
6) ./calculator

PS: In Linux, it is necessary to add -lm to the end of gcc compiler line like given below because of the "pow":
	gcc lex.yy.c y.tab.c -o calculator -lm


Test Cases PDF Drive Link : https://drive.google.com/file/d/1J_rKJpMc0ByZa3r9aj-jss61SoD9ivgc/view?usp=sharing

