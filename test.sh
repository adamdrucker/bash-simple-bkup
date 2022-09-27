#!/bin/bash

DIRECTORY="/home/$USER/Test"

back_up() { 
	tar -czvf /home/$USER/Test.tar.gz /home/$USER/Test
}

COUNT=$(ls $DIRECTORY | wc -l)
if [ $COUNT -gt "4" ]; then
	cd $DIRECTORY
	ls -t $DIRECTORY | tail -n +5 | xargs rm -f
	if [ $? == "0" ]; then
		back_up
	fi	
fi

#if [ $COUNT -le "4" ]; then
#	cp -r $DIRECTORY /home/$USER/Test_bk
#	tar -czvf /home/$USER/Test_bk.tar.gz /home/$USER/Test_bk
#fi
