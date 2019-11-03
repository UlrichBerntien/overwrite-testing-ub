#!/usr/bin/env bash

# load and compile the overwrite program
echo '[.] load and compile overwrite'
./load_overwrite.sh > system.log 2>&1

# run all test cases
for shf in ./??_*.sh
do
    echo "[.] run test script $shf"
    if [[ -x $shf ]]; then
        ./$shf > ${shf/\.sh/.log} 2>&1
    fi
done
