module Main where
 import Prelude

 main :: IO ()
 main = getLine >>= print . foldMap parse

 parse :: Char -> Expr
 parse '1' = Head
 parse '0' = Other
 parse _   = Invaid

 data Expr = Head | Other | Invaid

 instance Monoid Expr where
  mempty = Other
  mappend Head Head = Head
  mappend Head Other = Head
  mappend Head Invaid = Invaid
  mappend Other Head = Other
  mappend Other Other = Other
  mappend Other Invaid = Invaid
  mappend Invaid Head = Invaid
  mappend Invaid Other = Invaid
  mappend Invaid Invaid = Invaid

 instance Show Expr where
  show Head = "Yes"
  show _    = "No"
