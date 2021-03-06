#! /bin/bash
PROJECT_NAME=infra-237719
echo PROJECT_NAME=$PROJECT_NAME;
INSTANCE_NAME=instance-reddit-full-$(date +%s)
echo INSTANCE_NAME=$INSTANCE_NAME;
IMAGE_NAME=reddit-base-1559710950
echo IMAGE_NAME=$IMAGE_NAME

function create_instance(){
	gcloud compute --project=$PROJECT_NAME instances create $INSTANCE_NAME --zone=europe-west3-c --machine-type=n1-standard-1 --subnet=default --network-tier=PREMIUM --maintenance-policy=MIGRATE --service-account=186550176091-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=http-server,https-server,default-puma-rule --image=$IMAGE_NAME --image-project=$PROJECT_NAME --boot-disk-size=15GB --boot-disk-type=pd-standard --boot-disk-device-name=instance-1
}
function usage(){
	echo "Usage:";
	echo "$0 project-name instance-name image-name";
	exit 1;
}
create_instance

