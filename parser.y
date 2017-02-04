%{
    #include "parser.tab.h"
    #include "scanner.h"
    #define YYDEBUG 1

%}

%define parse.error verbose
%debug
%defines
%locations
%define api.token.prefix {TOKEN_}

%code requires { #include "parser_utils.h" }

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
    S: A S { if ($2 == NULL) { $$ = createNode(EXPRESSION_LIST); } else { $$ = $2; } addChild($$,$1); } | %empty { $$ = NULL ; };
    A: ID ASSIGNMENT E { $$ = createNode(ASSIGNMENT); $$->data.Id = $1; addChild($$,$3); }
        | E { $$ = createNode(FAKE); addChild($$,$1); };
    E: E LOwEST_PRIORITY_OPERATOR T { $$ = createNode(OPERATOR); $$->data.operator = $2; addChild($$,$1); addChild($$,$3);}
        | T{ $$ = createNode(FAKE); addChild($$,$1); };
    T: T MIDDLE_PRIORITY_OPERATOR F { $$ = createNode(OPERATOR); $$->data.operator = $2; addChild($$,$1); addChild($$,$3);}
        | F{ $$ = createNode(FAKE); addChild($$,$1); };
    F: F HIGHEST_PRIORITY_OPERATOR K { $$ = createNode(OPERATOR); $$->data.operator = $2; addChild($$,$1); addChild($$,$3);}
        | K { $$ = createNode(FAKE); addChild($$,$1); };
    K: ID_F '(' E_list ')' { $$ = createNode(FUNCTION); $$->data.functionName = $1; addChild($$,$3); }
        | '(' E ')' { $$ = createNode(FAKE); addChild($$,$2); }
        | ID { $$ = createNode(VARIABLE); $$->data.Id = $1; }
        | NUMBER { $$ = createNode(VALUE); $$->data.dValue = $1; };
    E_list : E_list ',' E {
            if ($1 == NULL) {
                $$ = createNode(VALUE_LIST);
            } else {
                $$ = $1;
            }
            addChild($$,$3);
        }
        | E { $$ = createNode(FAKE); addChild($$,$1); }
        | %empty { $$ = NULL; };
%%