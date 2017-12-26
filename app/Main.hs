module Main where
 import Prelude

 main :: IO ()
 main = getLine >>= putStrLn . check . foldMap parse

 data Expr = Expr String

 check :: Expr -> String
 check (Expr "true") = "OK!"
 check _             = "NG!"

 parse :: Char -> Expr
 parse = Expr . singleton

 instance Monoid Expr where
  mempty = Expr []

  mappend (Expr a) (Expr b) = Expr (mappend a b)

 singleton :: a -> [a]
 singleton a = [a]
