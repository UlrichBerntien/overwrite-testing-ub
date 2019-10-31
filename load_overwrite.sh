#!/usr/bin/env bash

echo "[.] Get overwrite program"
curl -o overwrite.c https://raw.githubusercontent.com/ivoprogram/overwrite/fcbf05663e24b1a2f34ecfcea41e2a1d6f5c1ae9/c/overwrite.c
# curl -o overwrite.c https://raw.githubusercontent.com/ivoprogram/overwrite/master/c/overwrite.c
echo "[.] Compile overwrite program"
gcc overwrite.c -o overwrite
