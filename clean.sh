#!/bin/bash
basedir=`dirname $0`


DEMO="JBoss Fuse Getting Started Home Loan Demo"
AUTHORS="Christina Lin, Red Hat"
SRC_DIR=$basedir/installs

FUSE_INSTALL=jboss-fuse-full-6.2.0.redhat-133.zip

SOFTWARE=($FUSE_INSTALL $JDG_INSTALL)


# wipe screen.
clear 

echo

ASCII_WIDTH=57
printf "##  %-${ASCII_WIDTH}s  ##\n" | sed -e 's/ /#/g'
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n" "Setting up the ${DEMO}"
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n" "                #####  #   #  #####  #####"
printf "##  %-${ASCII_WIDTH}s  ##\n" "                #      #   #  #      #"
printf "##  %-${ASCII_WIDTH}s  ##\n" "                #####  #   #  #####  ####"
printf "##  %-${ASCII_WIDTH}s  ##\n" "                #      #   #      #  #"
printf "##  %-${ASCII_WIDTH}s  ##\n" "                #      #####  #####  #####"  
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n" "brought to you by,"
printf "##  %-${ASCII_WIDTH}s  ##\n" "${AUTHORS}"
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n" | sed -e 's/ /#/g'

echo
echo "Cleaning up the ${DEMO} environment..."
echo

#If fuse is running stop it
echo "  - stopping any running fuse instances"
echo
jps -lm | grep karaf | grep -v grep | awk '{print $1}' | xargs kill -KILL



sleep 2 

echo


# If target directory exists remove it
if [ -x target ]; then
		echo "  - deleting existing target directory..."
		echo
		rm -rf target
fi
