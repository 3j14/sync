#!/bin/bash
###########################################################################
# Usage:
#    .sync_files.sh FROM TO
#    Arguments:
#        FROM     Directory which should be syncronised
#        TO       Directory to syncronise to
#
#
# Copyright 2018 Jonas Drotleff <jonas.drotleff@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###########################################################################


FROM=$1
TO=$2
DATE=$(date +%Y-%m-%d)

if [ ! -d $FROM ]
then
    echo "$FROM: Not a directory"
    echo "Done"
    exit 1
fi

if [ -d $TO ]
then
    echo "Check for updated files..."
    # if [ "$(diff -rq $FROM/ $TO/)" ]
    # use line above to use diff to check for changes
    # might make it much slower
    if [ 1 ]
    then
        echo "Files have changed, perform update"
        BACKUP_VERSION=1
        while [ -d $TO/../backup-$DATE-$BACKUP_VERSION ]
        do
            ((BACKUP_VERSION++))
        done
        echo "Create backup-$DATE-$BACKUP_VERSION"
        rsync -au $TO $TO/../backup-$DATE-$BACKUP_VERSION
    else
        echo "No files changed"
        echo "Done"
        exit 0
    fi
else
    if [ -d $TO/.. ]
    then
        echo "$TO not found. Directory will be created"
    else
        echo "Parent directory not found. No files changed"
        echo "Done"
        exit 1
    fi
fi

echo "Sync files"
rsync -au --delete $FROM/ $TO/
echo "Done"
