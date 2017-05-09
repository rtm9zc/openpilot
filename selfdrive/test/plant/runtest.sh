#!/bin/bash

testType=$1
testParam=$2

pushd ../../controls
if [ "$testType" = "brake" ]; then
	echo BRAKE TEST, BRAKE CAPABILITY REDUCED BY FACTOR OF $testParam
	./controlsd.py $testParam &
else
	./controlsd.py &
fi
pid1=$!

if [ "$testType" = "vision" ]; then
	echo VISION TEST, RADAR REDUCED BY FACTOR OF $testParam
	./radard.py $testParam &
else
	./radard.py &
fi

pid2=$!
trap "trap - SIGTERM && kill $pid1 && kill $pid2" SIGINT SIGTERM EXIT
popd
mkdir -p out
if [ "$testType" = "" ]; then
	MPLBACKEND=svg ./runtracks.py out
else
	MPLBACKEND=svg ./runtracks.py out $testType
fi