#!/bin/sh

# instruction -> ./<script-file.sh> <image-file-name> <how-long-to-wait-for-each-image-download>
# example     -> ./download-images-structwise.sh missing_images.txt 5s

pwd=''
green=$(tput setaf 2)
reset=$(tput sgr0)

while read line; do
  echo "${green}downloading: ${reset}" $line
  path="$(echo $line | grep / | cut -d/ -f4-)"
  if [ ! -d $path ]; then
    dirpath="$(dirname $path)"
    mkdir -p $dirpath
    cd $dirpath && timeout $2 wget -q --show-progress $line
    cd -
  fi
done <$1
