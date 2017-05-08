#!/bin/bash
set -e

docker build -t tmppilot -f Dockerfile.openpilot .

testType=$1
testParam=$2

cmd=''

if [ "$#" -ne 2 ]; then
	docker run --rm \
  -v "$(pwd)"/selfdrive/test/plant/out:/tmp/openpilot/selfdrive/test/plant/out \
tmppilot /bin/sh -c 'cd /tmp/openpilot/selfdrive/test/plant && ./runtest.sh'
else
	docker run --rm \
  -v "$(pwd)"/selfdrive/test/plant/out:/tmp/openpilot/selfdrive/test/plant/out \
tmppilot /bin/sh -c 'cd /tmp/openpilot/selfdrive/test/plant && ./runtest.sh '$testType' '$testParam

fi