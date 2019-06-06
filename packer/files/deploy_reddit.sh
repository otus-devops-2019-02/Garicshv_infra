#! /bin/sh
echo "Deploy reddit..."
git clone -b monolith https://github.com/express42/reddit.git && \
cd reddit && bundle install && \ 
echo "Setting up service..." && \
user=$(who am i) && echo user=$user && curDir=$(pwd) && echo curDir=$curDir && \
sudo systemctl enable puma && \
sudo systemctl start puma && \
sudo systemctl status puma

