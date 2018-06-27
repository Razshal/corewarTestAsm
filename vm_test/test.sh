#!/bin/bash

FILES=$(find champs_compiled -name "*.cor")

Black="\033[0;30m"
Red="\033[0;31m"
Green="\033[0;32m"
Yellow="\033[0;33m"
Blue="\033[0;34m"
Purple="\033[0;35m"
Cyan="\033[0;36m"
White="\033[0;37m"
Reset="\033[0m"

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

if [ -f trace ]; then
	rm trace;
fi

if [ -f error ]; then
	rm error;
fi

for i in ${FILES}; do
	echo "${Yellow}Doing $i ${Reset}"
	echo "$i :" >> trace
	if ./corewar $i 2> error | tail -n +1 -f | awk '{printf "\r%lu", NR}'; then
		echo "${Green}Ok !${Reset}" >> trace
		else
		echo "${Red}Failed${Reset}" >> trace
	fi
	echo $Purple; cat error; echo $Reset;
	echo ---------------------------
done
cat trace
cat error
