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

echo Head percent: $( percentage $singletHeadCount ), Tail percent: $( percentage $singletTailCount )
}

function twoFlip() {
	declare -A doublet
	doublet=( ["HH"]=0 ["TT"]=0 ["HT"]=0 ["TH"]=0 )

	doubleHeadCount=0
	doubleTailCount=0
	headThenTailCount=0
	tailThenHeadCount=0
	for (( j=0; j<10; j++ ))
	do
		result1=$( flipCoin )
		result2=$( flipCoin )
		if [ $result1$result2 == HH ]
		then
			(( doubleHeadCount++ ))
			doublet[HH]=$doubleHeadCount
		elif [ $result1$result2 == TT ]
		then
			(( doubleTailCount++ ))
			doublet[TT]=$doubleTailCount
		elif [ $result1$result2 == HT ]
		then
			(( headThenTailCount++ ))
			doublet[HT]=$headThenTailCount
		else
			(( tailThenHeadCount++ ))
			doublet[TH]=$tailThenHeadCount
		fi
	done

echo HH percent: $( percentage $doubleHeadCount ), TT percent: $( percentage $doubleTailCount ), HT percent: $( percentage $headThenTailCount ), TH percent: $( percentage $tailThenHeadCount ) 
}

echo "----------Flip Coin Simulation----------"
echo -e "Enter 1 to flip one coin \nEnter 2 to flip two coin"
read -p "Enter choice: " choice

case $choice in
	1)
		oneFlip;;
	2)
		twoFlip;;
	*)
		echo "Invalid choice!!";;
esac 
