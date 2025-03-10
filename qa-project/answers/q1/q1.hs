import System.Directory (listDirectory, doesFileExist)
import System.FilePath ((</>), takeExtension)

-- 指定されたパスと拡張子に一致するファイルパスをリストアップする関数
findFiles :: FilePath -> String -> IO [FilePath]
findFiles path extension = do
  entries <- listDirectory path
  let filePaths = map (path </>) entries
  filterM (\filePath -> do
    isFile <- doesFileExist filePath
    return (isFile && takeExtension filePath == extension)) filePaths

-- filterM関数を定義 (Control.Monadモジュールに存在)
filterM :: (Monad m) => (a -> m Bool) -> [a] -> m [a]
filterM _ [] = return []
filterM p (x:xs) = do
  result <- p x
  rest <- filterM p xs
  return $ if result then x:rest else rest

main :: IO ()
main = do
  let path = "." -- カレントディレクトリを検索
      extension = ".txt" -- 検索対象の拡張子を指定
  filePaths <- findFiles path extension
  mapM_ putStrLn filePaths