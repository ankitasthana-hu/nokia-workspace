provider "aws" {
  region     = "us-east-1"
  version = "v2.70.0"
}

module "web-sg" {
  source         = "../modules"
  sg_name        = "web_sg"
  customport     = "5000"
}



resource "aws_key_pair" "mykey" {
  key_name   = "appkey"
  public_key = "${file("appkey.pub")}"
}

# resource block
resource "aws_instance" "webserver" {
  ami             = "ami-0c02fb55956c7d316"
  instance_type   = "t2.medium"
  security_groups = [ "${module.web-sg.security_group_id}" ]
  key_name        = "${aws_key_pair.mykey.key_name}"
  
  provisioner "file"  {
       source = "main.py"
       destination = "/home/ec2-user/main.py"
       connection {
              type         = "ssh"
              host         = "${self.public_ip}"
              user         = "ec2-user"
              private_key  = "${file("appkey")}"
        }
  }

  provisioner "remote-exec"  {
    inline  = [
      "python3 --version",
      "sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py",
      "ls -lrta",
      "sudo chmod 777 get-pip.py",
      "python3 get-pip.py",
      "pip3 install flask",
      "export FLASK_APP=main.py",
      "export FLASK_ENV=development",
      "ls -lrta",
      "flask run --host=0.0.0.0 --port=8080",
      ]
   }
  connection {
    type         = "ssh"
    host         = "${self.public_ip}"
    user         = "ec2-user"
    private_key  = "${file("appkey")}"
   }
   tags  = {
    "Name"      = "Web-Server-Terraform"
      }
 }
