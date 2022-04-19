#!/bin/bash
echo "Please do not terminate the script, packages are downloading..."
echo ""

# Installing Git
sudo yum install git -y
sleep 5
echo "Git installed."
git --version
echo ""

# Installing Terraform
sudo yum install yum-utils -y
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install terraform -y
sleep 5
echo "Terraform installed."
terraform -version
echo ""

# Installing Ansible
sudo amazon-linux-extras install ansible2 -y
sleep 5
echo "Ansible installed."
ansible --version
echo ""

# Installing AWS CLI 2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo yum install unzip -y
sudo unzip awscliv2.zip
sudo ./aws/install
sleep 5
echo "AWS CLI 2 installed."
aws --version
echo ""
echo "All packages successfully installed or already exist on the system."
echo ""

# Taking in user input for git config
while true; do
  read -p "Enter your GitHub username: " GIT_USER
  read -p "Enter your GitHub email address: " GIT_EMAIL
  echo ""
  echo "The parameters that will be passed to your git config: "
  echo "GitHub username: $GIT_USER"
  echo "GitHub email address: $GIT_EMAIL"
  echo ""
  read -p "Please confirm with y/n if these parameters are correct: " VALIDATE
  echo ""
  if [ "$VALIDATE" = "n" ]; then
    read -p "Re-enter your GitHub username: " GIT_USER
    read -p "Re-enter your GitHub email address: " GIT_EMAIL
    echo ""
    echo "The parameters that will be passed to your git config: "
    echo "GitHub username: $GIT_USER"
    echo "GitHub email address: $GIT_EMAIL"
    echo ""
    git config --global user.name "$GIT_USER"
    git config --global user.email $GIT_EMAIL
    echo "If your details are still incorrect, then please set them manually using the following command(s): "
    echo ""
    echo 'git config --global user.name'
    echo 'git config --global user.email'
    echo ""
    echo "For example: "
    echo 'git config --global user.name "John Doe"'
    echo "git config --global user.email johndoe@example.com"
  elif [ "$VALIDATE" = "y" ]; then
        echo "Details saved and appended to git config."
        git config --global user.name "$GIT_USER"
        git config --global user.email $GIT_EMAIL
    exit
  else
    echo "Please enter either y/n."
    continue
  fi
  break
done
