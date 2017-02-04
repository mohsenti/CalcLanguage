//
// Created by mohsen on 2/4/17.
//

#ifndef CALCLANGUAGE_PARSER_UTILS_H
#define CALCLANGUAGE_PARSER_UTILS_H

typedef enum ParserTreeNodeType ParserTreeNodeType;
enum ParserTreeNodeType {
    INVALID,
    FUNCTION,
    VARIABLE,
    ASSIGNMENT,
    OPERATOR,
    VALUE,
    FAKE
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
    ParserTreeNodeType type;
    ParserTreeNodeData data;
    ParserTreeNode *firstChild, *lastChild;
    ParserTreeNode *next;
};

ParserTreeNode *createNode(ParserTreeNodeType type);

void addChild(ParserTreeNode *root, ParserTreeNode *child);

void releaseNode(ParserTreeNode *node);

int yywrap(void);

int yyerror(const char *error);

int checkId(char *id);

#endif //CALCLANGUAGE_PARSER_UTILS_H
