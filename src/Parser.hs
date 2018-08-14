module Parser where
 import Prelude

 import Control.Monad (join)

 type Tree = Func

 data Func = Func String Args

 type Args = [Tree]

 ppTree :: Tree -> String
 ppTree = ppFunc

 ppFunc :: Func -> String
 ppFunc = unlines . ppFunc'

 ppFunc' :: Func -> [String]
 ppFunc' (Func func args) = func : ppArgs' args

 ppArgs :: Args -> String
 ppArgs = unlines . ppArgs''

 ppArgs' :: Args -> [String]
 ppArgs' = enchant . ppArgs'' where
  enchant [] = []
  enchant (x : xs) = (',' : ' ' : x) : map (\x -> ' ' : ' ' : x) xs

 ppArgs'' :: Args -> [String]
 ppArgs'' = concat . map ppFunc'

 paTree :: String -> Tree
 paTree = paFunc

 paFunc :: String -> Func
 paFunc = paFunc' . lines

 paFunc' :: [String] -> Func
 paFunc' (func : args) = Func func (paArgs' args)

 paArgs' :: Args -> [String]
 paArgs' = ppArgs'' . enchant where
  enchant [] = []
  enchant (x : xs) = undefined
 
 paArgs'' :: Args -> [String]
 paArgs'' = undefined
