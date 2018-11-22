{-# LANGUAGE KindSignatures #-}

module Control.Arrow.Linear where

 import Prelude hiding (id, (.))

 import Control.Category

 -- | Linearly Distributive Category
 class Category cat => Lidis cat where

  type Tensor cat :: * -> * -> *

  type One cat :: *

  type Par cat :: * -> * -> *

  type Bottom :: *

  tmap :: cat a b -> cat c d -> cat (Tensor cat a c) (Tensor cat b d)

  tas :: cat (Tensor cat a (Tensor cat b c)) (Tensor cat (Tensor cat a b) c)

  til :: cat (Tensor cat (One cat) a) a

  tir :: cat (Tensor cat a (One cat)) a

  pmap :: (a -> b) -> (c -> d) -> Par cat a c -> Par cat b d

  pas :: cat (Par cat a (Par cat b c)) (Par cat (Par cat a b) c)

  pil :: cat (Tensor cat (One cat) a) a

  pir :: cat (Tensor cat a (One cat)) a
