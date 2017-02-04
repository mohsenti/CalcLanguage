//
// Created by mohsen on 2/4/17.
//

#include <stdio.h>
#include <string.h>
#include <malloc.h>
#include "parser_utils.h"
#include "parser.tab.h"

#ifdef yywrap
#undef yywrap
#endif


ParserTreeNode *createNode(ParserTreeNodeType type) {
    ParserTreeNode *node = malloc(sizeof(ParserTreeNode));
    node->firstChild = NULL;
    node->lastChild = NULL;
    node->next = NULL;
    node->type = type;
    return node;
}

void addChild(ParserTreeNode *root, ParserTreeNode *child) {
    if (root->lastChild == NULL) {
        root->firstChild = child;
        root->lastChild = child;
    } else {
        root->lastChild->next = child;
        root->lastChild = child;
    }
}

void releaseNode(ParserTreeNode *node) {
    free(node);
}

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
        return TOKEN_ID_F;
    return TOKEN_ID;
}

