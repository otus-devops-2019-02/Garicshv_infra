#! /bin/sh
sudo gcloud compute firewall-rules create new-rule --allow tcp:22,tcp:9292

