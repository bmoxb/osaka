module Main where

import System.Environment

import Lexer
import Parser
import Ast

main = do
    args <- getArgs
    text <- readFile (last args)
    print (toAst text)

toAst :: String -> Expr
toAst = parse . alexScanTokens
