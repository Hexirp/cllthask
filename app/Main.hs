module Main where
 import Prelude

 main :: IO ()
 main = getLine >>= print . foldMap parse

 parse :: Char -> Expr
 parse '(' = Expr 0 1
 parse ')' = Expr 1 0
 parse _   = Expr 0 0

 data Expr = Expr Int Int

 instance Monoid Expr where
  mempty = Expr 0 0
  mappend (Expr m n) (Expr o p) = case compare n o of
   LT -> Expr (o - n + m) p
   EQ -> Expr m p
   GT -> Expr m (n - o + p)

 instance Show Expr where
  show (Expr 0 0) = "Yes"
  show _          = "No"
