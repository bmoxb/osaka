{
module Parser where

import Tokens
import Ast
}

%name parse
%tokentype { Token }
%error { parseError }

%token
    let   { LetTok }
    ident { IdentTok $$ }
    int   { IntTok $$ }
    float { FloatTok $$ }
    '+'   { AddTok }
    '-'   { SubTok }
    '*'   { StarTok }
    '/'   { SlashTok }
    '('   { OpenBracketTok }
    ')'   { CloseBracketTok }
    '='   { EqualsTok }
    ';'   { SemicolonTok }
    ','   { CommaTok }

%left '+' '-'
%left '*' '/'

%%

Stat : Expr ';'               { ExprStat $1 }
     | let ident '=' Expr ';' { LetStat $2 $4 }

Expr : Expr '+' Expr       { BinOpExpr $1 Add $3 }
     | Expr '-' Expr       { BinOpExpr $1 Sub $3 }
     | Expr '*' Expr       { BinOpExpr $1 Mul $3 }
     | Expr '/' Expr       { BinOpExpr $1 Div $3 }
     | int                 { IntLiteralExpr $1 }
     | float               { FloatLiteralExpr $1 }
     | '-' Expr            { UnaryOpExpr Negate $2 }
     | '(' Expr ')'        { $2 }
     | ident               { IdentExpr $1 }
     | ident '(' ')'       { FunctionCallExpr $1 [] }
     | ident '(' Exprs ')' { FunctionCallExpr $1 $3 }

Exprs : Expr           { [$1] }
      | Expr ',' Exprs { $1:$3 }

{
parseError :: [Token] -> a
parseError = error "parsing failed"
}
