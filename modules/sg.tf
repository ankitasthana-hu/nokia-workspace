provider "aws" {
  region     = "us-east-1"
  version = "v2.70.0"
}



   
resource "aws_security_group" "allow-ssh" {
  vpc_id      = "vpc-03c58ec4d1806289c"
  name        = "${var.sg_name}"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "${var.customport}"  
    to_port     = "${var.customport}"
    protocol    = "tcp"
    cidr_blocks = ["176.63.8.173/32"] # MyIP
  }
  ingress {
    from_port   = "${var.customport}"
    to_port     = "${var.customport}"
    protocol    = "tcp"
    cidr_blocks = ["131.228.2.0/27"]
  }
  ingress {
    from_port   = "${var.customport}"
    to_port     = "${var.customport}"
    protocol    = "tcp"
    cidr_blocks = ["131.228.32.160/27"]
  }

  tags = {
    Name = "${var.sg_name}"
  }
}
