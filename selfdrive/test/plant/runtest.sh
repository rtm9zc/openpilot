#!/bin/bash

accelTest=0
accelParam="1.0"
brakeTest=0
brakeParam="1.0"
visionTest=0
visionParam="1.0"


i=0
nArgs=$#

echo $1 $2 $nArgs


foundTest=0
lastTest=""

for arg in "$@"
do
	if [[ $foundTest -eq 0 ]]; then
		foundTest=1
		if [[ "$arg" = "brake" ]]; then
			brakeTest=1
			lastTest="brake"
		elif [[ "$arg" = "accel" ]]; then
			accelTest=1
			lastTest="accel"
		elif [[ "$arg" = "vision" ]]; then
			visionTest=1
			lastTest="vision"
		fi
	else
		foundTest=0
		if [[ "$lastTest" = "brake" ]]; then
			brakeParam=$arg
		elif [[ "$lastTest" = "accel" ]]; then
			accelParam=$arg
		elif [[ "$lastTest" = "vision" ]]; then
			visionParam=$arg
		fi
		lastTest=""
	fi
done

pushd ../../controls
if [[ $brakeTest -eq 1 ]]; then
	echo BRAKE TEST, BRAKE CAPABILITY REDUCED BY FACTOR OF $brakeParam
	./controlsd.py $brakeParam &
else
	./controlsd.py &
fi
pid1=$!

if [[ $visionTest -eq 1 ]]; then
	echo VISION TEST, RADAR REDUCED BY FACTOR OF $visionParam
	./radard.py $visionParam &
else
	./radard.py &
fi

pid2=$!
trap "trap - SIGTERM && kill $pid1 && kill $pid2" SIGINT SIGTERM EXIT
popd
mkdir -p out
if [[ "$accelTest" -eq 1 ]]; then
	echo ACCEL TEST, ACCEL MAGNITUDE REDUCED BY FACTOR OF $accelParam
	MPLBACKEND=svg ./runtracks.py out $accelParam
else
	MPLBACKEND=svg ./runtracks.py out 1.0 $visionParam $brakeParam
fi