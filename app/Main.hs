module Main where
 import Prelude

 main :: IO ()
 main = main0 emptySt

 main0 :: St -> IO ()
 main0 st = getLine >>= next . foldr run st . words

 next :: St -> IO ()
 next st = show st >> main0 st

 run :: String -> St -> St
 run w st = case search w st of
  Nothing -> failureSt
  Just f -> f St
