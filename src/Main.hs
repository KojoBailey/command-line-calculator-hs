import Tokenizer

main :: IO ()
main = do
  putStrLn "Enter your calculation to compute:"
  putStr ">>> "
  input <- getLine
  print $ tokenize input
