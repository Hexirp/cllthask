module Main where
 import Prelude

 import Control.Monad (unless)
 
 import System.IO (hFlush, stdout)

 main :: IO ()
 main = do
  input <- putStr "REPL> " >> hFlush stdout >> getLine

  unless (input == ":quit") $ putStrLn input >> main
