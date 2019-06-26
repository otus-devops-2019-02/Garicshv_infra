#! /bin/bash

function list(){
echo "{"
printf "    \"servers\": ["
for i in $(gcloud compute instances list | awk '{print $1}'); 
	do 
	printf "\"$i\", "; 
done;
printf "]\n"
echo "}"
}

function usage(){
	echo "Usage:"
	echo "$0 --list"
}

case $1 in 
	--list)
	list
	;;
	*)
	usage
	;;
esac

