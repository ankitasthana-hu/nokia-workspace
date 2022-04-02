provider "aws" {
  access_key = "AKIA5FZGOBW3S7GYUXID"
  secret_key = "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"
  region     = "us-east-1"
  version = "v2.70.0"
}



   
resource "aws_security_group" "allow-ssh" {
  vpc_id      = "vpc-0f6326f265bce39cd"
  name        = "allow-ssh"
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
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh"
  }
}

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "${file("jenkinskey.pub")}"
}

# resource block
resource "aws_instance" "jenkins" {
  ami             = "ami-0b0af3577fe5e3532"
  instance_type   = "t2.medium"
  security_groups = [ "${aws_security_group.allow-ssh.name}" ]
  key_name        = "${aws_key_pair.mykey.key_name}"
  provisioner "remote-exec"  {
    inline  = [
      "sudo yum install -y jenkins java-11-openjdk-devel",
      "sudo yum -y install wget",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum upgrade -y",
      "sudo yum install jenkins -y",
      "sudo systemctl start jenkins",
      ]
   }
  connection {
    type         = "ssh"
    host         = "${self.public_ip}"
    user         = "ec2-user"
    private_key  = "${file("jenkinskey")}"
   }
   tags  = {
    "Name"      = "Jenkins"
      }
 }
