INSTANCE_NAME=reddit-app-startup-script
echo "Deleting instance [$INSTANCE_NAME]..."
gcloud compute instances delete -q $INSTANCE_NAME
echo "Creating instance [$INSTANCE_NAME]"...
gcloud compute instances create $INSTANCE_NAME\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file=startup-script=/home/kvaga/otus/devops/Garicshv_infra/startup_script.sh
