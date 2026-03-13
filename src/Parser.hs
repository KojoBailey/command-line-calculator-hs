{-# LANGUAGE LambdaCase #-}

module Parser (Expr(..), BinOp(..), UnOp(..), parse) where

import Tokenizer

data Expr
  = ExpBinOp Expr BinOp Expr
  | ExpUnOp UnOp Expr 
  | ExpNum Double
  deriving (Show)

data BinOp
  = OpAdd
  | OpSubtract
  | OpMultiply
  | OpDivide
  deriving (Show)

data UnOp
  = OpNegative
  deriving (Show)

type ParseResult = Either String (Expr, [Token])

parse :: [Token] -> Either String Expr
parse tokens = parseL1 tokens >>= \case
  (expr, []) -> Right expr  
  (_, rest)  -> Left $ "Could not parse tokens: " ++ show rest

-- Addition & Subtraction
parseL1 :: [Token] -> ParseResult
parseL1 ts = parseL2 ts >>= parseL1Rest

parseL1Rest :: (Expr, [Token]) -> ParseResult
parseL1Rest (left, (TOperator Plus  : ts)) = parseL2 ts >>= \(expr, rest) -> parseL1Rest (ExpBinOp left OpAdd expr, rest)
parseL1Rest (left, (TOperator Minus : ts)) = parseL2 ts >>= \(expr, rest) -> parseL1Rest (ExpBinOp left OpSubtract expr, rest)
parseL1Rest (left, ts)                     = Right (left, ts)

-- Multiplication & Division
parseL2 :: [Token] -> ParseResult
parseL2 ts = parseL3 ts >>= parseL2Rest

parseL2Rest :: (Expr, [Token]) -> ParseResult
parseL2Rest (left, (TOperator Asterisk : ts)) = parseL3 ts >>= \(expr, rest) -> parseL2Rest (ExpBinOp left OpMultiply expr, rest)
parseL2Rest (left, (TOperator Slash    : ts)) = parseL3 ts >>= \(expr, rest) -> parseL2Rest (ExpBinOp left OpDivide expr, rest)
parseL2Rest (left, ts)                        = Right (left, ts)

-- Parentheses, Unary negative, Number literal
parseL3 :: [Token] -> ParseResult
parseL3 (TParenthesisOpen : ts) = parseL1 ts >>= \(expr, rest) -> case rest of
  (TParenthesisClose : rest') -> Right (expr, rest')
  _                           -> Left "Missing closing parenthesis."
parseL3 (TOperator Minus  : ts) = parseL3 ts >>= \(expr, rest) -> Right (ExpUnOp OpNegative expr, rest)
parseL3 (TNumber n        : ts) = Right (ExpNum n, ts)
parseL3 []                      = Left "Unexpected end of expression."
parseL3 (t                : _ ) = Left $ "Unexpected token: " ++ show t
