#! /bin/bash

# source set_env.sh

hhelp='
usage: p_msg.sh "<str>"\n\n
e.g.\n
input:\n
\tp_msg.sh "hello world!"\n
output:\n
\t==================\n
\t== hello world! ==\n
\t==================\n
\tFri Nov  1 00:33:34 CST 2024\n
'
if [ -z "$1" ]; then
	echo "ERR: none input"
	echo -n -e $hhelp
	exit 1
else
	if [ "$1" == "--help" -o "$1" == "-h" ]; then
		echo $hhelp
		exit 0
	fi
	msg="== $1 =="
	co=$(($(echo $msg | wc -m)-1))
	prt0=$(printf "%-${co}s" "=")
	hitt=${prt0// /=}
	echo -e "${hitt}\n${msg}\n${hitt}\n$(date)\n"
fi
