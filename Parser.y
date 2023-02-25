{
module Parser where

import Tokens
import Ast
}

%name parse
%tokentype { Token }
%error { parseError }

%token
    ident { IdentTok $$ }
    int   { IntTok $$ }
    float { FloatTok $$ }
    '+'   { AddTok }
    '-'   { SubTok }
    '*'   { StarTok }
    '/'   { SlashTok }
    '('   { OpenBracketTok }
    ')'   { CloseBracketTok }

%%

Expr : Expr '+' Term { BinOpExpr $1 Add $3 }
     | Expr '-' Term { BinOpExpr $1 Sub $3 }
     | Term          { $1 }

Term : Term '*' Factor { BinOpExpr $1 Mul $3 }
     | Term '/' Factor { BinOpExpr $1 Div $3 }
     | Factor          { $1 }

Factor : int          { IntLiteralExpr $1 }
       | float        { FloatLiteralExpr $1 }
       | '-' Factor   { UnaryOpExpr Negate $2 }
       | '(' Expr ')' { $2 }

{
parseError :: [Token] -> a
parseError = error "parsing failed"
}
