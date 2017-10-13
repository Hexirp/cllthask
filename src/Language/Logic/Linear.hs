module Language.Logic.Linear where
 import Prelude
 import Control.Arrow (second)

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

 plusR :: Bool -> Seq -> Maybe Seq
 plusR x (Seq (Plus a b : g) s)
  = Just $ Seq (case x of { False -> a; True -> b } : g) s
 plusR _ _ = Nothing

 withL :: Bool -> Seq -> Maybe Seq
 withL x (Seq g (With a b : s))
  = Just $ Seq g (case x of { False -> a; True -> b } : s)

 withR :: Seq -> Seq -> Maybe Seq
 withR (Seq g0 (a : s0)) (Seq g1 (b : s1)) = case g0 == g1 && s0 == s1 of
  False -> Nothing
  True -> Just $ Seq g0 (With a b : s0)

 pluR :: [Type] -> [Type] -> Seq
 pluR g s = Seq g (Plu : s)

 wiuL :: [Type] -> [Type] -> Seq
 wiuL g s = Seq (Wiu : g) s

 ofcoL :: Seq -> Maybe Seq
 ofcoL (Seq (a : g) s) = Just $ Seq (Ofco a : g) s
 ofcoL _ = Nothing

 ofcoR :: Seq -> Maybe Seq
 ofcoR (Seq [Ofco g] (a : [Whno s])) = Just $ Seq [Ofco g] (Ofco a : [Whno s])
 ofcoR _ = Nothing

 whnoL :: Seq -> Maybe Seq
 whnoL (Seq (a : [Ofco g]) [Whno s]) = Just $ Seq (Whno a : [Ofco g]) [Whno s]
 whnoL _ = Nothing

 whnoR :: Seq -> Maybe Seq
 whnoR (Seq g (a : s)) = Just $ Seq g (Whno a : s)
 whnoR _ = Nothing

 weakL :: Type -> Seq -> Seq
 weakL a (Seq g s) = Seq (Ofco a : g) s

 weakR :: Type -> Seq -> Seq
 weakR a (Seq g s) = Seq g (Whno a : s)

 copyL :: Seq -> Maybe Seq
 copyL (Seq (Ofco a : Ofco b : g) s) = case a == b of
  False -> Nothing
  True -> Just $ Seq (Ofco a : g) s
 copyL _ = Nothing

 copyR :: Seq -> Maybe Seq
 copyR (Seq g (Whno a : Whno b : s)) = case a == b of
  False -> Nothing
  True -> Just $ Seq g (Whno a : s)
 copyR _ = Nothing

 swapL :: Int -> Seq -> Maybe Seq
 swapL n (Seq g s) = (`Seq` s) <$> pop n g
 
 swapR :: Int -> Seq -> Maybe Seq
 swapR n (Seq g s) = (g `Seq`) <$> pop n s

 pop :: Int -> [a] -> Maybe [a]
 pop n0 x0 = uncurry (:) <$> pop' n0 x0 where
  pop' 0 [] = Nothing
  pop' 0 (x : xs) = Just (x, xs)
  pop' n (x : xs) = second (x :) <$> pop' (n - 1) xs
