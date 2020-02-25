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

echo -e "MPG \t Total Cost \t Stops \t Gas Left"

if [ ! -f $1 ]; then
  echo $1 "file does not exist"
else
  while read line
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
        #echo -e $mpg "\t" $totalCost "\t" $stopCount
        echo -e $mpg "\t" $totalCost "\t\t" $stopCount "\t" $gallonsLeft
      fi
      #mpg=`echo $line | awk {'print $1'}`
      #tank_distance=$((mpg*18))
      #number_of_stops=$((total_distance/tank_distance))
   done < $1
fi


#STEP TWO: read first value

#THREE:
