#! /bin/bash

trap 'echo "Press Ctrl+C"; continue' SIGINT
for i in {1..10}; do
	echo "Running step $i"
	sleep 3
done
echo "Script finished"
