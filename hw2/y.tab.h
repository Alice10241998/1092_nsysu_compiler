/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    INTEGER = 259,
    FLOATER = 260,
    STR = 261,
    VOID = 262,
    TYPE = 263,
    INVALID = 264,
    STATIC = 265,
    NEW = 266,
    FINAL = 267,
    PUBLIC = 268,
    PROTECTED = 269,
    PRIVATE = 270,
    CLASS = 271,
    RETURN = 272,
    WHILE = 273,
    FOR = 274,
    IF = 275,
    ELSE = 276,
    PRINT = 277,
    READ = 278,
    PLUS = 279,
    MINUS = 280,
    MULTIPLY = 281,
    DIVIDE = 282,
    LS = 283,
    RS = 284,
    LM = 285,
    RM = 286,
    LB = 287,
    RB = 288,
    EQUAL = 289,
    COMMA = 290,
    INFIXOP = 291,
    DOT = 292,
    DOUBLEPLUS = 293,
    DOUBLEMINUS = 294,
    NEWLINE = 295,
    SEMICOLON = 296,
    COMMENT = 297
  };
#endif
/* Tokens.  */
#define ID 258
#define INTEGER 259
#define FLOATER 260
#define STR 261
#define VOID 262
#define TYPE 263
#define INVALID 264
#define STATIC 265
#define NEW 266
#define FINAL 267
#define PUBLIC 268
#define PROTECTED 269
#define PRIVATE 270
#define CLASS 271
#define RETURN 272
#define WHILE 273
#define FOR 274
#define IF 275
#define ELSE 276
#define PRINT 277
#define READ 278
#define PLUS 279
#define MINUS 280
#define MULTIPLY 281
#define DIVIDE 282
#define LS 283
#define RS 284
#define LM 285
#define RM 286
#define LB 287
#define RB 288
#define EQUAL 289
#define COMMA 290
#define INFIXOP 291
#define DOT 292
#define DOUBLEPLUS 293
#define DOUBLEMINUS 294
#define NEWLINE 295
#define SEMICOLON 296
#define COMMENT 297

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 18 "B075020033.y"

    char* SVal;

#line 145 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
