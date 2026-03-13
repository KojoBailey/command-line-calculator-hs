module Parser (AST(..), BinOp(..), UnOp(..), parse) where

import Tokeninzer

type AST = Expr

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

-- parse :: [Token] -> Either String AST
-- parse (t:ts) =  
