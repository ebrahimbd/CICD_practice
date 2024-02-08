#!/bin/bash

# Install Node.js 16.x and Yarn
curl -s https://deb.nodesource.com/setup_16.x | sudo bash
npm install -g yarn

# Install OpenJDK 11
sudo apt update
sudo apt install openjdk-11-jdk

# Install Jenkins
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "Jenkins installation complete. Access Jenkins at: http://your_server_ip_or_domain:8080"
echo "Retrieve Jenkins Unlock Key with: sudo cat /var/lib/jenkins/secrets/initialAdminPassword"

# Open Port 8080 for Jenkins
sudo ufw allow 8080

# Install Docker
sudo apt update \
&& sudo apt install -y apt-transport-https ca-certificates curl software-properties-common \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
&& sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" \
&& apt-cache policy docker-ce \
&& sudo apt install -y docker-ce \
&& sudo usermod -aG docker ${USER} \
&& sudo systemctl status docker \
&& sudo chmod 666 /var/run/docker.sock

echo "Docker installation complete. Docker version:"
docker --version

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
&& sudo chmod +x /usr/local/bin/docker-compose \
&& docker-compose --version \
&& sudo chmod 666 /var/run/docker.sock

echo "Docker Compose installation complete. Docker Compose version:"
docker-compose --version

# Display final instructions
echo "========================================================================"
echo "Make sure your server, whatever it is, has Docker and Docker Compose installed."
echo "Run Jenkins at: http://your_server_ip_or_domain:8080"
echo "Retrieve Jenkins Unlock Key with: sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
echo "Create a GitHub webhook with the URL: http://your_server_ip_or_domain:8080/github-webhook/"
echo "If your system is using a firewall, open port 8080 to allow Jenkins access: sudo ufw allow 8080"
echo "========================================================================"
