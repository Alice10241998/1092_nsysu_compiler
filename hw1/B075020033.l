%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define SIZE 256

int i=0;
unsigned charCount=1,idCount=0,lineCount=1;
char *table[SIZE];

void create();
int lookup(char *s);
int insert(char *s);
void dump();

%}

symbol [\,\:\;\(\)\[\]\{\}]
operator [\+|\+\+|\-|\-\-|\*|\/|\%|\=|\<|\<\=|\>\=|\>|\=\=|\!\=|\&\&|\|\||\!]
reserved_word boolean|break|byte|case|char|catch|class|const|continue|default|do|double|else|extends|false|final|finally|float|for|if|implements|int|long|main|new|print|private|protected|public|return|short|static|string|switch|this|true|try|void|while

letter [a-zA-Z]
digit [0-9]
sign [\+\-]
exponent [Ee]

id [\_\$]?[a-zA-Z]+[a-zA-Z0-9\_\$]*
integer ({sign}?[1-9][0-9]*)|({sign}?[0])
float ({integer}\.{digit}+)|({integer}\.{digit}+{exponent}{integer})|({integer}{exponent}{sign}{digit}+)

string \"([^\n"'\\]|\\\"|\\\')*\"

space [ \t]
newline \r\n|\n
comments (\/\*([^\*]|\*+[^\*\/])*\*+\/)|(\/\/.*)

errorid ([0-9\^\#]+[a-zA-Z\^\#]*)|[a-zA-Z]+[\^\#]+
errorstr (\'.*\')|(\".*\")|(\"[^"\n]*\n)

%%

{operator} {
	printf("Line: %d, 1st char: %d, \"%s\" is an \"operator\".\n", lineCount, charCount, yytext);
	charCount+=yyleng;
}

{symbol} {
	printf("Line: %d, 1st char: %d, \"%s\" is a \"symbol\".\n", lineCount, charCount, yytext);
    	charCount+=yyleng;		
}
{reserved_word} {
	printf("Line: %d, 1st char: %d, \"%s\" is a \"reserved_word\".\n", lineCount, charCount, yytext);
    	charCount+=yyleng;	
}
{id} {
	if(lookup(yytext) == -1) insert(yytext);
	printf("Line: %d, 1st char: %d, \"%s\" is an \"ID\".\n", lineCount, charCount, yytext);
    	charCount+=yyleng;
}
{integer} {
	printf("Line: %d, 1st char: %d, \"%s\" is an \"integer\".\n", lineCount, charCount, yytext);
    	charCount+=yyleng;
}
{float} {
	printf("Line: %d, 1st char: %d, \"%s\" is a \"float\".\n", lineCount, charCount, yytext);
    	charCount+=yyleng;
}
{string} {
	printf("Line: %d, 1st char: %d, %s is a \"string\".\n", lineCount, charCount, yytext);
    	for(int i=0;i<strlen(yytext);i++) if(yytext[i]=='\n') lineCount++;
	charCount+=yyleng;
}
{space} {
	charCount+=yyleng;
}
{newline} {
	lineCount++;
	charCount=1;
}
{comments} {
	printf("Line: %d, 1st char: %d, \"%s\" is a \"comment\".\n", lineCount, charCount, yytext);
    	for(int i=0;i<strlen(yytext);i++) if(yytext[i]=='\n') lineCount++;
	charCount+=yyleng;
}

{errorid} {
	printf("Line: %d, 1st char: %d, \"%s\" is an \"invalid ID\".\n", lineCount, charCount, yytext);
    	charCount+=yyleng;
}
{errorstr} {
	printf("Line: %d, 1st char: %d, \"%s\" is a \"invalid string\".\n", lineCount, charCount, yytext);
	for(int i=0;i<strlen(yytext);i++) if(yytext[i]=='\n') lineCount++;
}
. {
	printf("Unrecognized: %s\n",yytext);
//	printf("Line: %d, 1st char: %d, \"%s\" is an \"error\".\n", lineCount, charCount, yytext);
	charCount+=yyleng;
}
%%

int main()
{
	create();
	yylex();
	dump(); 
	return 0;
}

void create() //建立一個symbol table
{
	for(i=0;i<SIZE;i++)
		table[i]=0;
}

int lookup(char *s) //傳回字串s的index；假如s沒找到的話就傳回-1
{
	int tmp=0;
	for(i=0;i<idCount;i++)
	{
		int test=strcmp(s,table[i]);
		if(test==0)
		{
			tmp=0;
			break;
		}
		else tmp=1;
	}

	if(tmp==1||idCount==0)
		return -1;
}

int insert(char *s) //新增s到symbol table中，並傳回存放位置的index
{
	table[idCount]=(char*) malloc(sizeof(char*));
	strcpy(table[idCount],s);
	idCount++;
}

void dump() //將symbol table中所有的資料印出
{
	printf("The symbol table contains:\n");
	for(i=0;i<idCount;i++)
		printf("%s\n",table[i]);
}


