#!/bin/bash

################################################################################
#                                                                              #
# This script can be used to rename files created by TempestSDR from the       #
# default name to a numbered image name set.                                   #
#                                                                              #
################################################################################


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
