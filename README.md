 
```markdown
# Jenkins Setup

1. Install Node.js 16.x and Yarn:

```bash
curl -s https://deb.nodesource.com/setup_16.x | sudo bash
npm install -g yarn
```

2. Install OpenJDK 11:

```bash
sudo apt update
sudo apt install openjdk-11-jdk
```

3. Install Jenkins:

```bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

4. Access Jenkins:

Visit `http://your_server_ip_or_domain:8080` in your web browser.

5. Retrieve Jenkins Unlock Key:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Copy the password and paste it in the Jenkins web interface to proceed with the setup.

6. Open Port 8080 for Jenkins (if using a firewall):

```bash
sudo ufw allow 8080
```

7. Jenkins GitHub Webhook:

Add a GitHub webhook with the URL `http://your_server_ip_or_domain:8080/github-webhook/`.

# Docker and Docker Compose Setup

Make sure Docker and Docker Compose are installed on your server. If not, use the following commands:

## Install Docker:

```bash
sudo apt update \
&& sudo apt install -y apt-transport-https ca-certificates curl software-properties-common \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
&& sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" \
&& apt-cache policy docker-ce \
&& sudo apt install -y docker-ce \
&& sudo usermod -aG docker ${USER} \
&& sudo systemctl status docker \
&& sudo chmod 666 /var/run/docker.sock
```

## Install Docker Compose:

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
&& sudo chmod +x /usr/local/bin/docker-compose \
&& docker-compose --version \
&& sudo chmod 666 /var/run/docker.sock
```

# Jenkins Pipeline Example:

```groovy
pipeline {
    agent any
    stages {
        stage('Build and Run Docker') {
            steps {
                // Get code from a GitHub repository
                git url: 'https://github.com/ebrahimbd/CICD_practice.git', branch: 'main'

                sh "run_docker.sh"
            }
        }
    }
}
```

Make sure to adjust the GitHub repository URL in the Jenkins pipeline according to your project.
```

Feel free to customize the instructions based on your specific needs.
