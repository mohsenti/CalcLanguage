#include <stdio.h>
#include "scanner.h"
#include "parser.tab.h"

int main() {
    yyin = fopen("example.calc", "r");
    //do {
    yyparse();
    //} while (!feof(yyin));
    fclose(yyin);
    return 0;
}