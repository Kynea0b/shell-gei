#!/bin/bash
ext=$1
search_file="*."${ext}
# echo "target file is "${search_file}
find ./ -name ${search_file}