#!/bin/bash

#total distance: 1,000 miles
#tank capacity: 18 gallons
#cost per gallon: $3.40
#data set: 18, 21, 24, 27, 32,36
#input file = list of fuel efficenies
#output file = chart including MPG, total trip cost, number of stops, and gas left in tank.

#equations
#number of stops = trip distance / miles per tank
#miles per tank = tank capacity * MPG
#cost of trip = number of stops * tank capacity * cost of gas
#gas left = number of stops * tank ca

#CONSTANTS
totalDistance=1000
tankCapacity=18
galGasCost="340"
fillCost=`expr galGasCost*tankCapacity`

 #first check if exactly one argument is given
if [ "$#" -ne 1 ]; then #preferrably I'd loop thru each given arg. But I'm lazy.
  echo $1 "please specify a file"
elif [ ! -f $1 ]; then #check if argument is file. should work as full path or pwd.
  echo $1 "does not exist"
else
  echo -e "MPG \t Total Cost \t Stops \t Gas Left"
  while read line #there is no reason to detect EOF. this is more efficent.
  do
      mpg=`echo $line | awk {'print $1'} | grep -o [[:digit:]]*`
      if [ ! -z $mpg ]; then
        tankDistance=$(($mpg*$tankCapacity))
        stopCount=$(($totalDistance/$tankDistance))
        totalGallons=$(($stopCount*$tankCapacity))
        totalCost=$(($totalGallons*$galGasCost/100))
        distanceCapacity=$((($stopCount+1)*$tankDistance))
        distanceLeft=$(($distanceCapacity-$totalDistance))
        gallonsLeft=$(($distanceLeft/$mpg))
        #i could have consolidated previous variables, but I prefer this approach
        #in case the program is re-purposed, it gives more re-usability.
        echo -e $mpg "\t" $totalCost "\t\t" $stopCount "\t" $gallonsLeft
        #csv or ncurses would be a better way to output data, but again, i'm lazy.
      fi
   done < $1
fi
