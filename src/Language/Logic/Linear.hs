module Language.Logic.Linear where
 import Prelude

 data Seq = Seq [Type] [Type]

 data Type
  = Time Type Type
  | Tiu
  | Para Type Type
  | Pau
  | Plus Type Type
  | Plu
  | With Type Type
  | Wiu
  | Ofco Type
  | Whno Type
  | Nega Type
