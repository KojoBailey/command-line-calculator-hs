module Evaluator (evaluate) where

import Parser

evaluate :: Expr -> Either String Double
evaluate (ExpNum n)        = Right n
evaluate (ExpBinOp l op r) = do
  l' <- evaluate l
  r' <- evaluate r
  (getBinOp op) l' r'
evaluate (ExpUnOp op v)    = do
  v' <- evaluate v
  (getUnOp op) v'

getBinOp :: BinOp -> (Double -> Double -> Either String Double)
getBinOp OpAdd = fmap Right . (+)
getBinOp OpSubtract = fmap Right . (-)
getBinOp OpMultiply = fmap Right . (*)
getBinOp OpDivide = safeDiv

safeDiv :: Double -> Double -> Either String Double
safeDiv _ 0 = Left "Division by zero."
safeDiv n d = Right $ n / d

getUnOp :: UnOp -> (Double -> Either String Double)
getUnOp OpNegative = Right . (* (-1))
