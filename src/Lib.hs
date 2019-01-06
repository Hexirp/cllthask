module Lib where

 import Prelude

 data Type =
  Atom String | Neg Type | Times Type Type | Par Type Type | One | Bottom

 data Tee = Tee Type Type

 data Tree =
  I Type
   | Cut Tee Tee
   | AssocT Type Type
