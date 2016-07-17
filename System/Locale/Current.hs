{-# LANGUAGE ForeignFunctionInterface #-}
module System.Locale.Current
  ( getDay
  , getABDay

  , getMon
  , getABMon

  , getAM
  , getPM

  , getDTFMT
  , getDFMT
  , getTFMT
  , getT12FMT

  , currentLocale
  )
where

import System.Locale (TimeLocale(..), defaultTimeLocale)

import Foreign.C.String (peekCString)
import Foreign.C.Types (CInt(..), CChar(..))
import Foreign.Ptr (Ptr)

foreign import ccall unsafe "get_day" get_day :: CInt -> IO (Ptr CChar)
foreign import ccall unsafe "get_abday" get_abday :: CInt -> IO (Ptr CChar)

foreign import ccall unsafe "get_mon" get_mon :: CInt -> IO (Ptr CChar)
foreign import ccall unsafe "get_abmon" get_abmon :: CInt -> IO (Ptr CChar)

foreign import ccall unsafe "get_am" get_am :: IO (Ptr CChar)
foreign import ccall unsafe "get_pm" get_pm :: IO (Ptr CChar)

foreign import ccall unsafe "get_d_t_fmt" get_d_t_fmt :: IO (Ptr CChar)

foreign import ccall unsafe "get_t_fmt" get_t_fmt :: IO (Ptr CChar)
foreign import ccall unsafe "get_d_fmt" get_d_fmt :: IO (Ptr CChar)

foreign import ccall unsafe "get_12h_fmt" get_12h_fmt :: IO (Ptr CChar)

foreign import ccall unsafe "prepare_locale" prepare_locale :: IO ()


getDay :: Int -> IO String
getDay i = peekCString =<< get_day (fromIntegral i)

getABDay :: Int -> IO String
getABDay i = peekCString =<< get_abday (fromIntegral i)

getMon :: Int -> IO String
getMon i = peekCString =<< get_mon (fromIntegral i)

getABMon :: Int -> IO String
getABMon i = peekCString =<< get_abmon (fromIntegral i)

getAM :: IO String
getAM = peekCString =<< get_am

getPM :: IO String
getPM = peekCString =<< get_pm

getDTFMT :: IO String
getDTFMT = peekCString =<< get_d_t_fmt

getDFMT :: IO String
getDFMT = peekCString =<< get_d_fmt

getTFMT :: IO String
getTFMT = peekCString =<< get_t_fmt

getT12FMT :: IO String
getT12FMT = peekCString =<< get_12h_fmt

currentLocale :: IO TimeLocale
currentLocale = do
  prepare_locale

  abDays <- mapM getABDay [1..7]
  days <- mapM getDay [1..7]

  abMons <- mapM getABMon [1..12]
  mons <- mapM getMon [1..12]

  am <- getAM
  pm <- getPM

  dt <- getDTFMT
  d <- getDFMT
  t <- getTFMT
  t12 <- getT12FMT

  return $ defaultTimeLocale
    { wDays = zip days abDays
    , months = zip mons abMons
    , amPm = (am, pm)
    , dateTimeFmt = dt
    , dateFmt = d
    , timeFmt = t
    , time12Fmt = t12
    }
