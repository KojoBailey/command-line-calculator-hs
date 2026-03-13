module Tokenizer (Operator(..), Token(..), tokenize) where

import Data.Char ( isDigit )

data Operator
  = Plus
  | Minus
  | Asterisk
  | Slash
  deriving (Show, Eq)

data Token
  = TNumber Double -- Easier to just evaluate one number type
  | TOperator Operator
  | TParenthesisOpen
  | TParenthesisClose
  deriving (Show, Eq)

tokenize :: String -> Either String [Token]
tokenize [] = Right []
tokenize (' ' : cs) = tokenize cs
tokenize ('(' : cs) = tokenMap TParenthesisOpen cs
tokenize (')' : cs) = tokenMap TParenthesisClose cs
tokenize ('+' : cs) = tokenMap (TOperator Plus) cs
tokenize ('-' : cs) = tokenMap (TOperator Minus) cs
tokenize ('*' : cs) = tokenMap (TOperator Asterisk) cs
tokenize ('/' : cs) = tokenMap (TOperator Slash) cs
tokenize (c:cs)
  | isDigit c = let (num, remaining) = parseNum (c:cs)
                in tokenMap (TNumber num) remaining
  | otherwise = Left $ "Invalid token: " ++ [c]

tokenMap :: Token -> String -> Either String [Token]
tokenMap token cs = fmap (token :) (tokenize cs)

-- Does not check for invalid input.
parseNum :: String -> (Double, String)
parseNum input = (read (takeWhile isNumLiteral input) :: Double, dropWhile isNumLiteral input)
  where isNumLiteral = (`elem` '.' : ['0'..'9'])
