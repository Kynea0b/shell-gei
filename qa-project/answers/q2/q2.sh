#!/bin/bash

# For BSD 
# IF GNU, use realpath
# 引数の個数をチェック
if [ $# -ne 1 ]; then
  echo "エラー：引数の個数が正しくありません。2つの引数を指定してください。"
  exit 1
fi
find $(realpath $(dirname $0))/../data -type f -print | xargs fgrep -n $1