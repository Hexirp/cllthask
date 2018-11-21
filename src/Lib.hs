module Lib 
 ( Once
 , wrap
 ) where

 import Prelude

 import Control.Monad (join)

 import Data.IORef

 import Control.Exception

 newtype Once a = UnsafeWrapOnce { unsafeUnwrapOnce :: IO a }

 wrap :: a -> Once a
 wrap a = UnsafeWrapOnce $ wrap1 a

 wrap1 :: a -> IO a
 wrap1 a = join $ wrap2 a <$> newIORef False

 wrap2 :: a -> IORef Bool -> IO a
 wrap2 a ref = join $ wrap3 a ref <$> readIORef ref

 wrap3 :: a -> IORef Bool -> Bool -> IO a
 wrap3 a ref False = const a <$> writeIORef ref True
 wrap3 a ref True  = throwIO $ HasDroppedError

 data HasDroppedError = HasDroppedError

 instance Exception HasDroppedError
