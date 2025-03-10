#!/bin/bash

# GitHubリポジトリのURL
github_repo="https://github.com/Kynea0b/shell-gei/tree/main/qa-project/answers"

# 質問と回答の定義ファイルを読み込む
while IFS=',' read -r question answer_dir; do
  questions+=("$question")
  answer_dirs+=("$answer_dir")
done < questions.txt

# HTML生成
echo "<ul>" > index.html
for i in "${!questions[@]}"; do
  question="${questions[$i]}"
  answer_dir="${answer_dirs[$i]}"
  answer_link="<a href=\"$github_repo/$answer_dir\">$answer_dir</a>"
  echo "  <li>$question $answer_link</li>" >> index.html
done
echo "</ul>" >> index.html

echo "HTMLを生成しました: index.html"