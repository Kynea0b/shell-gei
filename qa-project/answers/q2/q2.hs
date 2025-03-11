{-# LANGUAGE OverloadedStrings #-}

import System.Environment (getArgs, getExecutablePath)
import System.Directory (getCurrentDirectory, doesFileExist, getDirectoryContents)
import System.FilePath ((</>), takeDirectory, normalise)
import Data.Text (Text, pack, unpack, lines, isInfixOf, unlines)
import Data.Text.IO as TIO (putStrLn)
import Control.Monad (forM_, forM_)
import qualified Data.Text as T
import Data.List (findIndices)

main :: IO ()
main = do
  args <- getArgs
  executablePath <- getExecutablePath
  currentDir <- getCurrentDirectory
  let scriptDir = takeDirectory executablePath
      dataDir = normalise (scriptDir </> "../data")
  if not (null args)
    then findAndGrep dataDir (head args)
    else Prelude.putStrLn "検索文字列を指定してください。"

findAndGrep :: FilePath -> String -> IO ()
findAndGrep dir searchStr = do
  contents <- getDirectoryContents dir
  forM_ contents $ \file -> do
    let filePath = dir </> file
    isFile <- doesFileExist filePath
    if isFile
      then grepFile filePath searchStr
      else return ()

grepFile :: FilePath -> String -> IO ()
grepFile filePath searchStr = do
  fileContents <- readFile filePath
  let textContents = pack fileContents
      search = pack searchStr
      allLines = T.lines textContents
      matchingLines = filter (isInfixOf search) allLines
      matchingIndices = findIndices (isInfixOf search) allLines

  if not (null matchingLines)
    then do
      TIO.putStrLn ("ファイル: " <> pack filePath)
      forM_ (zip matchingIndices matchingLines) $ \(index, line) ->
        TIO.putStrLn (pack (show (index + 1)) <> ": " <> line)
    else TIO.putStrLn ("ファイル: " <> pack filePath <> " に " <> pack searchStr <> " は見つかりませんでした。")