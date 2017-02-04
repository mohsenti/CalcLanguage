%{
    #include "parser.tab.h"
    #include "parser_utils.h"
%}

%option outfile="scanner.c"
%option header-file="scanner.h"


%%

[ \r\n\t]+              ;
[a-zA-Z]+[a-zA-Z0-9]*   yylval.strValue = strdup(yytext); return checkId(yytext);
[0-9]+\.[0-9]+          yylval.dValue = atof(yytext); return NUMBER;
[0-9]+                  yylval.dValue = atoi(yytext); return NUMBER;
[+,-]                   yylval.operator = yytext[0]; return LOwEST_PRIORITY_OPERATOR;
[%]                     yylval.operator = yytext[0]; return MIDDLE_PRIORITY_OPERATOR;
[*,/]                   yylval.operator = yytext[0]; return HIGHEST_PRIORITY_OPERATOR;
"="                     yylval.operator = '='; return ASSIGNMENT;

%%