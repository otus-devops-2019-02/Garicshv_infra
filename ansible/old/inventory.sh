#! /bin/bash

function list(){
	echo "{"
	printf "    \"servers\": ["
	for i in $(gcloud compute instances list | awk '{print $1}'); 
		do
		if [ $i == "NAME" ] 
		then
			continue
		fi	 
		printf "\"$i\", "; 
	done;
	printf "],\n"
	echo "}"
}

function usage(){
	echo "Usage:"
	echo "$0 --list"
	echo "$0 --host"
}

function host(){
	echo "{"
        	echo "    \"foo1\": \"bar1\", ";
		echo "    \"foo2\": \"bar2\", ";
		echo "    \"foo3\": \"bar3\", ";
	echo "}"	
}
case $1 in 
	
	--list)
	list
	;;
	
	--host)
	host
	;;
	
	*)
	usage
	#list
	;;
esac

