#! /bin/bash

source gcp.lib.sh
PROJECT_NAME=infra-237719
echo PROJECT_NAME=$PROJECT_NAME;
INSTANCE_NAME=instance-reddit-full-$(date +%s)
echo INSTANCE_NAME=$INSTANCE_NAME;
IMAGE_NAME=reddit-base-1559710950
echo IMAGE_NAME=$IMAGE_NAME

function usage(){
	echo "Usage:"
	echo "$0 create_instance"
	exit 1
}

case $1 in
	create_instance)
		create_instance
	;;
	*)
		usage
	;;
esac

