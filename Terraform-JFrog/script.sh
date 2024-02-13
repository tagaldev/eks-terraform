#!/bin/bash
sudo apt update -y
sudo apt install -y default-jdk
java -version
curl -LsS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash -s --
sudo apt update
sudo apt install mariadb-server mariadb-client -y
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo chmod 777 /etc/apt/sources.list.d/artifactory.list
echo "deb https://releases.jfrog.io/artifactory/artifactory-debs xenial main" | tee -a /etc/apt/sources.list.d/artifactory.list
sudo wget -qO - https://releases.jfrog.io/artifactory/api/gpg/key/public | sudo apt-key add -
echo "deb https://releases.jfrog.io/artifactory/artifactory-debs focal main" | sudo tee -a /etc/apt/sources.list
sudo apt-get update -y
sudo apt-get install jfrog-artifactory-oss -y
sudo systemctl start artifactory.service
systemctl status artifactory.service
sudo apt install -y net-tools