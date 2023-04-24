module Main where

import Data.Maybe
import GHC.IO.Exception

import System.Environment
import System.IO.Error
import System.FilePath
import Control.Exception

handler :: IOError -> IO ()
handler e
  | isDoesNotExistError e = putStrLn $ "Error : File " <> baseName <> extName <> " not Found"
  | otherwise = ioError e
  where baseName = (takeBaseName . fromJust . ioeGetFileName) e
        extName = (takeExtension . fromJust . ioeGetFileName) e

trys :: IO ()
trys = getArgs                                     >>=
       (readFile . head)                           >>= \file ->
       putStrLn $ "The file has "                  <>
                   (show . length . lines) file    <>
                   " lines!"

main :: IO ()
main = catch trys handler
