provider "aws" {
  region     = "us-east-1"
  version = "v2.70.0"
}



module "web-sg" {
  source         = "../modules/sg"
  sg_name        = "web_sg"
  customport     = "8080"
}

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "${file("jenkinskey.pub")}"
}

# resource block
resource "aws_instance" "jenkins" {
  ami             = "ami-0c02fb55956c7d316"
  instance_type   = "t2.medium"
  security_groups = [ "${module.web-sg.security_group_id}" ]
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
