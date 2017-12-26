module Main where
 import Prelude

 import Data.Proxy (Proxy(Proxy))

 main :: IO ()
 main = getLine >>= print . parse (Proxy :: Proxy Expr)

 data Expr = Expr String

 instance Monoid Expr where
  mempty = Expr []

  mappend (Expr a) (Expr b) = Expr (mappend a b)

 instance Parser Expr where
  trans = Expr . singleton

  check (Expr "true") = True
  check _             = False

 class Monoid a => Parser a where
  trans :: Char -> a
  check :: a -> Bool

  parse :: Proxy a -> String -> Bool
  parse p = check . is p . foldMap trans where
   is :: Proxy a -> a -> a
   is _ = id

 singleton :: a -> [a]
 singleton a = [a]
