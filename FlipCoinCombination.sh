#!/bin/bash -x

echo "Welcome To Flip Coin Combination"

function flipCoin() {
	face=$(( RANDOM % 2 ))
	if [ $face -eq 1 ]
	then
		echo "H"
	else
		echo "T"
	fi
}

function percentage() {
	temp=$1
	percent=$(( temp * 100 / 10 ))
	echo "$percent%"
}

function oneFlip() {
	declare -A singlet
	singlet=( ["H"]=0 ["T"]=0 )
	
	singletHeadCount=0
	singletTailCount=0
	for (( i=0; i<10; i++ ))
	do
		result=$( flipCoin )
		if [ $result == H ]
		then
			(( singletHeadCount++ ))
			singlet[H]=$singletHeadCount
		else
			(( singletTailCount++ ))
			singlet[T]=$singletTailCount
		fi
	done

echo The Percentage of Head in singlet combination is $( percentage $singletHeadCount )
echo The Percentage of Tail in singlet combination is $( percentage $singletTailCount )
}

oneFlip


