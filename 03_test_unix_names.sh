#!/usr/bin/env bash

RAW='/tmp/RAWdata'
FS='/tmp/testfs'

# The character ̷ is not characther /
UNIX_DIR_NAMES="simple colon: backslash\\ unicode̷"

if [[ $EUID != 0 ]]; then
    echo "[!] mount/unmount operations needs root privilege"
    exit
fi
if [[ ! -x ./overwrite ]]; then
    ./load_overwrite.sh
fi

echo '[.] Create a small test drive'
dd bs=1M count=2 if=/dev/zero of=$RAW
echo '[.] Create ext4 file system and mount'
mkfs.ext4 $RAW
mkdir $FS
mount $RAW $FS

echo '[.] Create test directories'
for name in $UNIX_DIR_NAMES
do
    mkdir "$FS/$name"
done
ls -al $FS

echo '[.] run overwrite program'
for name in $UNIX_DIR_NAMES
do
    echo "[.] call: ./overwrite -dirs:10 -path:$FS/$name"
    ./overwrite -dirs:10 "-path:$FS/$name"
done

echo '[.] clean up'
rmdir $FS
rm $RAW
