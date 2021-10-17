%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

int yylex();
void yyerror(char *s);

char err[256];
int lineCount,charCount,ifcheck=0;
int t=0; //t->'{'數量

char *yytext;
%}

%union
{
    char* SVal;
} 
%token <SVal> ID
%token INTEGER FLOATER STR VOID TYPE INVALID
%token STATIC NEW FINAL PUBLIC PROTECTED PRIVATE CLASS RETURN
%token WHILE FOR IF ELSE PRINT READ
%token PLUS MINUS MULTIPLY DIVIDE LS RS LM RM LB RB
%token EQUAL COMMA INFIXOP DOT DOUBLEPLUS DOUBLEMINUS
%token NEWLINE SEMICOLON COMMENT

%%
lines: 
     | newline
     | lines COMMENT newline
     | lines program newline
     | error  NEWLINE 
     { 
        printf("%s", err);
        printf("\nLine %d: ", lineCount);
     };
newline: NEWLINE {printf("\nLine %d: ",lineCount);};

//規格書
program: 
       | basic
       | class 
       | method_declaration
       | simple
       | method
       | condition
       | loop
       | return
       | lb
       | rb;
end: 
   | SEMICOLON;
left: 
    | lb;
right:
     | rb;
//遇到“{”
lb: LB { t+=2; };
//遇到“}”
rb: RB { t--; ifcheck--; };

// 2.1 data types and declarations
basic: STATIC TYPE IDlist1 end  //static type identifier_list;
     | TYPE IDlist1 end         //type identifier_list;
     | TYPE LM RM ID EQUAL NEW TYPE LM INTEGER RM end
     | FINAL TYPE IDlist2 end
     ;

const_expr:
	  | EQUAL expression;

// identifier_list -> identifier [= const_expr] {, identifier [= const_expr]}
ID_1: ID { 
         if( lookup($1[0], t) == -1 )
	      insert($1[0], t);
	    else
	       yyerror("Duplicate");
      } const_expr;
IDlist1: ID_1
        | IDlist1 COMMA IDlist1;

// identifier_list -> identifier = const_expr {, identifier = const_expr}
ID_2: ID EQUAL expression;
IDlist2: ID_2
        | IDlist2 COMMA IDlist2;

// 2.1.2 class and object

class: CLASS ID left right
     | ID ID EQUAL NEW ID LS RS SEMICOLON;

// 2.2 methods
method_declaration: method_modifier TYPE ID LS argument RS left right
                  | TYPE ID LS argument RS left right;
method_modifier: PUBLIC 
               | PROTECTED 
               | PRIVATE;
argument:
        | arg;
arg: TYPE ID
   | arg COMMA arg;

// 2.3 Statements
// 2.3.1 compound
// 2.3.2 Simple
simple: name EQUAL expression end
      | PRINT LS print_argument RS end
      | READ LS name RS end
      | name DOUBLEPLUS end
      | name DOUBLEMINUS end
      | expression end;

print_argument: pob
              | print_argument PLUS pob;
pob: num
   | STR;
name: ID
    | ID DOT ID;

// expressions
expression: term
          | expression PLUS term
          | expression MINUS term;

// term -> factor {* factor | / factor}
term: term MULTIPLY factor
    | term DIVIDE factor
    | factor;
factor: num
      | LS expression RS
      | PrefixOp ID
      | num PostfixOp
      | method;

num: ID
  | number
  | ID LM INTEGER RM;
number: INTEGER 
      | FLOATER;

PrefixOp: PostfixOp
         | PLUS
         | MINUS;
PostfixOp: DOUBLEPLUS
         | DOUBLEMINUS;

// method_invocation 
method: name LS arguments RS end;
arguments: 
         | arguments COMMA arguments
         | expression;

//2.3.3 conditional
condition: IF {ifcheck++;} LS boolean_expr RS left
		   | ELSE 
           {
               ifcheck--;
               if(ifcheck!=0)
                    yyerror("ifelse");
           } left;

// 2.3.4 loop
boolean_expr: expression INFIXOP expression
	        | expression;

loop: WHILE LS boolean_expr RS left
    | FOR LS ForInitOpt end boolean_expr end ForUpdateOpt RS left
    ;
ForInitOpt: num EQUAL expression
          | TYPE ID EQUAL expression;
ForUpdateOpt: num DOUBLEPLUS
            | num DOUBLEMINUS;;

//2.3.5 return
return: RETURN expression end;

%%

int main()
{
    printf("Line %d: ",lineCount);
    yyparse();
    printf("\n");
    return 0;
}

void yyerror(char* s)
{
    memset(err, 0, 256);
    
    if(strcmp(s,"Duplicate") == 0)
    {
        //重複
        sprintf(err, "\n> is a duplicate identifier.");
        printf("%s", err);
    }
    else if(strcmp(s,"ifelse") == 0)
    {
        //if else
        sprintf(err, "\nLine %d, 1st char: %d, a syntax error", lineCount, charCount);
        printf("%s", err);
    }else{
        //少了; ,
        sprintf(err, "\nLine %d, 1st char: %d, a syntax error", lineCount, charCount);
    }
};

