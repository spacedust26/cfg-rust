%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
%}

%union {
    int num;
    char* id;
}

%token <num> NUMBER
%token <id> ID
%token LET IF
%token EQ NEQ LE GE LT GT
%token ASSIGN PLUS MINUS MUL DIV
%token SEMICOLON LBRACE RBRACE LPAREN RPAREN

%left PLUS MINUS
%left MUL DIV

%%

Program:
    StmtList
;

StmtList:
    Stmt StmtList
    | /* empty */
;

Stmt:
    LetStmt
    | IfStmt
    | ExprStmt
;

LetStmt:
    LET ID ASSIGN Expr SEMICOLON
;

IfStmt:
    IF Condition Block
;

ExprStmt:
    Expr SEMICOLON
;

Condition:
    Expr RelOp Expr
;

RelOp:
    EQ | NEQ | LT | GT | LE | GE
;

Block:
    LBRACE StmtList RBRACE
;

Expr:
    Expr PLUS Term
    | Expr MINUS Term
    | Term
;

Term:
    Term MUL Factor
    | Term DIV Factor
    | Factor
;

Factor:
    NUMBER
    | ID
    | LPAREN Expr RPAREN
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
}

int main() {
    if (yyparse() == 0) {
        printf("Parsing successful.\n");
    } else {
        printf("Parsing failed.\n");
    }
    return 0;
}