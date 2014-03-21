#!/usr/bin/bash

#remove the zip file before running
#rm -f renamed_files.zip

filelist=()

#echo LIST BEFORE RENAME
#  ls -al

#get the files that have a colon in the name
for i in $(\ls -Art *:*)
do

#display the file name
  echo $i
#create the new file name
  j=$(echo -n $i | tr -d ':')

#don't rename the file if it already exists  
  if [[ ! -e $j ]]; then
  
#add file to an arraylist to use later
    filelist+=("${j}")
    
    echo "renaming file <$i> to <$j>"
    mv $i $j
    
  else
    echo "file #{$j} exists"
  fi

done
#echo LIST AFTER RENAME
#  ls -al

#display the list of files that were renamed
echo "FILE LIST = ${filelist[*]}"

#zip up files
#zip -9v renamed_files.zip ${filelist[*]}
