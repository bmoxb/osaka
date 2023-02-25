module Ast where

import Numeric.Natural

data Expr = BinOpExpr Expr BinOp Expr
          | UnaryOpExpr UnaryOp Expr
          | IntLiteralExpr Int
          | FloatLiteralExpr Float
          deriving (Show)

data BinOp = Add | Sub | Mul | Div deriving (Show)

data UnaryOp = Negate deriving (Show)
