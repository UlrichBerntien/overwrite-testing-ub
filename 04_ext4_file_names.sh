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
dd bs=1M count=1 if=/dev/zero of=$RAW
echo '[.] Create ext4 file system and mount'
mkfs.ext4 $RAW
mkdir $FS
mount $RAW $FS

echo '[.] Create test files'
for i in $(seq 5)
do
    echo "content" > "$FS/Testfiles__RaeQu3ho__${i}__"
done
ls -l $FS
echo '[.] Delete all test files'
rm $FS/Testfiles__*
ls -l $FS

echo '[.] run overwrite to overwrite 10 dir entries'
./overwrite -dirs:10 -path:$FS

echo '[.] unmount the test file system'
sync -f $FS
umount $FS

echo '[.] check the data on the test drive'
hexdump -C $RAW 

if grep '_RaeQu3ho_' $RAW; then
    echo '[X] file name rest found on test drive!'
else
    echo '[O] passed. No file name rest found'
fi

echo '[.] clean up'
rmdir $FS
rm $RAW
