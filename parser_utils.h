//
// Created by mohsen on 2/4/17.
//

#ifndef CALCLANGUAGE_PARSER_UTILS_H
#define CALCLANGUAGE_PARSER_UTILS_H

int yywrap(void);

int yyerror(char *error);

int checkId(char *id);

#endif //CALCLANGUAGE_PARSER_UTILS_H
