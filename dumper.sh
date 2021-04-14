#!/bin/bash

dos2unix $0 $1 > /dev/null 2>&1
curdir=$(pwd)
for url in $(cat $1 | cut -d'/' -f1,2,3); do
target=$(echo -n "$url/.git/")
output=$(echo -n "$target" | cut -d'/' -f3-)
./GoGitDumper/GoGitDumper -f -t 50 -u "$target" -o "src/$output"
dir=$(echo -n "$output" | cut -d'/' -f1,2)
cd src/${dir}; git checkout . && git log -p > commits.dump; cd $curdir
done
