#!/bin/bash
SUM=0

for run in {1..10}
do
  SUM=$(( $SUM + $RANDOM ))
done
echo "The sum is: " $SUM
echo "The average is: " $(( $SUM / 10 ))
