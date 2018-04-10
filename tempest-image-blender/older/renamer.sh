#!/bin/bash

NUMFILES=$( ls -l images/TSDR* | wc -l )

FILES=$( ls -l images/TSDR*.png | awk '{print $9}' )

echo "Number of files: ${NUMFILES}"

echo "Renaming..."

i=1
for f in ${FILES}
do
	#echo "${f}"
	#echo "${i}"
	mv ${f} images/${i}.png
	i=$(( i + 1 ))
done

echo "Done"
