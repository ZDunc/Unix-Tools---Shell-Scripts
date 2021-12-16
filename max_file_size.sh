#!/bin/bash
#Zach Duncan
#COP 4342
#Assignment 2
#DUE 9/24/2020

#PROGRAM DESCRIPTION:
#This program determines the maximum size of all files under a given directory
#Enter the directory as the command-line argument to the shell program.
#If subdirectories exist, the program will extend to all subdirectories to
#determine the maximum size of all files.

#Check for correct argument usage
if [ $# -ne 1 ]; then
	echo "Usage: maxfile.sh directory"
	exit 1
fi

#Check if directory exists in current dir, or if current dir, if not abort
dir=${PWD##*/}
if [ ! -d $1 ] && [ "$dir" != "$1" ]; then
    echo "Error. Directory does not exist."
    exit 2
fi

#Change directory to given command line arg if applicable
if [ -d "$1" ]; then
	cd $1
fi

#Initialize FileSize and temp variables to 0, RelativeDir to empty string
declare -i FileSize ; FileSize=0
declare -i temp ; temp=0
RelativePath=""

function FindLargest() {
			#Iterate through all (including hidden) files in dir
for file in * .*
do
			#If referring to current or prev directory, continue
	if [ "$file" = "." ] || [ "$file" = ".." ]; then
		continue
			#If file is a symbolic link
	elif [ -h "$file" ]; then
		file="$(readlink -f "$file")"
			#If file is not a directory
	elif [ ! -d "$file" ]; then
			#Temp = file size of current file in iteration
		temp="$(ls -al "$file" | awk '{print $5}')"
			#If temp > FileSize, update variables which hold maximum
		if [ "$temp" -gt "$FileSize" ]; then
			FileSize="$(ls -al "$file" | awk '{print $5}')"
			FileName="$(ls -al "$file"| awk '{print $9}')"
			RelativePath="${PWD##*/}/"
		fi
	else
			 #File is a directory, need to recursively call func
		#echo "Recursively traveling through directory $file"
		cd "$file"
		FindLargest "$file"
		cd ..
	fi
done
}

FindLargest				  #Call function
echo "$RelativePath$FileName: $FileSize"	  #Print largest file to screen

exit 0	#End of script, exit
