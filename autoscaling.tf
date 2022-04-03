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
  user_data= <<-EOF
             #!/bin/bash
             curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
             ls -lrta
             chmod 777 get-pip.py
             python3 get-pip.py
             pip3 install flask
             export FLASK_APP=main.py
             export FLASK_ENV=development
             echo "from flask import Flask

                   app = Flask(__name__)

                   @app.route("/")
                   def home():
                   return "Hello, World!"
    
                   @app.route("/nokia")
                   def salvador():
                   return "Hello, Nokia"
    
                   if __name__ == "__main__":
                   app.run(host='0.0.0.0', debug=True, port=5000)" > main.py

             flask run --host=0.0.0.0 --port=5000
             EOF
}

resource "aws_autoscaling_group" "nokia-autoscaling" {
  name                      = "nokia-autoscaling"
  vpc_zone_identifier       = ["subnet-0c0df991b95469b32", "subnet-0b30cdaa94ac82998", "subnet-0933807cfaf2dd0c3"]
  launch_configuration      = "${aws_launch_configuration.nokia-launchconfig.name}"
  min_size                  = 2
  max_size                  = 4
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "Nokia_Web_Instance"
    propagate_at_launch = true
  }
}
