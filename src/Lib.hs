module Lib where

 import Prelude

 data Type =
  Atom String | Neg Type | Times Type Type | Par Type Type | One | Bottom

 data Tee = Tee Type Type

 data Tree =
  Cut Tree Tree
   | I Type
   | AssocTL Type Type Type -- (a * b) * c |- a * (b * c)
   | AssocTR Type Type Type -- a * (b * c) |- (a * b) * c
   | UnitTLL Type           -- 1 * a |- a
   | UnitTLR Type           -- a |- 1 * a
   | UnitTRL Type           -- a * 1 |- a
   | UnitTRR Type           -- a |- a * 1
   | AssocPL Type Type Type -- (a + b) + c |- ...
   | AssocPR Type Type Type
   | UnitPLL Type
   | UnitPLR Type
   | UnitPRL Type
   | UnitPRR Type
