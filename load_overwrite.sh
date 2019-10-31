#!/usr/bin/env bash

echo "[.] Get overwrite program"
curl -s -o overwrite.c https://raw.githubusercontent.com/ivoprogram/overwrite/master/c/overwrite.c
echo "[.] Compile overwrite program"
gcc overwrite.c -o overwrite
