#!/bin/sh
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
