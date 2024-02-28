#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "ERROR - No target directory or destination_directory provided"
  echo "usage: backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "An invalid directory path has been provided"
  exit
fi

# [TASK 1]
targetDirectory=$1
destinationDirectory=$2

# [TASK 2]
echo "Target directory = $targetDirectory"
echo "Destination directory = $destinationDirectory"

# [TASK 3]
currentTS=`date +%s`

# [TASK 4]
backupFileName="backup-$currentTS.tar.gz"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=`pwd`

# [TASK 6]
cd $destinationDirectory # <- move into the destination directory
destDirAbsPath=`pwd`

# [TASK 7]
cd $origAbsPath # <- move to original working directory
cd $targetDirectory # <- then move to target directory

# [TASK 8]
# Declare constant for number of seconds in 24 hours (84600)
#declare -r seconds_in_24Hours=$((24 * 60 * 60))
#yesterdayTS=$(($currentTS - $seconds_in_24Hours))
# or you could use yesterday keyword and get the seconds
yesterdayTS=$(date -d "yesterday" +%s)

# Declare new array and loop through all files
#  and add those modified in the last 24 hours
declare -a toBackup

for file in $(ls) # [TASK 9]
do
  # [TASK 10]
  if ((`date -r $file +%s` > $yesterdayTS))
  then
    # [TASK 11]
    toBackup+=($file)
  fi
done

# [TASK 12]
# Compress and archive all files in the array (toBackup)
tar -czvf $backupFileName ${toBackup[@]}

# [TASK 13]
# Move the newly created backup compressed archive to Destination directory
mv $backupFileName $destDirAbsPath

# Congratulations! You completed the final project for this course!