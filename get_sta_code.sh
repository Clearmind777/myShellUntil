#! /bin/bash

#set -x -e

declare -a ary
declare -a name
aall=0
i=0
hhelp="
usage: get_sta_code.sh [option] [argv...]\n
[option]\n
--help\t\tshow this message\n
--all\t\tprint both the filename and exist-code\n
\n[argv...]\n
path of files\n\n
e.g. get_sta_code.sh --all ./a.sam ./a_sorted.bam
"



if [ -z $1 ]; then 
	echo "ERR: none input"
	echo -e $hhelp
	exit 1
fi

:<<COMMIT
if [ "$1" == "-*" ]; then
	echo "ERR: unknown options '$1'"
	echo -e $hhelp
	exit 1
fi
COMMIT
if [ "$1" == "--help" -o "$1" == "--all" ]; then
	while true; do
		case $1 in
			"--help")
				echo -e $hhelp
				exit 0
			;;
			"--all")
				aall=1
			;;
			*)
				break
			;;
		esac
		shift
	done
fi

while [ ! -z $1 ]; do
	test -e $1
	ary[$i]=$?
	name[$i]=$1
	# echo ary[$i] 
	i=$((i+1))
	shift
done


case $aall in
	0)
		echo "${ary[@]}" | sed "s/ /\t/g"
	;;
	1) 
		echo "${name[@]}" | sed "s/ /\t/g"
		echo "${ary[@]}" | sed "s/ /\t/g"
	;;
esac
