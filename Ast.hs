module Ast where

import Numeric.Natural

data Stat = ExprStat Expr
          | LetStat String Expr
          deriving (Show)

data Expr = BinOpExpr Expr BinOp Expr
          | UnaryOpExpr UnaryOp Expr
          | IntLiteralExpr Int
          | FloatLiteralExpr Float
          | IdentExpr String
          | FunctionCallExpr String [Expr]
          | BlockExpr [Stat] (Maybe Expr)
          deriving (Show)

data BinOp = Add | Sub | Mul | Div deriving (Show)

data UnaryOp = Negate deriving (Show)
