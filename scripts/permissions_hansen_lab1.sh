#!/bin/bash

if [ -z "$1" ]; then
    echo "running script in current directory"
    RUNDIR="."
else
    RUNDIR=$1
fi

## Everything should have hansen_lab1 as group
echo "Fixing file groups"
find ${RUNDIR} -user ${USER} \! -group hansen_lab1 -exec chgrp hansen_lab1 {} \;

## All directories should be group readable, writeable, executable
##     and not accessible to others
echo "Fixing directory permissions"
find ${RUNDIR} -user ${USER} -type d \! -perm -g+rwxs -exec chmod g+rwxs {} \;
find ${RUNDIR} -user ${USER} -type d \! -perm -o-rwx -exec chmod o-rwx {} \;

## For files, it is a bit more complicated
##   All files should be user and group readable
##   If a file is user writable/executable, the group should be the same
echo "Fixing file permissions"
find ${RUNDIR} -user ${USER} -type f -perm -u+w -perm -g-w -exec chmod g+w {} \;
find ${RUNDIR} -user ${USER} -type f -perm -u+x -perm -g-x -exec chmod g+x {} \;
find ${RUNDIR} -user ${USER} -type f -perm -u+r -perm -g-r -exec chmod g+r {} \;
