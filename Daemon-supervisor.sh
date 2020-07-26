#!/bin/bash
#Auther : Jitendra More
#Reported Assigment : Upstox
#Problem Statment
#1. Create a “daemon supervisor”. This tool should check that the process is running and at all times #and starts it in the case it is down.

#It should take these as a parameters:
#	- Seconds to wait between attempts to restart service
#	- Number of attempts before giving up
#	- Name of the process to supervise
#	- Check interval in seconds
#	- Generate logs in case of events.
#Provide the source code and output of supervisor runs for the following examples:


#bash -c "sleep 1 && exit 0"
#bash -c "sleep 5 && exit 0"
#bash -c "sleep 1 && exit 1"
#sh -c "sleep 10 && exit 1"
#bash -c "if [ -f lock ]; then exit 1; fi; sleep 10 && touch lock && exit 1"
#bash -c "if [ -f lock ]; then exit 1; fi; sleep 10 && touch lock && exit 1" (with 1 attempt only)

GRACEPERIOD=$1
MAXATTEMPTS=$2
PROCESS_NAME=$3
INTERVAL=$4
LOGFILE=$5

if [ $# -lt 5 ]
	then 
	echo " Kindly Provide run script as follow "
	echo " Kindly run script as: sh -x $0 args1 args2 args3 args4 args5"
	echo " For example :  $0 "5" "3" "apache2" "5" "/var/log/Daemon-supervisor.log" "
	echo " Args1 - Seconds to wait between attempts to restart service "
	echo " Args2 - Number of attempts before giving up"
	echo " Args3 - Name of the process to supervise"
	echo " Args4 - Check interval in seconds"
	echo " Args5 - Generate logs file in case of events"
	exit 1
fi

if [[ -f "$LOGFILE" ]]
	then
		echo "$LOGFILE is already exist please remove the same"	
		exit 1
	else
		echo "creating $LOGFILE"
		sudo $LOGFILE
fi		

echo "script is executing"
echo $GRACEPERIOD 
echo $ATTEMPTS
echo $PROCESS_NAME
echo $INTERVAL
echo $LOGFILE


servicerestart(){
	echo "Restarting $PROCESS_NAME"
	echo "systemctl restart java.service" 
	if [ $? -eq 0 ]
	then 
		echo "$PROCESS_NAME has been successfully restarted"  >>${LOGFILE} 2>&1
		return 0
	else 
		echo "$PROCESS_NAME hasn't been successfully restarted"  >>${LOGFILE} 2>&1
		return 1	 
	fi	
}


monitorprocess(){
attempts=1

while [[ ${attempts} -lt ${MAXATTEMPTS} ]]
do 
	pid=`ps -ef | grep $PROCESS_NAME | grep IntelliJ | awk '{print $2}' | head -1`
	servicestatus=`ps -ef | grep $PROCESS_NAME | grep IntelliJ | awk '{print $2}' | head -1 | wc -l`
	if [[ $servicestatus -eq 1 ]]
		then	
		echo " $PROCESS_NAME Service with Process id $pid is up"  >>${LOGFILE} 2>&1
		break;
		else
			echo "This is doing check on wait max seconds $MAXATTEMPTS lapsed $attempts for $PROCESS_NAME " >>${LOGFILE} 2>&1
			return 1
		fi
	attempts=$((attempts+1))		
done
}



while [ 1 == 1 ]
do 
	monitorprocess 
	if [ $? == 0 ]
	then 
		sleep $INTERVAL
	else 
		sleep $GRACEPERIOD
		servicerestart   
	fi
done
		













