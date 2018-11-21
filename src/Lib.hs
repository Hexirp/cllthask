module Lib 
 ( Once
 , wrapOnce
 ) where

 import Prelude

 import Control.Monad (join)
 import Control.Exception (Exception)
 import Control.Monad.STM
 import Control.Concurrent.STM.TVar

 import Data.IORef

 newtype Once a = UnsafeWrapOnce { unsafeUnwrapOnce :: IO a }

 wrapOnce :: a -> Once a
 wrapOnce a = UnsafeWrapOnce $ wrap a

 wrap :: a -> IO a
 wrap a = join $ wrap2 a <$> (newTVarIO False :: IO (TVar Bool))

 wrap1 :: a -> TVar Bool -> IO a
 wrap1 a ref = atomically $ wrap2 a ref

 wrap2 :: a -> TVar Bool -> STM a
 wrap2 a ref = join $ wrap3 a ref <$> readTVar ref

 wrap3 :: a -> TVar Bool -> Bool -> STM a
 wrap3 a ref False = const a <$> writeTVar ref True
 wrap3 a ref True  = throwSTM HasMovedError

 data HasMovedError = HasMovedError deriving Show

 instance Exception HasMovedError
