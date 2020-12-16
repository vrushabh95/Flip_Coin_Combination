#!/bin/bash -x

echo "Welcome To Flip Coin Combination"

declare -A singlet
singlet=( ["H"]=0 ["T"]=0 )

declare -A doublet
doublet=( ["HH"]=0 ["TT"]=0 ["HT"]=0 ["TH"]=0 )

declare -A triplet
triplet=( ["HHH"]=0 ["TTT"]=0 ["HHT"]=0 ["TTH"]=0 ["HTH"]=0 ["THT"]=0 ["THH"]=0 ["HTT"]=0 )

timesFlip=0
choice=0

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
	noFlip=$2
	percent=$(( temp * 100 / noFlip ))
	echo "$percent%"
}

function maxOneFlip() {
	for combination in "${!singlet[@]}"
	do
		if [[ $maxCount -lt ${singlet[$combination]} ]]
		then
			maxCount=${singlet[$combination]}
			maxCombination=$combination
		fi
	done
	echo "Winning Combination is $maxCombination with $maxCount"
}

function oneFlip() {
	noFlip=$1
	singletHeadCount=0
	singletTailCount=0
	for (( i=0; i<$noFlip; i++ ))
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

	echo Head percent: $( percentage $singletHeadCount $noFlip ), Tail percent: $( percentage $singletTailCount $noFlip )
}

function maxTwoFlip() {
	for combination in "${!doublet[@]}"
	do
		if [[ $maxCount -lt ${doublet[$combination]} ]]
		then
			maxCount=${doublet[$combination]}
			maxCombination=$combination
		fi
	done

	echo "Winning combination is $maxCombination with $maxCount"
}

function twoFlip() {
	noFlip=$1
	doubleHeadCount=0
	doubleTailCount=0
	headThenTailCount=0
	tailThenHeadCount=0
	for (( j=0; j<$noFlip; j++ ))
	do
		result1=$( flipCoin )
		result2=$( flipCoin )
		result=$result1$result2
		if [ $result == HH ]
		then
			(( doubleHeadCount++ ))
			doublet[HH]=$doubleHeadCount
		elif [ $result == TT ]
		then
			(( doubleTailCount++ ))
			doublet[TT]=$doubleTailCount
		elif [ $result == HT ]
		then
			(( headThenTailCount++ ))
			doublet[HT]=$headThenTailCount
		else
			(( tailThenHeadCount++ ))
			doublet[TH]=$tailThenHeadCount
		fi
	done

	echo HH percent: $( percentage $doubleHeadCount $noFlip ), TT percent: $( percentage $doubleTailCount $noFlip ), HT percent: $( percentage $headThenTailCount $noFlip ), TH percent: $( percentage $tailThenHeadCount $noFlip ) 
}

function maxThreeFlip() {
	for combination in "${!triplet[@]}"
	do
		if [[ $maxCount -lt ${triplet[$combination]} ]]
		then
			maxCount=${triplet[$combination]}
			maxCombination=$combination
		fi
	done

	echo "Winning combination is $maxCombination with $maxCount"
}

function threeFlip() {
	noFlip=$1
	tripleHeadCount=0
	tripleTailCount=0
	headHeadTail=0
	tailTailHead=0
	headTailHead=0
	tailHeadTail=0
	tailHeadHead=0
	headTailTail=0
	for (( k=0; k<$noFlip; k++ ))
	do
		result1=$( flipCoin )
		result2=$( flipCoin )
		result3=$( flipCoin )
		result=$result1$result2$result3
		if [ $result == HHH ]
		then
			(( tripleHeadCount++ ))
			triplet[HHH]=$tripleHeadCount
		elif [ $result == TTT ]
		then
			(( tripleTailCount++ ))
			triplet[TTT]=$tripleTailCount
		elif [ $result == HHT ]
		then
			(( headHeadTail++ ))
			triplet[HHT]=$headHeadTail
		elif [ $result == TTH ]
		then
			(( tailTailHead++ ))
			triplet[TTH]=$tailTailHead
		elif [ $result == HTH ]
		then
			(( headTailHead++ ))
			triplet[HTH]=$headTailHead
		elif [ $result == THT ]
		then
			(( tailHeadTail++ ))
			triplet[THT]=$tailHeadTail
		elif [ $result == THH ]
		then
			(( tailHeadHead++ ))
			triplet[THH]=$tailHeadHead
		else
			(( headTailTail++ ))
			triplet[HTT]=$headTailTail
		fi
	done

	echo HHH percent: $( percentage $tripleHeadCount $noFlip ), TTT percent: $( percentage $tripleTailCount $noFlip ), HHT percent: $( percentage $headHeadTail $noFlip ), TTH percent: $( percentage $tailTailHead $noFlip ), HTH percent: $( percentage $headTailHead $noFlip ), THT percent: $( percentage $tailHeadTail $noFlip ) , THH percent: $( percentage $tailHeadHead $noFlip ), HTT percent: $( percentage $headTailTail $noFlip )
}
function main() {
	echo "----------Flip Coin Simulation----------"
	echo -e "Enter 1 to flip one coin \nEnter 2 to flip two coin \nEnter 3 to flip three coin"
	read -p "Enter your choice: " choice
	read -p "How many times you want to flip the coin: " timesFlip

	case $choice in
		1)
			oneFlip $timesFlip
			maxOneFlip;;
		2)
			twoFlip $timesFlip
			maxTwoFlip;;
		3)
			threeFlip $timesFlip
			maxThreeFlip;;
		*)
			echo Invalid choice;;
	esac
}

main
