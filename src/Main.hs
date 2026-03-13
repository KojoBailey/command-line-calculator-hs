import Tokenizer
import Parser
import Evaluator

main :: IO ()
main = do
  putStr ">>> "
  input <- getLine
  if input == ":q"
    then return ()

    else do
      case tokenize input of
        Left err  -> do
          printErr err
          main

        Right tokens -> do
          putStrLn "== Tokens =="
          print tokens
          case parse tokens of
            Left err  -> do
              printErr err
              main

            Right ast -> do
              newLine
              putStrLn "== Abstract Syntax Tree =="
              print ast
              case evaluate ast of
                Left err  -> do
                  printErr err
                  main

                Right res -> do
                  newLine
                  putStrLn "== Evaluation =="
                  print res
                  newLine
                  main
-- end main

newLine :: IO ()
newLine = putStrLn ""

printErr :: String -> IO ()
printErr err = putStrLn $ "\nERROR: " ++ err ++ "\n"
