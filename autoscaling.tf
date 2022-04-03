module "web-sg" {
  source         = "modules/sg"
  sg_name        = "web_sg"
  customport     = "5000"
}


resource "aws_launch_configuration" "nokia-launchconfig" {
  name_prefix     = "nokia-launchconfig1"
  image_id        = "ami-0c02fb55956c7d316"
  instance_type   = "t2.medium"
  key_name        = "${aws_key_pair.mykeypair.key_name}"
  security_groups = [ "${module.web-sg.security_group_ids}" ]
  associate_public_ip_address = true
  provisioner "file"  {
       source = "main.py"
       destination = "/home/ec2-user/main.py"
       connection {
              type         = "ssh"
              host         = "${self.public_ip}"
              user         = "ec2-user"
              private_key  = "${file("nokia")}"
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
      "flask run --host=0.0.0.0 --port=5000",
      ]
   }
  connection {
    type         = "ssh"
    host         = "${self.public_ip}"
    user         = "ec2-user"
    private_key  = "${file("nokia")}"
   }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "nokia-autoscaling" {
  name                      = "nokia-autoscaling"
  vpc_zone_identifier       = ["subnet-0c65fd7d955f6fee7", "subnet-0ca92403a1cc42a0c", "subnet-09a13d95091746f66", "subnet-0c56741de7259e53c"]
  launch_configuration      = "${aws_launch_configuration.nokia-launchconfig.name}"
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "Nokia_Web_Instance"
    propagate_at_launch = true
  }
}
