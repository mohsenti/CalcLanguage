%{
    #include "parser.tab.h"
    #include "parser_utils.h"
%}

%option outfile="scanner.c"
%option header-file="scanner.h"


%%

[ \r\n\t]+              ;
[a-zA-Z]+[a-zA-Z0-9]*   yylval.strValue = strdup(yytext); return checkId(yytext);
[0-9]+\.[0-9]+          yylval.dValue = atof(yytext); return TOKEN_NUMBER;
[0-9]+                  yylval.dValue = atoi(yytext); return TOKEN_NUMBER;
[+,-]                   yylval.operator = yytext[0]; return TOKEN_LOwEST_PRIORITY_OPERATOR;
[%]                     yylval.operator = yytext[0]; return TOKEN_MIDDLE_PRIORITY_OPERATOR;
[*,/]                   yylval.operator = yytext[0]; return TOKEN_HIGHEST_PRIORITY_OPERATOR;
"="                     yylval.operator = '='; return TOKEN_ASSIGNMENT;

%%