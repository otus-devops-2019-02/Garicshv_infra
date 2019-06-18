#! /bin/bash

source ../packer/gcp.lib.sh
PROJECT_NAME=infra-237719
echo PROJECT_NAME=$PROJECT_NAME;
INSTANCE_NAME=instance-reddit-full-$(date +%s)
echo INSTANCE_NAME=$INSTANCE_NAME;
IMAGE_NAME=reddit-base-1559710950
echo IMAGE_NAME=$IMAGE_NAME

function usage(){
	echo "Usage:"
	echo "$0 create_instance"
	echo "$0 get_firewall_rules"
	echo "$0 import_external_resource_default_allow_ssh"
	exit 1
}

case $1 in
	create_instance)
	create_instance
	;;
	get_firewall_rules)
	echo "Getting firewall rules from GCP..."
	get_firewall_rules
	;;
	import_external_resource_default_allow_ssh)
	echo "Importing external resource [default-allow-ssh] into local terraform's resource[google_compute_firewall.firewall_ssh]"
	import_external_resource google_compute_firewall.firewall_ssh default-allow-ssh
	;;
	*)
	usage
	;;
esac

