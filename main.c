#include <stdio.h>
#include "scanner.h"
#include "parser.tab.h"

int dotIndex = 1;

void buildNodeDotTree(FILE *file, int parentIndex, ParserTreeNode *node) {
    int thisID = dotIndex++;
    fprintf(file, "\t%d -> %d \n", parentIndex, thisID);
    for (ParserTreeNode *i = node->firstChild; i != NULL; i = i->next) {
        buildNodeDotTree(file, thisID, i);
    }
}

void buildDotTree(char *fileName) {
    FILE *file = fopen(fileName, "w");
    fprintf(file, "digraph graphname {\n");
    buildNodeDotTree(file, 0, root);
    fprintf(file, "}");
}

int main() {
    yyin = fopen("example.calc", "r");
    yyparse();
    fclose(yyin);
    buildDotTree("parseTree.dot");
    return 0;
}