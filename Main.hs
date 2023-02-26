module Main where

import System.Environment

import Lexer
import Parser
import Ast

main = do
    args <- getArgs
    text <- getInput args
    print (toAst text)

getInput :: [String] -> IO String
getInput (f:_) = readFile f
getInput _ = getLine

toAst :: String -> [Stat]
toAst = parse . alexScanTokens
