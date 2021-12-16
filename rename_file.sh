#!/bin/bash

#PROGRAM DESCRIPTION:
#Rename a given file to a new name. If new name already exists, append an int
#to the new name starting from 1.

#VARIABLES
OLDFILE=$1	#arg1 is old filename
NEWFILE=$2	#arg2 is new filename
i=1		#integer i = 1

#Check if OLDFILE exists, if not abort
if [ ! -e $OLDFILE ]; then
	echo "Error. Source file does not exist."
	exit 1
fi

#If NEWFILE does not yet exist, rename OLDFILE to NEWFILE
#Else, append an int value on NEWFILE starting from 1 and incrementing until
#it is a file that does not yet exist
if [ ! -e $NEWFILE ]; then
	mv $OLDFILE $NEWFILE
else
	while [ -e $NEWFILE.$i ]; do
		((i++))
	done
	NEWFILE=$NEWFILE.$i
        mv $OLDFILE $NEWFILE
fi

#exit program
exit 0
