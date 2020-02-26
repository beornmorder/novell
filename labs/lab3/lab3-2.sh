#!/bin/bash

#INPUT: any data file containing numbers
#OUTPUT: stdout, can also be re-directed to file.

#CONSTANTS
totalDistance=1000
tankCapacity=18
galGasCost="3.40"

 #first check if exactly one argument is given
if [ "$#" -ne 1 ]; then #preferrably I'd loop thru each given arg. But I'm lazy.
  echo $1 "please specify a file"
elif [ ! -f $1 ]; then #check if argument is file. should work as full path or pwd.
  echo $1 "does not exist"
else
  echo -e "MPG \t Total_Cost \t Stops \t Gas_Left"
  while read line #there is no reason to detect EOF. this is more efficent.
  do
      mpg=`echo $line | awk {'print $1'} | grep -o [[:digit:]]*`
      if [ ! -z $mpg ]; then
        tankDistance=$(($mpg*$tankCapacity))
        stopCount=$(($totalDistance/$tankDistance+1)) #added 1 to represent starting with empty tank.
        totalGallons=$(($stopCount*$tankCapacity))
        totalCost=$(bc <<< "scale=2;$totalGallons*$galGasCost")
        distanceCapacity=$((($stopCount)*$tankDistance))
        distanceLeft=$(($distanceCapacity-$totalDistance))
        gallonsLeft=$(($distanceLeft/$mpg))
        #i could have consolidated previous variables, but I prefer this approach
        #in case the program is re-purposed, it gives more re-usability.
        echo -e $mpg "\t" $totalCost "\t" $stopCount "\t" $gallonsLeft
      fi
   done < $1
fi
