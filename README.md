# DxJSH237891z


## About the Project

This project contains detailed documentation for setting up a Full Node on Crypto.org mainnet. The full node is packaged and is deployed through Ansible on to AWS hosts that you will be provisioning using Terraform. By following this documentation, you will be able to provision multiple hosts and deploy as many Crypto.org Mainnet Full Nodes as you please.


### Built With

The project is built using,
* AWS
* Terraform
* Ansible


## Getting Started

### Prerequisites
* Spin up an EC2 Instance on AWS.
* Install AWS CLI and configure access keys on EC2.
* Install Git on EC2.
* Install Terraform on EC2.
* Install Ansible on EC2.

### AWS EC2 Set Up

1. If you do not already have one, create an AWS account. <b>If you already have an AWS account with a EC2 instance already running, then please skip to the Installation and Setup section</b>.

[How do I create and activate a new AWS account?](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/) 

2. Once you have created your AWS account, please proceed to launch a Amazon Linux 2 AMI (HVM) - Kernel 5.10 EC2 instance.

[How to launch your instance.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/LaunchingAndUsingInstances.html) 

3. You will need a key pair to securely connect to your instance, you must also ensure that you have access to the selected key pair before your launch the instance. Alternatively, you can connect using EC2 Instance Connect. Please refer to the link below on how to connect to your Linux instance once it has been provisioned.

[Connect to your Linux instance.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstances.html) 


### Installation and Setup

* Once you have connected to your Linux EC2 instance, you will need to install Git, Terraform and Ansible in order to carry out the steps in this documentation. Please refer to the following vendor documentation on how to install and set up the applications on your Linux instance. 

1. [Install Git](https://www.atlassian.com/git/tutorials/install-git#linux)

2. After you have followed the above documentation to install Git, you will need to configure your user name and email address. This is important because every Git interaction uses this information, and you will need to set this up before you can clone a repository. To do so enter the following commands replacing the pseudocode with your own Git username and email:

```
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```


3. [Install Terraform](https://www.terraform.io/downloads.html)

4. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

5. Install the AWS CLI version 2 on Linux. 
- Follow these steps from the command line on your EC2 instance to install the AWS CLI on Linux.

```
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
$ sudo yum install unzip -y
$ sudo unzip awscliv2.zip
$ sudo ./aws/install
$ aws --version
```

6. Create access keys for Terraform.
- To do so, log on to the AWS Management Console, click on your username in the top right hand corner and go to "My Security Credentials".
- Then click on "Access keys" and click on "Create New Access Key".
- This will have created an access key, be sure to download the access key to your local machine as we will be needing it later.

7. Configure your access keys on your EC2 instance.
- On your EC2 command line, enter:

```
$ aws configure 
```

- You will then be prompted to enter your AWS Access Key ID, AWS Secret Access Key and Default region name.
- You can refer to the Access Key you downloaded in step 6 to fill out the first 2 entries, and for the default region name, please use the region you are currently based in (and where you have spun up the EC2 instance). You can find the region name from the top right hand corner i.e. "ap-east-1".


## Implementation

Hosting this application involves three parts.

### Part 1: Standing up the Infrastructure

The infrastructure is setup in AWS using Terraform.

1. cd into the infrastructure folder in the cloned repository.
2. Run the following commands in order
    - terraform init
    - terraform plan
    - terraform apply

This will provision the required infrastructure and provides the EC2 instance public IP as the output.

### Part 2: Installing the application

The next step is to install the required softwares in the EC2 instance and deploy the php application along with the MySQL database. This is done using ansible.

1. Open the inventory.yml file under ansible directory and replace 0.0.0.0 with the public IP copied at the end of part 1.
2. Replace the contents of the ./ansible/secrets/ssh.private with your private key. This is the private key corresponding to the public key used in Part 1 while provisioning the infrastructure using terraform.
3. Run the ansible playbook using the below command
    - ansible-playbook -i inventory.yml application.yml

### Part 3: Tear down the application

Run the below command to tear down the application.

    - terrafrom destroy
