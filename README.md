# Overwrite Experiments

Experiments with the overwrite program.

## The overwrite program

The overwrite program is an open source program from [Ivo Gjorgjievski](https://github.com/ivoprogram).

The overwrite program is published on the [web page](https://ivoprogram.github.io/content/en/index.html).
The program description is publiched in the [web page](https://ivoprogram.github.io/content/en/index.html).
> Overwrite is a program that overwrites empty space on disk, metadata and data.

Overwrite is a written in standard C. The source code is published on a [github repository](https://github.com/ivoprogram/overwrite)

## Tests

The files ".sh" are bash shell scripts.
The files ".log" are output of the script files.

**00_test_same_directory**

Overwrite Version 1.0 2019-10-04 creates the file in a subdirectory.
So only one directory entry in the given path was overwritten.

Overwrite Version 1.3.1 2019-10-30 uses short directory names too
overwrite entries. If entries with long names should be overwritten
2 or more entries are needed to overwrite one.
(FAT file system)

The documentation of overwrite version 1.4.1 2019-11-03 advices
to set a higher number in -dirs parameter to overwrite all
directory entries.

**01_test_short_names**

Overwrite ver1.2-2019-10-28 create files with long names.
So the directory entry with short name inside the directory
list was not overwritten.
(FAT file system)

Overwrite Version 1.3.1 2019-10-30 uses short directory names too
overwrite entries.

**02_test_overflow**

Overwrite version 1.3.1 2019-10-30 uses strcpy and strcat without
checking the string length. So a very long path name argument
causes a buffer overflow.

Overwrite version 1.4.1 2019-11-03 handles also very long path names.

**03_test_unix_names**

Overwrite version 1.4.1 2019-11-03 handles path names with ':' and
'\' at the end not correct. A workaround is possible: call overwrite
with '/' at the end of the path name.

**04_ext4_file_names**

Demonstrates that -dirs:5 is not enough to overwrite 10 directory
entries in the ext4 file system. (The same on the FAT file system,
more file systems could work like ext4 and FAT.)


## Support files

**load_overwrite.sh**

Load overwrite source from Github and compile it.

**run_all.sh**

Load, compile overwrite program and run all test cases.
