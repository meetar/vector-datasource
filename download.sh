#!/bin/sh
#

cat filelist.txt | while read line; do 
	cd data
    echo $line # or whatever you want to do with the $line variable
    curl -O $line
    filename=${line##*/}
    unzip -j -n $filename
    base=${filename%.*}
    echo $base
    cd ..
done
