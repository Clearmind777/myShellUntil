#! /bin/bash

sep="."
sep_num=1
suf_unit="*."
suf=$suf_unit
p_sta=0
all=0

function pattern_suf(){
	suf_unit="*${sep}"
	local suf_tmp=""
	for i in `seq 1 ${sep_num}`;do
		suf_tmp=${suf_tmp}${suf_unit}
	done
	suf=$suf_tmp
}

hhelp="
usage: split.sh [option] [argvs]\n
[option]\n
-h --help\tshow this help\n
--all\t\treturn path, name, and suffix\n
-d\t\tpath of a file\n
e.g.\n
input:\n
\tsplit.sh --all -d tfl/a.sam -d tfl/b.tar.gz\n
output:\n
\t/my_shell_until/tfl/\ta\t.sam\n
\t/my_shell_until/tfl/\tb\t.tar.gz\n
"

#-s\t\t<str>\t\tset the separator\n
#-sn\t\t<int>\t\tset the numbers of separator (abandoned)\n
#-p\t\t<str>\t\tset a specific suffix, then '-d' will return a name (e.g. '.txt', and must contain the '.')\n\n


if [ -z $1 ]; then 
	echo "ERR: none input"
	echo -e $hhelp
	exit 1
fi

while [ ! -z $1 ]; do
	case $1 in
		"-d")
			shift
			if [ -f $1 ];then
				file=$(realpath $1)
#				if [[ ! $1 =~ ^/ ]]; then
#					file=$(realpath $1)
#				if [[ $1 =~ ^([.]{1,2}/)+ ]]; then 
#					tmpf=$1
#					tmp="*$(echo $1 | grep -w -P -o '^[(./)|(../)]+')"
#					file=$(echo ${tmpf#$tmp} | cut -c2-)
#				else
#					file=$1
#				fi
				if [ $all == 0 ];then
					case $p_sta in
						0)
							echo ".${file#$suf}";;
						1)
							basename $file $suf;;
					esac
				else
					ssuf=".${file#$suf}"
					nname=$(basename $file $ssuf)
					path=$(echo $file | cut -c1-$(($(echo $file | wc -m)-$(echo $(basename $file | wc -m)))))
					echo -e "$path\t${nname}\t${ssuf}"
				fi
			else 
				continue
			fi
			p_sta=0;;
		"--all")
			all=1;;
		"-s")
			shift
			sep=$1
			# echo "set separator to ${sep}"
			pattern_suf
			p_sta=0
			;;
		"-p")
			shift
			suf=$1
			p_sta=1
			;;
		"-sn")
			shift
			echo "this option has been abadoned."
			continue
			# test if the value is a number 
			# method 1
			# if echo $1 | [ -n "`sed -n '/^[0-9][0-9]*$/p'`" ]; then
			# method 2
			if grep '^[[:digit:]]*$' <<< "$1" > /dev/null ;then
				# echo "pass 1"
				if [ $1 -ne $sep_num -a $1 -gt 0 ];then
					sep_num=$1
					pattern_suf
				fi
			fi
			;;
		"-h" | "--help")
			echo -e $hhelp
			exit 0
			;;
		*)
			echo -e "ERR: unknown option\n"
			echo -e $hhelp
			exit 1
			;;
	esac
	shift
done
