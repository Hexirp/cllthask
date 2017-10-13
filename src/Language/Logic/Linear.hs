module Language.Logic.Linear where
 import Prelude

 data Seq = Seq [Type] [Type] deriving Eq

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
  deriving Eq

 init :: Type -> Seq
 init a = Seq [a] [a]

 cut :: Seq -> Seq -> Maybe Seq
 cut (Seq g0 (a : s0)) (Seq (b : g1) s1) = case a == b of
  False -> Nothing
  True -> Just $ Seq (g0 ++ g1) (s0 ++ s1)
 cut _ _ = Nothing

 timeL :: Seq -> Maybe Seq
 timeL (Seq (a : b : g) s) = Just $ Seq (Time a b : g) s
 timeL _ = Nothing

 timeR :: Seq -> Seq -> Maybe Seq
 timeR (Seq g0 (a : s0)) (Seq g1 (b : s1))
  = Just $ Seq (g0 ++ g1) (Time a b : s0 ++ s1)
 timeR _ _ = Nothing

 paraL :: Seq -> Seq -> Maybe Seq
 paraL (Seq (a : g0) s0) (Seq (b : g1) s1)
  = Just $ Seq (Para a b : g0 ++ g1) (s0 ++ s1)
 paraL _ _ = Nothing

 paraR :: Seq -> Maybe Seq
 paraR (Seq g (a : b : s)) = Just $ Seq g (Para a b : s)
 paraR _ = Nothing

 tiuL :: Seq -> Seq
 tiuL (Seq g s) = Seq (Tiu : g) s

 tiuR :: Seq
 tiuR = Seq [] [Tiu]

 pauL :: Seq
 pauL = Seq [Pau] []

 pauR :: Seq -> Seq
 pauR (Seq g s) = Seq g (Pau : s)

 plusL :: Seq -> Seq -> Maybe Seq
 plusL (Seq (a : g0) s0) (Seq (b : g1) s1) = case g0 == g1 && s0 == s1 of
  False -> Nothing
  True -> Just $ Seq (Plus a b : g0) s0
 plusL _ _ = Nothing
