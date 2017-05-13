#!/bin/bash

i=0
j=0

echo $1

for (( i=1; i<=20; i++ ))
do
	for (( j=1; j<=20; j++ )); 
	do
		./run_docker_tests.sh brake $( echo "${i}*(1/20.0)" | bc -l ) vision $( echo "${j}*(1/20.0)" | bc -l )
	done
done