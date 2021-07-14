#!/bin/bash


sudo apt -y update
sudo apt -y upgrade

sudo apt -y autoremove

sudo apt -y install apt-transport-https ca-certificates curl gnupg lsb-release

#install docker repo keys
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg

#add docker apt repo
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt -y update

sudo apt -y install docker-ce docker-ce-cli containerd.io

#allow non-root users to run docker
sudo usermod -aG docker azureuser

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo systemctl start docker

sudo systemctl enable docker

swapon=$(sudo swapon --show)

if [ -z "$swapon" ]; then

    echo "Enabling swap..."

    sudo fallocate -l 4G /swapfile

	sudo chmod 600 /swapfile

	sudo mkswap /swapfile

	sudo swapon /swapfile

	echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
fi

#ssh-keygen -F github.com || ssh-keyscan github.com >> ~/.ssh/known_hosts

# git clone git@github.com:LakesideLabs/inventory.bootstrap.git

# cd inventory.boostrap/Traefik
# export DOMAIN_NAME=domain
# chmod +x start_traefik.sh
