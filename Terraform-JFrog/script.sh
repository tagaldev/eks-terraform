#!/bin/bash
apt update -y
apt install -y default-jdk
java -version
curl -LsS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash -s --
apt update
apt install mariadb-server mariadb-client -y
systemctl start mariadb
systemctl enable mariadb
echo "deb https://releases.jfrog.io/artifactory/artifactory-debs xenial main" | tee -a /etc/apt/sources.list.d/artifactory.list
curl -fsSL  https://releases.jfrog.io/artifactory/api/gpg/key/public|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/artifactory.gpg
apt update -y
apt install jfrog-artifactory-oss
systemctl start artifactory.service 
systemctl enable artifactory.service
systemctl status artifactory.service
apt install -y net-tools