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
    $alpha [$alpha $digit \_]* { \s -> IdentTok s }
    $digit+ \. $digit+         { \s -> FloatTok (read s) }
    $digit+                    { \s -> IntTok (read s) }
    \+                         { \s -> AddTok }
    \-                         { \s -> SubTok }
    \*                         { \s -> StarTok }
    \/                         { \s -> SlashTok }
    \(                         { \s -> OpenBracketTok }
    \)                         { \s -> CloseBracketTok }
