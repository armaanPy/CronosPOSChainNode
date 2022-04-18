variable "aws_region" {
  description = "Hong Kong"
  default     = "ap-east-1"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     =  "crypt0def1"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     =  "t3.micro"
}
