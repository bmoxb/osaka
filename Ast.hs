module Ast where

import Numeric.Natural

data Stat = ExprStat Expr
          | LetStat String DataType Expr
          | IfStat Expr Block
          | IfElseStat Expr Block Block
          | FunctionStat String FunctionSig Block
          | RecordStat String [RecordMember]
          deriving (Show)

data Expr = AddExpr Expr Expr
          | SubExpr Expr Expr
          | MulExpr Expr Expr
          | DivExpr Expr Expr
          | NegateExpr Expr
          | IntLiteralExpr Int
          | FloatLiteralExpr Float
          | IdentExpr String
          | FunctionCallExpr String [Expr]
          | AnonFunctionExpr FunctionSig Block
          deriving (Show)

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
