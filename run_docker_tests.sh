#!/bin/bash
set -e

docker build -t tmppilot -f Dockerfile.openpilot .

if [ "$#" -eq 2 ]; then
	docker run --rm \
  -v "$(pwd)"/selfdrive/test/plant/out:/tmp/openpilot/selfdrive/test/plant/out \
tmppilot /bin/sh -c 'cd /tmp/openpilot/selfdrive/test/plant && ./runtest.sh '$1' '$2
elif [ "$#" -eq 4 ]; then
	docker run --rm \
  -v "$(pwd)"/selfdrive/test/plant/out:/tmp/openpilot/selfdrive/test/plant/out \
tmppilot /bin/sh -c 'cd /tmp/openpilot/selfdrive/test/plant && ./runtest.sh '$1' '$2' '$3' '$4
elif [ "$#" -eq 6 ]; then
	docker run --rm \
  -v "$(pwd)"/selfdrive/test/plant/out:/tmp/openpilot/selfdrive/test/plant/out \
tmppilot /bin/sh -c 'cd /tmp/openpilot/selfdrive/test/plant && ./runtest.sh '$1' '$2' '$3' '$4' '$5' '$6
else
	docker run --rm \
  -v "$(pwd)"/selfdrive/test/plant/out:/tmp/openpilot/selfdrive/test/plant/out \
tmppilot /bin/sh -c 'cd /tmp/openpilot/selfdrive/test/plant && ./runtest.sh'

fi