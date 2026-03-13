module Tokenizer (Operator(..), Token(..), tokenize) where

import Data.Char ( isDigit )

data Operator
  = Add
  | Subtract
  | Multiply
  | Divide
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
tokenize ('+' : cs) = tokenMap (TOperator Add) cs
tokenize ('-' : cs) = tokenMap (TOperator Subtract) cs
tokenize ('*' : cs) = tokenMap (TOperator Multiply) cs
tokenize ('/' : cs) = tokenMap (TOperator Divide) cs
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
