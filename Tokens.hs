module Tokens where

data Token = LetTok
           | IdentTok String
           | IntTok Int
           | FloatTok Float
           | AddTok
           | SubTok
           | StarTok
           | SlashTok
           | OpenBracketTok
           | CloseBracketTok
           | OpenCurlyTok
           | CloseCurlyTok
           | EqualsTok
           | SemicolonTok
           | CommaTok
           deriving (Show)
