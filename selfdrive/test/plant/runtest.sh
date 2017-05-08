#!/bin/bash

testType=$1
testParam=$2

pushd ../../controls
./controlsd.py &
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
MPLBACKEND=svg ./runtracks.py out
