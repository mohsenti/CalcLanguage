%{
    #include "parser.tab.h"
    #include "scanner.h"
    #include "parser_utils.h"
    #define YYDEBUG 1

%}

%define parse.error verbose
%debug
%defines
%locations

%union {
    char *strValue;
    char operator;
    double dValue;
    ParserTreeNode *node;
}

%token<operator> ASSIGNMENT LOwEST_PRIORITY_OPERATOR MIDDLE_PRIORITY_OPERATOR HIGHEST_PRIORITY_OPERATOR;
%token<strValue> ID ID_F
%token<dValue> NUMBER;
%type<node> S A E T F K E_list;

%%
    S: A S | %empty ;
    A: ID ASSIGNMENT E | E ;
    E: E LOwEST_PRIORITY_OPERATOR T | T;
    T: T MIDDLE_PRIORITY_OPERATOR F | F;
    F: F HIGHEST_PRIORITY_OPERATOR K | K;
    K: ID_F '(' E_list ')' | '(' E ')' | ID | NUMBER;
    E_list : E_list ',' E | E | %empty ;
%%