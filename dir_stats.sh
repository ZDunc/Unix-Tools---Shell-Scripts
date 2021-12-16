#PROGRAM DESCRIPTION -- Traverse through a directory, calculate and print
#relevant directory statistics: number of subdirectories, number of files,
#number of readable files, number of writable files, number of executables

#FIRST, check to see if 1 argument has been passed in, if not abort
if [ $# -ne 1 ]            #If num of passed argument does not equal 1
then
echo "Usage: $0 <directory_name>"
exit 0
fi

dirName=$1
files=`ls $dirName`

#THEN, check if file exists, if not abort
if [ ! -d $dirName ]
then
echo "$dirName: No such directory"
exit 0
fi

#Variable Initialization
isReadable=0
isWritable=0
isExecutable=0
regFiles=0
numDirectories=0

#For loop, goes through each directory file
for f in $files
do

#TASK 1 - Count total num of directories in given directory
        #-d means True if ‘file’ is a directory

if [ -d $dirName/$f ]
then
numDirectories=`expr $numDirectories + 1`

#TASK 2 - Count total num of files in given passed directory
        #elif means else if; -f means True if ‘file’ is an ord. file

elif [ -f $dirName/$f ]
then
regFiles=`expr $regFiles + 1`
fi      #fi means end of if block

#TASK 3 - Num of readable items in passed directory
        #Use -r for readable

if [ -r $dirName/$f ]
then
isReadable=`expr $isReadable + 1`
fi

#TASK 4 - Num of writable items in passed directory
        #Use -w for writable

if [ -w $dirName/$f ]
then
isWritable=`expr $isWritable + 1`
fi

#TASK 5 - Num of executable items in passed directory
        #Use -x for executable

if [ -x $dirName/$f ]
then
isExecutable=`expr $isExecutable + 1`
fi

done    #End of for loop

#PRINT RESULTS
echo "
   Statistics on the directory $dirName
"
echo "Number of Directories: $numDirectories"
echo "Number of Files: $regFiles"
echo "Number of Readable Files: $isReadable"
echo "Number of Writable Files: $isWritable"
echo "Number of Executable Files: $isExecutable"

#EXIT PROGRAM
exit 0
