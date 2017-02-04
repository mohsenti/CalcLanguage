%{
    #include "parser.tab.h"
    #include "parser_utils.h"
%}

%option outfile="scanner.c"
%option header-file="scanner.h"


%%

[ \r\n\t]+              ;
[a-zA-Z]+[a-zA-Z0-9]*   return checkId(yytext);
[0-9]+\.[0-9]+          return NUMBER;
[0-9]+                  return NUMBER;
[+,-]                   return LOwEST_PRIORITY_OPERATOR;
[%]                     return MIDDLE_PRIORITY_OPERATOR;
[*,/]                   return HIGHEST_PRIORITY_OPERATOR;
"="                     return ASSIGNMENT;

%%