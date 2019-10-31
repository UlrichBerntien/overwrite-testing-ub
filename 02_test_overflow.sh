#!/usr/bin/env bash

echo '[.] Generate very long argument'
FLONG="x"
for i in $(seq 10); do
    FLONG=$FLONG$FLONG
done
echo $FLONG

./load_overwrite.sh
echo '[.] run overwrite program with long argument'
./overwrite -dirs:1 -path:$FLONG
