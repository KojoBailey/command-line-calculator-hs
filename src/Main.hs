import Tokenizer
import Parser
import Evaluator

import Control.Monad ( when )
import Control.Monad.Except ( ExceptT, runExceptT, liftEither )
import Control.Monad.IO.Class (liftIO)

type App a = ExceptT String IO a

main :: IO ()
main = do
  putStr ">>> "
  input <- getLine
  when (input /= ":q") $ do
    runExceptT (step input) >>= either printErr return
    main

step :: String -> App ()
step input = do
    tokens <- liftEither (tokenize input)
    liftIO $ do
      putStrLn "== Tokens =="
      print tokens

    ast <- liftEither (parse tokens)
    liftIO $ do
      newLine
      putStrLn "== Abstract Syntax Tree =="
      print ast

    result <- liftEither (evaluate ast)
    liftIO $ do
      newLine
      putStrLn "== Evaluation =="
      print result
      newLine

newLine :: IO ()
newLine = putStrLn ""

printErr :: String -> IO ()
printErr err = putStrLn $ "\nERROR: " ++ err ++ "\n"
