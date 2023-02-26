{
module Lexer where
import Tokens
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]

tokens :-
    $white+                    ;
    "//".*                     ;
    "let"                      { \s -> LetTok }
    "fn"                       { \s -> FnTok }
    "mut"                      { \s -> MutTok }
    "record"                   { \s -> RecordTok }
    $alpha [$alpha $digit \_]* { \s -> IdentTok s }
    $digit+ \. $digit+         { \s -> FloatTok (read s) }
    $digit+                    { \s -> IntTok (read s) }
    \+                         { \s -> AddTok }
    \-                         { \s -> SubTok }
    \*                         { \s -> StarTok }
    \/                         { \s -> SlashTok }
    \(                         { \s -> OpenBracketTok }
    \)                         { \s -> CloseBracketTok }
    \{                         { \s -> OpenCurlyTok }
    \}                         { \s -> CloseCurlyTok }
    =                          { \s -> EqualsTok }
    \:                         { \s -> ColonTok }
    \;                         { \s -> SemicolonTok }
    \,                         { \s -> CommaTok }
    &                          { \s -> AmpersandTok }
    \->                        { \s -> ArrowTok }
