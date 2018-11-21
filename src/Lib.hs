module Lib where

 import Prelude

 import Control.Monad (join)
 import Control.Exception (Exception)

 import Control.DeepSeq

 import Control.Monad.STM
 import Control.Concurrent.STM.TVar

 newtype Once a = UnsafeWrapOnce { unsafeUnwrapOnce :: IO a }

 wrapOnce :: a -> IO (Once a)
 wrapOnce a = wrapOnce_0 a

 wrapOnce_0 :: a -> IO (Once a)
 wrapOnce_0 a = wrapOnce_1 a <$> newTVarIO False

 wrapOnce_1 :: a -> TVar Bool -> Once a
 wrapOnce_1 a ref = UnsafeWrapOnce $ wrapOnce_2 a ref

 wrapOnce_2 :: a -> TVar Bool -> IO a
 wrapOnce_2 a ref = atomically $ wrapOnce_3 a ref

 wrapOnce_3 :: a -> TVar Bool -> STM a
 wrapOnce_3 a ref = join $ wrapOnce_4 a ref <$> readTVar ref

 wrapOnce_4 :: a -> TVar Bool -> Bool -> STM a
 wrapOnce_4 a ref False = const a <$> writeTVar ref True
 wrapOnce_4 a ref True  = throwSTM HasMovedError

 wrapOnceStrict :: NFData a => a -> IO (Once a)
 wrapOnceStrict a = join $ evaluate . deepseq a <$> wrapOnce a

 data HasMovedError = HasMovedError deriving Show

 instance Exception HasMovedError
