%{
    #include "parser.tab.h"
    #include "scanner.h"
    #include "parser_utils.h"
    #define YYDEBUG 1

%}

%token  ID NUMBER ID_F ASSIGNMENT LOwEST_PRIORITY_OPERATOR MIDDLE_PRIORITY_OPERATOR HIGHEST_PRIORITY_OPERATOR

%define parse.error verbose
%debug
%defines
%locations

%%
    S: A S | %empty ;
    A: ID ASSIGNMENT E | E ;
    E: E LOwEST_PRIORITY_OPERATOR T | T;
    T: T MIDDLE_PRIORITY_OPERATOR F | F;
    F: F HIGHEST_PRIORITY_OPERATOR K | K;
    K: ID_F '(' E_list ')' | '(' E ')' | ID | NUMBER;
    E_list : E_list ',' E | E | %empty ;
%%