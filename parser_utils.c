//
// Created by mohsen on 2/4/17.
//

#include <stdio.h>
#include <string.h>
#include "parser_utils.h"
#include "parser.tab.h"

#ifdef yywrap
#undef yywrap
#endif

int yywrap(void) {
    return 1;
}

int yyerror(const char *error) {
    printf("%d-%d:%s\n", yylloc.first_line, yylloc.first_column, error);
    return 0;
}

int checkId(char *id) {
    if (strcmp(id, "sin") == 0 || strcmp(id, "cos") == 0 || strcmp(id, "tan") == 0 || strcmp(id, "cot") == 0 ||
        strcmp(id, "log") == 0)
        return ID_F;
    return ID;
}