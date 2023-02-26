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
    fn    { FnTok }
    mut   { MutTok }
    ident { IdentTok $$ }
    int   { IntTok $$ }
    float { FloatTok $$ }
    '+'   { AddTok }
    '-'   { SubTok }
    '*'   { StarTok }
    '/'   { SlashTok }
    '('   { OpenBracketTok }
    ')'   { CloseBracketTok }
    '{'   { OpenCurlyTok }
    '}'   { CloseCurlyTok }
    '='   { EqualsTok }
    ':'   { ColonTok }
    ';'   { SemicolonTok }
    ','   { CommaTok }
    '&'   { AmpersandTok }
    '->'  { ArrowTok }

%left '+' '-'
%left '*' '/'
%left ident
%left '('

%%

Stat : Expr ';'                            { ExprStat $1 }
     | let ident ':' DataType '=' Expr ';' { LetStat $2 $4 $6 }
     | fn ident FunctionSig Block          { FunctionStat $2 $3 $4 }

FunctionSig : '(' ')'                      { ([], Nothing) }
            | '(' ')' '->' DataType        { ([], Just $4) }
            | '(' Params ')'               { ($2, Nothing) }
            | '(' Params ')' '->' DataType { ($2, Just $5) }

Block : '{' '}'            { ([], Nothing) }
      | '{' Stats '}'      { ($2, Nothing) }
--      | '{' Stats Expr '}' { ($2, Just $3) }

Stats : Stat       { [$1] }
      | Stat Stats { $1:$2 }

Param : ident ':' DataType     { (Immutable, $1, $3) }
      | mut ident ':' DataType { (Mutable, $2, $4) }

Params : Param            { [$1] }
       | Param ',' Params { $1:$3 }

DataType : ident                              { IdentType $1 }
         | '&' DataType                       { PtrType Immutable $2 }
         | '&' mut DataType                   { PtrType Mutable $3 }
         | '(' ')'                            { TupleType [] }
         | '(' DataTypes ')'                  { TupleType $2 }
         | fn '(' ')'                         { FunctionType [] Nothing }
         | fn '(' ')' '->' DataType           { FunctionType [] (Just $5) }
         | fn '(' DataTypes ')'               { FunctionType $3 Nothing }
         | fn '(' DataTypes ')' '->' DataType { FunctionType $3 (Just $6) }

DataTypes : DataType               { [$1] }
          | DataType ',' DataTypes { $1:$3 }

Expr : Expr '+' Expr        { BinOpExpr $1 Add $3 }
     | Expr '-' Expr        { BinOpExpr $1 Sub $3 }
     | Expr '*' Expr        { BinOpExpr $1 Mul $3 }
     | Expr '/' Expr        { BinOpExpr $1 Div $3 }
     | int                  { IntLiteralExpr $1 }
     | float                { FloatLiteralExpr $1 }
     --| '-' Expr            { UnaryOpExpr Negate $2 }
     | '(' Expr ')'         { $2 }
     | ident                { IdentExpr $1 }
     | ident '(' ')'        { FunctionCallExpr $1 [] }
     | ident '(' Exprs ')'  { FunctionCallExpr $1 $3 }
     | fn FunctionSig Block { AnonFunctionExpr $2 $3 }

Exprs : Expr           { [$1] }
      | Expr ',' Exprs { $1:$3 }

{
parseError :: [Token] -> a
parseError = error "parsing failed"
}
