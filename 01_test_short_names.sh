#!/usr/bin/env bash

RAW='/tmp/RAWdata'
FS='/tmp/testfs'

if [[ $EUID != 0 ]]; then
    echo "[!] mount/unmount operations needs root privilege"
    exit
fi

echo '[.] Create a small test drive'
dd bs=1k count=256 if=/dev/zero of=$RAW
echo '[.] Create FAT file system and mount'
mkfs.fat $RAW
mkdir $FS
mount $RAW $FS

echo '[.] Create 2 short name test files in the root directory'
echo 'content' > $FS/FRGNTHI0.TXT
echo 'content' > $FS/FRGNTHI1.TXT
ls -al $FS
echo '[.] delete the first test file'
rm $FS/FRGNTHI0.TXT
ls -al $FS

./load_overwrite.sh
echo '[.] run overwrite program'
./overwrite -rand -block:512 -files:10 -data:10mb -path:$FS/

echo '[.] unmount the test file system'
sync -f $FS
umount $FS

echo '[.] check the metadata, read the directory block'
hexdump -s 1536 -n 512 -C $RAW 

if grep 'RGNTHI0' $RAW; then
    echo '[X] file name rest found on test drive!'
else
    echo '[O] passed. No file name rest found'
fi
echo '[.] clean up'
rmdir $FS
rm $RAW
