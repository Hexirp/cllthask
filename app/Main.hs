module Main where
 import Prelude

 main :: IO ()
 main = do
  input <- putStr "REPL> " >> hFlush stdout >> getLine

  unless (input == ":quit") $ putStrLn input >> main
