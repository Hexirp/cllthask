module Main where
 import Prelude

 main :: IO ()
 main = getLine >>= print . foldMap parse

 parse :: Char -> Expr
 parse 't' = Expr T T
 parse 'r' = Expr R R
 parse 'u' = Expr U U
 parse 'e' = Expr E E
 parse _   = Other

 data TRUE = T | R | U | E

 data Expr = Empty | Other | Expr TRUE TRUE

 instance Monoid Expr where
  mempty = Empty
  mappend Empty a = a
  mappend Other _ = Other
  mappend (Expr m n) (Expr o p) = case (n, o) of
   (T, R) -> Expr m p
   (R, U) -> Expr m p
   (U, E) -> Expr m p
   _      -> Other
  mappend _ Other = Other
  mappend a Empty = a

 instance Show Expr where
  show (Expr T E) = "Yes"
  show _    = "No"
