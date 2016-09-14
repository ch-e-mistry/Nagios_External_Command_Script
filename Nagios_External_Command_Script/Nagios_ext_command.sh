#!/bin/bash

#Target: Script to control nagios from bash. Please fill $SOURCE file with valid values (command, host, service,...).
#Created at: 2016.09.14
#Created by: Mikáczó Péter (SLS)
#Tested on: Nagios® Core™,Version 3.5.1,August 30, 2013 - CentOS release 6.7 (Final)
#USAGE
#	./Nagios_ext_command.sh <my_command_source>
#	where my_command_source --> Specified file with command & filled values for the target host / service / action.
#	For usable command & their syntax, please visit: http://old.nagios.org/developerinfo/externalcommands/commandlist.php?category_id=0&version_id=8&btnSubmit=Update
#EXAMPLE:
# ./Nagios_ext_command.sh /home/pmikaczo/actual_non_working_checks_on_US02

SOURCE=$1

export GREP_COLOR='1;31'
if (( $EUID != 0 )); then
    echo "You must to be root to execute script" | grep --color -E "\b(root|)\b|$"
    exit
fi

while read line
	do
	echo "$line"
	echo "[`date +%s`] $line"  >/var/spool/nagios/cmd/nagios.cmd
done < $SOURCE
exit