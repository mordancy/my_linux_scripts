#!/usr/bin/bash

#here are some variations on using/incrementing counters in your shell scripts

x=0
for i in {1..5}
do
let x=$x+1
echo "x = $x"
done

echo ""


y=0
for i in {1..5}
do
let "y++"
echo "y = $y"
done

echo ""

z=0
for i in {1..5}
do
z=$((z+1))
echo "z = $z"
done

echo ""

a=0
for i in {1..5}
do
(( a++ ))
echo "a = $a"
done
