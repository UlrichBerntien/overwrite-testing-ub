#!/usr/bin/env bash

RAW='/tmp/RAWdata'
FS='/tmp/testfs'

if [[ $EUID != 0 ]]; then
    echo "[!] mount/unmount operations needs root privilege"
    exit
fi
if [[ ! -x ./overwrite ]]; then
    ./load_overwrite.sh
fi

echo '[.] Create a small test drive'
dd bs=1k count=256 if=/dev/zero of=$RAW
echo '[.] Create FAT file system and mount'
mkfs.fat $RAW
mkdir $FS
mount $RAW $FS

echo '[.] Create 10 test files in the root directory'
for i in $(seq 10)
do
    echo 'content' > $FS/FRGNTHI$i.txt
done
ls -al $FS
echo '[.] delete the 10 test files'
rm $FS/FRGNTHI*.txt
ls -al $FS

echo '[.] run overwrite program with -dirs:20 to overwrite 10 entries'
# Differences between number in -dirs and number of overwrites is
# in the documentation.
./overwrite -dirs:20 -path:$FS/

echo '[.] unmount the test file system'
sync -f $FS
umount $FS

echo '[.] check the metadata, read the directory block'
hexdump -s 1536 -n 768 -C $RAW

if grep 'RGNTHI' $RAW; then
    echo '[X] file name rest found on test drive!'
else
    echo '[O] passed. No file name rest found'
fi

echo '[.] clean up'
rmdir $FS
rm $RAW
