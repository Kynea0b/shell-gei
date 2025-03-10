#!/bin/bash

# answersディレクトリ内のq<番号>ディレクトリを検索
for dir in answers/q*; do
  # ディレクトリ名から番号を抽出
  number="${dir#answers/q}"

  # Haskellファイルをコンパイル
  ghc "$dir/q$number.hs"

  # コンパイルが成功したか確認
  if [ $? -eq 0 ]; then
    echo "コンパイル成功: $dir/q$number.hs"
  else
    echo "コンパイル失敗: $dir/q$number.hs"
  fi
done

exit 0