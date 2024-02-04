# my-nuxt-app

## Build Setup

```bash
# install dependencies
$ yarn install

# serve with hot reload at localhost:3000
$ yarn dev

# build for production and launch server
$ yarn build
$ yarn start

# generate static project
$ yarn generate
```

 
"# CICD_practice" 
url -s https://deb.nodesource.com/setup_16.x | sudo bash
npm install -g yarn

sudo apt update
sudo apt install openjdk-11-jdk

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

sudo systemctl start jenkins

sudo systemctl enable jenkins

http://your_server_ip_or_domain:8080

cat /var/lib/jenkins/secrets/initialAdminPassword
