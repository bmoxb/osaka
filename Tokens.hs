module Tokens where

data Token = LetTok
           | FnTok
           | MutTok
           | RecordTok
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
           | ColonTok
           | SemicolonTok
           | CommaTok
           | AmpersandTok
           | ArrowTok
           deriving (Show)
