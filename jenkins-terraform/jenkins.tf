{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\csgray\c0;}
\paperw11900\paperh16840\margl1440\margr1440\vieww28600\viewh18000\viewkind0
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f0\fs22 \cf2 \CocoaLigature0 provider "aws" \{\
  region     = "us-east-1"\
  version = "v2.70.0"\
\}\
\
\
\
module "web-sg" \{\
  source         = "../modules/sg"\
  sg_name        = "web_sg"\
  customport     = "8080"\
\}\
\
resource "aws_key_pair" "mykey" \{\
  key_name   = "mykey"\
  public_key = "$\{file("jenkinskey.pub")\}"\
\}\
\
# resource block\
resource "aws_instance" "jenkins" \{\
  ami             = "ami-0c02fb55956c7d316"\
  instance_type   = "t2.medium"\
  security_groups = [ "$\{module.web-sg.security_group_id\}" ]\
  key_name        = "$\{aws_key_pair.mykey.key_name\}"\
  provisioner "remote-exec"  \{\
    inline  = [\
      "sudo amazon-linux-extras install -y java-openjdk11",\
      "java -version",\
      "sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo",\
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",\
      "sudo yum install -y jenkins",\
      "sudo chkconfig jenkins on",\
      "sudo service jenkins start",\
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword",\
      ]\
   \}\
  connection \{\
    type         = "ssh"\
    host         = "$\{self.public_ip\}"\
    user         = "ec2-user"\
    private_key  = "$\{file("jenkinskey")\}"\
   \}\
   tags  = \{\
    "Name"      = "Jenkins-Server-Terraform"\
      \}\
 \}}