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
  Nothing -> st
  Just f -> case (f St) of
   Nothing -> st
   Just st' -> st'
 
 search :: String -> St -> Maybe (St -> Maybe St)
 search w (St ns _) = go ns where
  go [] = Nothing
  go ((x, f) : ns') = case w == x of
   False -> go ns'
   True -> Just f

 data St = St NameSpace Stack

 type NameSpace = [(String, St -> Maybe St)]

 type Stack = [String]

 emptySt :: St
 emptySt 
