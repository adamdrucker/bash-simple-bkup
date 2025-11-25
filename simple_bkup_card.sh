#!/bin/bash

today=$(date +%d-%m-%Y)

# get the latest backup from local dir
newfile=$(ls -tp /home/adam/Backups | grep -v /$ | head -1)

# get latest timeshit snap
newsnap=$(ls -tp /timeshift/snapshots | head -1)

# copy both over to the sd card
cp /home/adam/Backups/$newfile /home/card/backups
cp -r /timeshift/snapshots/$newsnap /home/card/backups

# clean oldest files from card

