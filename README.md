# DxJSH237891z


## About the Project

This project contains detailed documentation for setting up a Full Node on Crypto.org mainnet. The full node is packaged and is deployed through Ansible on to AWS hosts that you will be provisioning using Terraform. By following this documentation, you will be able to provision multiple hosts and deploy as many Crypto.org Mainnet Full Nodes as you please.


### Built With

The project is built using:
* Crypto.org Chain Mainnet
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
* Install WinSCP on local machine.

### AWS EC2 Set Up

1. If you do not already have one, create an AWS account. <b>If you already have an AWS account with a EC2 instance already running, then please skip to the Installation and Setup section</b>.

[How do I create and activate a new AWS account?](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/) 

2. Once you have created your AWS account, please proceed to launch a Amazon Linux 2 AMI (HVM) - Kernel 5.10 EC2 instance.

[How to launch your instance.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/LaunchingAndUsingInstances.html) 

3. You will need a key pair to securely connect to your instance, you must also ensure that you have access to the selected key pair before your launch the instance. Alternatively, you can connect using EC2 Instance Connect. Please refer to the link below on how to connect to your Linux instance once it has been provisioned.

[Connect to your Linux instance.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstances.html) 


### Installation and Setup

* Once you have connected to your Linux EC2 instance, you will need to install Git, Terraform and Ansible in order to carry out the steps in this documentation. Please refer to the following vendor documentation on how to install and set up the applications on your Linux instance. 

1. [Install Git on EC2 instance](https://www.atlassian.com/git/tutorials/install-git#linux) (If you spun up an Amazon Linux 2 AMI then follow the Fedora (dnf/yum) section.)

2. After you have followed the above documentation to install Git, you will need to configure your user name and email address. This is important because every Git interaction uses this information, and you will need to set this up before you can clone a repository. To do so enter the following commands replacing the pseudocode with your own Git username and email:

```
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```


3. [Install Terraform on EC2 instance](https://www.terraform.io/downloads.html)

4. [Install Ansible on EC2 instance](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

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

8. [Install WinSCP on your local machine](https://winscp.net/eng/download.php)


## Implementation

Hosting this application involves X parts.

### Part 1: Clone the repository

* Log on to your EC2 instance and enter the following command to clone this repository:

```
$ git clone https://github.com/armaanPy/DxJSH237891z
```

### Part 2: Copy PEM private key on to EC2 Instance

* In order for Terraform and Ansible to be able to communicate with our EC2 Instance we need to generate a key pair and copy that over to our EC2 instance.
 
* To do so, first we will need to generate a key pair. To do this, navigate to EC2 on the AWS Management Console and on the menu bar navigate to "Network & Security" -> "Key Pairs".

* In the Key Pairs page, click on "Create Key Pair" on the top right hand corner of the page.

* Under the Name section, enter: crypt0def1x

* For Key pair type, select "RSA".

* Finally for the Private key file format, select ".pem". Once you click create, the key file will be downloaded on to your local machine - keep this safe.

* Now using WinSCP, connect to your EC2 instance (using the initial key pair you created to access the EC2 in the first section of the guide).

* Once you are in WinSCP, copy the crypt0def1x.pem file to the ~/.ssh/ location. Note: In order to see the hidden .ssh file you will need to go to WinSCP -> Options -> Preferences -> Panels and tick "Show hidden files"

* Once the crypt0def1x.pem file has been transferred over to ~/.ssh/ on your EC2 instance, you will need to make sure it is not publically viewable, to do so run the following commands.

```
$ cd ~/.ssh
$ chmod 400 crypt0def1x.pem
```


### Part 2: Update Terraform variables

* Within the ~/DxJSH237891z/Zjdh377SZx/variables.tf file, you will need to update the following aws_region default variable to whichever AWS region you wish to provision the EC2 node which will host the Blockchain installation.

```
$ vi ~/DxJSH237891z/Zjdh377SZx/variables.tf

Edit:

variable "aws_region" {
  description = "Hong Kong"
  default     = "ap-east-1"
}
```

i.e. If you are wish to provision the node in North Virginia (us-east-1), then change the description and default variables as intended.


### Part 3: Provision the instance via Terraform

* Now it's time to provision your instance, to do so:

```
$ cd ~/DxJSH237891z/Zjdh377SZx/
$ terraform init
$ terraform plan
$ terraform apply
```

* Once your resources have been created you will notice an output detailing the "vm_public_ip" - note this down as we will need it for our Ansible step. Alternatively, you can find the public IP of the newly provisioned instance from the EC2 page.

* Now if you navigate to the EC2 page, you will see that your newly provisioned instance is now visible with the same public IP that was output.


### Part 3: Update Ansible hosts

* Now you have to update the Ansible inventory.yml with the public IP of the new instance you just provisioned. To do so:

```
$ cd ~/DxJSH237891z/Yh73973jS/
$ vi inventory.yml

Replace [Enter Public IP] with the public IP that was output after your Terraform resource was created (or alternatively get the public IP of your host from the EC2 Instances page.

It should look something like this:

all:
  hosts:
    11.199.252.78
```

### Part 4: Run your Ansible Playbook

* Run your Ansible Playbook using the following commands:

```
$ cd ~/DxJSH237891z/Yh73973jS/
$ ansible-playbook -i inventory.yml application.yml
```
