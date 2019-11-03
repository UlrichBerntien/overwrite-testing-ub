#!/usr/bin/env bash

if [[ ! -x ./overwrite ]]; then
    ./load_overwrite.sh
fi

echo '[.] Generate very long argument'
# current PATH_MAX is 4096 in Linux.
FLONG="x"
for i in $(seq 10); do
    FLONG=$FLONG$FLONG
done

echo '[.] run overwrite program with very long argument'
./overwrite -dirs:1 -path:$FLONG
