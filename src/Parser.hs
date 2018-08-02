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
  enchant (x : xs) = (',' : ' ' : x) : fmap (\x -> ' ' : ' ' : x) xs

 ppArgs'' :: Args -> [String]
 ppArgs'' = join . fmap ppFunc'
