provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "blockchain_host" {
  ami = "ami-04245319ab784590d"
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.main.id]
  instance_type = var.instance_type
  tags= {
    Name = "blockchain_instance"
  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.blockchain_host.id
  vpc      = true
}
