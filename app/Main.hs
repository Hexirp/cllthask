module Main where

 import Prelude

 import Lib

 main :: IO ()
 main = do
  a <- wrapOnce 1

  a1 <- unsafeUnwrapOnce a
  print a1
  a2 <- unsafeUnwrapOnce a
  print a2
