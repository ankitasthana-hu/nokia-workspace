provider "aws" {
  region     = "us-east-1"
  version = "v2.70.0"
}



   
resource "aws_security_group" "allow-ssh" {
  vpc_id      = "vpc-03c58ec4d1806289c"
  name        = "common-security"
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
    from_port   = 8080  #Jenkins Port
    to_port     = 8080  #Jenkins Port
    protocol    = "tcp"
    cidr_blocks = ["176.63.8.173/32"] # MyIP
  }
  ingress {
    from_port   = 8080  #Jenkins Port
    to_port     = 8080  #Jenkins Port
    protocol    = "tcp"
    cidr_blocks = ["131.228.2.0/27"]
  }
  ingress {
    from_port   = 8080  #Jenkins Port
    to_port     = 8080  #Jenkins Port
    protocol    = "tcp"
    cidr_blocks = ["131.228.32.160/27"]
  }
  ingress {
    from_port   = 5000  #Flask Application Port
    to_port     = 5000  #Flask Application Port
    protocol    = "tcp"
    cidr_blocks = ["131.228.2.0/27"]
  }
  ingress {
    from_port   = 5000  #Flask Application Port
    to_port     = 5000  #Flask Application Port
    protocol    = "tcp"
    cidr_blocks = ["131.228.32.160/27"]
  }
  ingress {
    from_port   = 5000  #Flask Application Port
    to_port     = 5000  #Flask Application Port
    protocol    = "tcp"
    cidr_blocks = ["176.63.8.173/32"] 
  }

  tags = {
    Name = "common-security"
  }
}

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "${file("jenkinskey.pub")}"
}

# resource block
resource "aws_instance" "jenkins" {
  ami             = "ami-0c02fb55956c7d316"
  instance_type   = "t2.medium"
  security_groups = [ "${aws_security_group.allow-ssh.name}" ]
  key_name        = "${aws_key_pair.mykey.key_name}"
  provisioner "remote-exec"  {
    inline  = [
      "sudo amazon-linux-extras install -y java-openjdk11",
      "java -version",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum install -y jenkins",
      "sudo chkconfig jenkins on",
      "sudo service jenkins start",
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword",
      ]
   }
  connection {
    type         = "ssh"
    host         = "${self.public_ip}"
    user         = "ec2-user"
    private_key  = "${file("jenkinskey")}"
   }
   tags  = {
    "Name"      = "Jenkins-Server-Terraform"
      }
 }
