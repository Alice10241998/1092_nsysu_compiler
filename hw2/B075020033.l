%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"y.tab.h"

int charCount=0, lineCount=1,len=0;

int lookup(int s,int sc);	
int insert(int s,int sc);

struct symbol
{
    	int id;
    	int tmp;
    	int index;
};
struct symbol Table[256];
%}

infixop	"=="|"!="|"<"|">"|"<="|">="
type "boolean"|"char"|"int"|"float"|"double"|"string"|"void"

letter [a-zA-Z]
digit [0-9]
sign [\+\-]
exponent [Ee]

integer ({sign}?[1-9][0-9]*)|({sign}?[0])
float ({integer}\.{digit}+)|({integer}\.{digit}+{exponent}{integer})|({integer}{exponent}{sign}{digit}+)
id [\_\$]?[a-zA-Z]+[a-zA-Z0-9\_\$]*
string \"([^\n"'\\]|\\\"|\\\')*\"
comments \/\*([^\*]|\*+[^\*\/])*\*+\/
comment \/\/.*
space [ \t]
eol \r\n|\n

%%
\.		{printf("%s",yytext);charCount+=yyleng;return DOT;}
\;		{printf("%s",yytext);charCount+=yyleng;return SEMICOLON;}
\,		{printf("%s",yytext);charCount+=yyleng;return COMMA;}
\= 	    {printf("%s",yytext);charCount+=yyleng;return EQUAL;}
"++"	{printf("%s",yytext);charCount+=yyleng;return DOUBLEPLUS;}
"--"	{printf("%s",yytext);charCount+=yyleng;return DOUBLEMINUS;}
\+ 	    {printf("%s",yytext);charCount+=yyleng;return PLUS;}
\-		{printf("%s",yytext);charCount+=yyleng;return MINUS;}
\*		{printf("%s",yytext);charCount+=yyleng;return MULTIPLY;}
\/		{printf("%s",yytext);charCount+=yyleng;return DIVIDE;}
"{"		{printf("%s",yytext);charCount+=yyleng;return LB;}
"}"		{printf("%s",yytext);charCount+=yyleng;return RB;}
"["		{printf("%s",yytext);charCount+=yyleng;return LM;}
"]"		{printf("%s",yytext);charCount+=yyleng;return RM;}
"("		{printf("%s",yytext);charCount+=yyleng;return LS;}
")"		{printf("%s",yytext);charCount+=yyleng;return RS;}
{infixop} 	{printf("%s",yytext);charCount+=yyleng;return INFIXOP;}

{type}		{printf("%s",yytext);charCount+=yyleng;return TYPE;}
print		{printf("%s",yytext);charCount+=yyleng;return PRINT;}
read		{printf("%s",yytext);charCount+=yyleng;return READ;}
class 		{printf("%s",yytext);charCount+=yyleng;return CLASS;}
if 			{printf("%s",yytext);charCount+=yyleng;return IF;}
else		{printf("%s",yytext);charCount+=yyleng;return ELSE;}
for 		{printf("%s",yytext);charCount+=yyleng;return FOR;}
while 		{printf("%s",yytext);charCount+=yyleng;return WHILE;}
new 		{printf("%s",yytext);charCount+=yyleng;return NEW;}
final 		{printf("%s",yytext);charCount+=yyleng;return FINAL;}
static 		{printf("%s",yytext);charCount+=yyleng;return STATIC;}
public 		{printf("%s",yytext);charCount+=yyleng;return PUBLIC;}
private 	{printf("%s",yytext);charCount+=yyleng;return PRIVATE;}
protected 	{printf("%s",yytext);charCount+=yyleng;return PROTECTED;}
return 		{printf("%s",yytext);charCount+=yyleng;return RETURN;}

{integer}   {printf("%s",yytext);charCount+=yyleng;return INTEGER;}
{float}     {printf("%s",yytext);charCount+=yyleng;return FLOATER;}
{id}        {printf("%s", yytext);charCount += yyleng;yylval.SVal=yytext;return ID;}
{string}    {printf("%s",yytext);charCount+=yyleng;return STR;}
{comments}	{
            char *line="\n";
            char *tmp;
            int n=1;
            tmp=strtok(yytext,line);
            while(tmp!= NULL)
	        {
    	        if(n==1)
        	        printf("%s",tmp);
                else
        	        printf("\nLine %d: %s",lineCount,tmp);
                n++;
                lineCount++;
                tmp=strtok(NULL,line);
            }
	        charCount+=yyleng;
            lineCount--;
            return COMMENT;
            }
{comment}	{printf("%s",yytext);charCount+=yyleng;return COMMENT;}
{space}		{printf("%s",yytext);charCount++;}
{eol}		{lineCount++;charCount=1;return NEWLINE;}

%%
int yywrap()
{
	return 1;
}

int lookup(int s, int  sc)
{
	int i;
	if(len==0)
		return -1;
	for(i=0;i<len;i++)
    {
		if(Table[i].id==s && Table[i].tmp==sc)
			return Table[i].index;
	}
	return -1;
}
int insert(int s, int sc)
{
	Table[len].id=s;
	Table[len].tmp=sc;
	Table[len].index=len;
	len++;
	return len-1;
}