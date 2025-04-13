# Context Free Grammar for Rust using Flex and Bison
 
### Grammar
```
Program         → StmtList
StmtList        → Stmt StmtList | ε
Stmt            → LetStmt | IfStmt | ExprStmt
LetStmt         → "let" ID "=" Expr ";"
IfStmt          → "if" Condition Block
ExprStmt        → Expr ";"
Block           → "{" StmtList "}"
Condition       → Expr RelOp Expr
RelOp           → "==" | "!=" | "<" | ">" | "<=" | ">="
Expr            → Term ExprTail
ExprTail        → "+" Term ExprTail | "-" Term ExprTail | ε
Term            → Factor TermTail
TermTail        → "*" Factor TermTail | "/" FactorTermTail | ε
Factor          → NUMBER | ID | "(" Expr ")"
```

### How to run the program
```
bison -d parser.y
flex lexer.l
gcc lex.yy.c parser.tab.c -o output
./output < input.txt
```