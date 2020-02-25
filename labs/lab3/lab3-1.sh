#!/bin/bash
#read any file line-by-line, trim out numbers, output square of all numbers in files.
#discount any words with numbers and letters in them.

echo -e "X" ' \t' "Y">>lab3-1-outputfile

echo $1

while read -ra line
do
    for word in "${line[@]}"
    do
      check=`echo "$word" | grep -E ^\-?[0-9]*\.?[0-9]+$`
      if [ ${#check} -gt 0 ]; then
        echo -e $check ' \t' $((check * check))>>lab3-1-outputfile
      fi
    done
done < &1
