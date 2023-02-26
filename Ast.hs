module Ast where

import Numeric.Natural

data Stat = ExprStat Expr
          | LetStat String DataType Expr
          | FunctionStat String FunctionSig Block
          | RecordStat String [RecordMember]
          deriving (Show)

data Expr = BinOpExpr Expr BinOp Expr
          | UnaryOpExpr UnaryOp Expr
          | IntLiteralExpr Int
          | FloatLiteralExpr Float
          | IdentExpr String
          | FunctionCallExpr String [Expr]
          | AnonFunctionExpr FunctionSig Block
          deriving (Show)

data BinOp = Add | Sub | Mul | Div deriving (Show)

data UnaryOp = Negate deriving (Show)

data DataType = IdentType String
              | PtrType Mutability DataType
              | TupleType [DataType]
              | FunctionType [DataType] (Maybe DataType)
              deriving (Show)

data Mutability = Mutable | Immutable deriving (Show)

type FunctionSig = ([Parameter], Maybe DataType)

type Block = ([Stat], Maybe Expr)

type RecordMember = (String, DataType)

type Parameter = (Mutability, String, DataType)
