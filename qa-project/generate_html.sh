#!/bin/bash

# 質問と回答のペアを定義
questions=(
  "質問1: 〇〇とは？"
  "質問2: △△の仕組みは？"
  "質問3: □□の利点は？"
)

# HTML生成
echo "<ul>" > index.html
for i in "${!questions[@]}"; do
  question="${questions[$i]}"
  answer_dir="answers/question$((i+1))"
  answer_link="<a href=\"$answer_dir/\">$answer_dir</a>"
  echo "  <li>$question $answer_link</li>" >> index.html
done
echo "</ul>" >> index.html

echo "HTMLを生成しました: index.html"