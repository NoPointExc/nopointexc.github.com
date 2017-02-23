#!/bin/bash
#TODO: handle wrong data format

#TODAY string in 'yyyy-mm-dd'
TODAY=$(date +%F)
path=/home/joey/nopointexc.github.com/_posts
USAGE="post.sh: missing post name \nTry 'post.sh [-d DATA_STRING] TITLE'\n"
title='new-post'
data=$TODAY

case $# in
1)  title=$1;; 
3)  title=$1; #replace space with '-'
    if test $2 = "-d"; then
	date=$(date --date=$3 +%F)		
    fi;;
*) echo -e $USAGE; exit 0;;    
esac

#create .md file '-'
file_name=$data'-'$(echo $title|sed 's/ /-/g')'.md'
file_pth=$path'/'$file_name 
touch $file_pth

#add meta-date in head.
echo '---' >> $file_pth
echo 'layout: post' >> $file_pth
echo 'title: '$title >> $file_pth
echo 'description:""' >> $file_pth
echo 'category: ' >> $file_pth
echo 'tags: []' >> $file_pth
echo '---' >> $file_pth
echo '{% include JB/setup %}' >> $file_pth

#open with vim
vim $file_pth
