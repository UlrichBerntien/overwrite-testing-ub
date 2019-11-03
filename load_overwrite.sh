#!/usr/bin/env bash

echo "[.] Get overwrite program"
curl -s -o overwrite.c https://raw.githubusercontent.com/ivoprogram/overwrite/master/c/overwrite.c
echo "[.] Head of the source file with version info"
head overwrite.c
echo "[.] Compile overwrite program"
gcc overwrite.c -o overwrite
echo "[.] Hashes for version compare"
md5sum overwrite*
echo "[.] used test system"
uname -a
if [[ -r /etc/os-release ]]; then
    grep PRETTY /etc/os-release
fi
