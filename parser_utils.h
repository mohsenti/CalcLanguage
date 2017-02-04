//
// Created by mohsen on 2/4/17.
//

#ifndef CALCLANGUAGE_PARSER_UTILS_H
#define CALCLANGUAGE_PARSER_UTILS_H

enum ParserTreeNodeType {
    INVALID,
    FUNCTION,
    VARIABLE,
    ASSIGNMENT,
    OPERATOR,
    VALUE
};

typedef union ParserTreeNodeData ParserTreeNodeData;
union ParserTreeNodeData {
    double dValue;
    char operator;
    char *Id;
    char *functionName;
};


typedef struct ParserTreeNode ParserTreeNode;
struct ParserTreeNode {
    double value;
    int type;
    ParserTreeNodeData data;
    ParserTreeNode *firstChild;
    ParserTreeNode *next, *last;
};

ParserTreeNode *createNode();

void addChild(ParserTreeNode *root, ParserTreeNode *child);

void releaseNode(ParserTreeNode *node);

int yywrap(void);

int yyerror(const char *error);

int checkId(char *id);

#endif //CALCLANGUAGE_PARSER_UTILS_H
