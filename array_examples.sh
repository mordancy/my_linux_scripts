#!/usr/bin/bash


SERVERARRAYDEV=(devapp01 devapp02 devdb01 devdb02)
SERVERARRAYSTAGE=(devapp01 devapp02 devdb01 devdb02)
SERVERARRAYPROD=(devapp01 devapp02 devdb01 devdb02)


SERVERARRAY="${SERVERARRAYDEV[@]}"
echo "Looping through SERVERARRAY <${SERVERARRAY[@]}>"
echo "should equal SERVERARRAYDEV <${SERVERARRAYDEV[@]}>"

for SERVER in ${SERVERARRAY[*]}
do
    echo "        server <${SERVER}>"
done


echo " "
echo " "


SERVERARRAY="${SERVERARRAYSTAGE[@]}"
echo "Looping through SERVERARRAY <${SERVERARRAY[@]}>"
echo "should equal SERVERARRAYSTAGE <${SERVERARRAYSTAGE[@]}>"

for SERVER in ${SERVERARRAY[*]}
do
    echo "        server <${SERVER}>"
done


echo " "
echo " "


SERVERARRAY="${SERVERARRAYPROD[@]}"
echo "Looping through SERVERARRAY <${SERVERARRAY[@]}>"
echo "should equal SERVERARRAYPROD <${SERVERARRAYPROD[@]}>"

for SERVER in ${SERVERARRAY[*]}
do
    echo "        server <${SERVER}>"
done



echo " "
echo " "


echo " "
echo "Concatenate all array lists into one list and iterate through new array list"
echo " "

SERVERARRAY=( ${SERVERARRAYDEV[@]]} ${SERVERARRAYSTAGE[@]} ${SERVERARRAYPROD[@]]} )
echo "Looping through SERVERARRAY <${SERVERARRAY[@]}>"
echo "should equal SERVERARRAYDEV <${SERVERARRAYDEV[@]}>"

for SERVER in ${SERVERARRAY[*]}
do
    echo "        server <${SERVER}>"
done
