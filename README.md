# Nokia-Workspace
=================


## Website endpoints ( expose to required ip ranges )

http://34.201.250.10:5000/
http://34.201.250.10:5000/nokia

As per requirement, expose to required IP ranges.

<img width="527" alt="Screenshot 2022-04-03 at 0 53 18" src="https://user-images.githubusercontent.com/59736927/161403986-4a8eb296-e733-48ec-87eb-6d20db50a3fe.png">

Under Deployment Server ( For Jenkins Installation ). Please refer jenkins.tf for terraform code and .rtf for terraform output log.

>>
>>-rwxrwxrwx 1 root     root       416 Apr  2 22:36 jenkinskey.pub
>>-rwxrwxrwx 1 root     root      1679 Apr  2 22:36 jenkinskey
>>-rw-rw-r-- 1 ec2-user ec2-user  2067 Apr  2 22:43 jenkins.tf
>>drwxrwxr-x 3 ec2-user ec2-user    21 Apr  2 22:43 .terraform
>>-rw-rw-r-- 1 ec2-user ec2-user 11001 Apr  2 22:46 terraform.tfstate
>>drwx------ 5 ec2-user ec2-user   164 Apr  2 22:49 ..
>>drwxrwxr-x 3 ec2-user ec2-user   107 Apr  2 22:49 .
>>

#### Note :
###### main.py is small sample flask python web application.

After Jenkins Installation, couple of plugins installed like 
1. terraform, git etc.
2. Created GIThub token in secret text etc.
3. AWS secret key and access key stored as credential

Setup Flow
=============
>> Spin up deployment server to execute Jenkins infra terraform ( jenkins-terraform/). Preparation will be install terraform and configure aws.
>> remote-exec output will give you admin password for Jenkins so that you can login
>> Store AWS access & secret key in Jenkins Credential and install terraform plugin
>> Use attached Jenkinsfile and execute web instance in HA mode ( autoscaling is set ).
>> Jenkinsfile has operation to execute plan, apply and destroy.

Flask python web application is accessible as below 
=================

<img width="521" alt="Screenshot 2022-04-02 at 23 12 40" src="https://user-images.githubusercontent.com/59736927/161406706-f1874131-58b7-46fe-b605-d2aa8d4f8914.png">

<img width="528" alt="Screenshot 2022-04-02 at 23 11 55" src="https://user-images.githubusercontent.com/59736927/161406713-11db19b4-41fc-4361-af95-771712cff78c.png">

<img width="544" alt="Screenshot 2022-04-03 at 6 58 36" src="https://user-images.githubusercontent.com/59736927/161412296-e0a065fd-c56f-41e3-9c12-5d7f3f642c39.png">



Terraform INIT , PLAN AND APPLY LOG
=======================================

`[ec2-user@ip-172-31-24-47 nokia-workspace]$ terraform init
Initializing modules...
- module.web-sg

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "aws" (2.70.0)...
- Downloading plugin for provider "template" (2.2.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.template: version = "~> 2.2"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[ec2-user@ip-172-31-24-47 nokia-workspace]$ terraform apply -auto-approve

Warning: template_file.user_data: using template_file as a resource is deprecated; consider using the data source instead



template_file.user_data: Creating...
  rendered:     "" => "<computed>"
  template:     "" => "app_install.tpl"
  vars.%:       "" => "1"
  vars.cluster: "" => "flask"
template_file.user_data: Creation complete after 0s (ID: 6b02e5327274de806c203cd4531128783fb195938f792b29a9003a1f548a68d7)
aws_key_pair.mykeypair: Creating...
  arn:         "" => "<computed>"
  fingerprint: "" => "<computed>"
  key_name:    "" => "nokiakey"
  key_pair_id: "" => "<computed>"
  public_key:  "" => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgYainYTJatoG3neEH0QRB5od6YjSV1KT5WJf2iqxuTjq8Ql9GPKatnNbDDFmX93QTtyfVxQW3ViP1uG6DYkR7nwf+cAbNePhMSMZyqN3ebbkRp68G83wM60szVmQD7cnHJNUWF/RWVv+tyUlHt2VV/fTlf9EzLlZbGXAuYxO14Kg5cmA8bn8k71g/uPrhzkPUbSnFcqsiulb5+7zD22tQMuj5JTDEtzIwWNYYqNGRLEEroQibrqAXKwqSWbYwX1MMvqPMxzbO8a2Lgc7W/1M+IBsdx+JypCDQMdAQuSBnLqpLR3rxgGKyJ5ZMs7kGRh/5sVCYyDVOF6YMM3K4JLNb ec2-user@ip-172-31-24-47.ec2.internal"
module.web-sg.aws_security_group.allow-ssh: Creating...
  arn:                                   "" => "<computed>"
  description:                           "" => "security group that allows ssh and all egress traffic"
  egress.#:                              "" => "1"
  egress.482069346.cidr_blocks.#:        "" => "1"
  egress.482069346.cidr_blocks.0:        "" => "0.0.0.0/0"
  egress.482069346.description:          "" => ""
  egress.482069346.from_port:            "" => "0"
  egress.482069346.ipv6_cidr_blocks.#:   "" => "0"
  egress.482069346.prefix_list_ids.#:    "" => "0"
  egress.482069346.protocol:             "" => "-1"
  egress.482069346.security_groups.#:    "" => "0"
  egress.482069346.self:                 "" => "false"
  egress.482069346.to_port:              "" => "0"
  ingress.#:                             "" => "4"
  ingress.143155405.cidr_blocks.#:       "" => "1"
  ingress.143155405.cidr_blocks.0:       "" => "131.228.2.0/27"
  ingress.143155405.description:         "" => ""
  ingress.143155405.from_port:           "" => "5000"
  ingress.143155405.ipv6_cidr_blocks.#:  "" => "0"
  ingress.143155405.prefix_list_ids.#:   "" => "0"
  ingress.143155405.protocol:            "" => "tcp"
  ingress.143155405.security_groups.#:   "" => "0"
  ingress.143155405.self:                "" => "false"
  ingress.143155405.to_port:             "" => "5000"
  ingress.1791048031.cidr_blocks.#:      "" => "1"
  ingress.1791048031.cidr_blocks.0:      "" => "131.228.32.160/27"
  ingress.1791048031.description:        "" => ""
  ingress.1791048031.from_port:          "" => "5000"
  ingress.1791048031.ipv6_cidr_blocks.#: "" => "0"
  ingress.1791048031.prefix_list_ids.#:  "" => "0"
  ingress.1791048031.protocol:           "" => "tcp"
  ingress.1791048031.security_groups.#:  "" => "0"
  ingress.1791048031.self:               "" => "false"
  ingress.1791048031.to_port:            "" => "5000"
  ingress.2541437006.cidr_blocks.#:      "" => "1"
  ingress.2541437006.cidr_blocks.0:      "" => "0.0.0.0/0"
  ingress.2541437006.description:        "" => ""
  ingress.2541437006.from_port:          "" => "22"
  ingress.2541437006.ipv6_cidr_blocks.#: "" => "0"
  ingress.2541437006.prefix_list_ids.#:  "" => "0"
  ingress.2541437006.protocol:           "" => "tcp"
  ingress.2541437006.security_groups.#:  "" => "0"
  ingress.2541437006.self:               "" => "false"
  ingress.2541437006.to_port:            "" => "22"
  ingress.3236220837.cidr_blocks.#:      "" => "1"
  ingress.3236220837.cidr_blocks.0:      "" => "176.63.8.173/32"
  ingress.3236220837.description:        "" => ""
  ingress.3236220837.from_port:          "" => "5000"
  ingress.3236220837.ipv6_cidr_blocks.#: "" => "0"
  ingress.3236220837.prefix_list_ids.#:  "" => "0"
  ingress.3236220837.protocol:           "" => "tcp"
  ingress.3236220837.security_groups.#:  "" => "0"
  ingress.3236220837.self:               "" => "false"
  ingress.3236220837.to_port:            "" => "5000"
  name:                                  "" => "web_sg"
  owner_id:                              "" => "<computed>"
  revoke_rules_on_delete:                "" => "false"
  tags.%:                                "" => "1"
  tags.Name:                             "" => "web_sg"
  vpc_id:                                "" => "vpc-03236815ac57df9f7"
aws_key_pair.mykeypair: Creation complete after 1s (ID: nokiakey)
module.web-sg.aws_security_group.allow-ssh: Creation complete after 3s (ID: sg-05c83131972e0116e)
aws_launch_configuration.nokia-launchconfig: Creating...
  arn:                         "" => "<computed>"
  associate_public_ip_address: "" => "true"
  ebs_block_device.#:          "" => "<computed>"
  ebs_optimized:               "" => "<computed>"
  enable_monitoring:           "" => "true"
  image_id:                    "" => "ami-0c02fb55956c7d316"
  instance_type:               "" => "t2.medium"
  key_name:                    "" => "nokiakey"
  name:                        "" => "<computed>"
  name_prefix:                 "" => "nokia-launchconfig1"
  root_block_device.#:         "" => "<computed>"
  security_groups.#:           "" => "1"
  security_groups.2291939344:  "" => "sg-05c83131972e0116e"
  user_data:                   "" => "707ee9337a6343c12d00352e8a28a0857c2164ca"
aws_launch_configuration.nokia-launchconfig: Creation complete after 0s (ID: nokia-launchconfig120220403101811848500000001)
aws_autoscaling_group.nokia-autoscaling: Creating...
  arn:                               "" => "<computed>"
  default_cooldown:                  "" => "<computed>"
  desired_capacity:                  "" => "<computed>"
  force_delete:                      "" => "true"
  health_check_grace_period:         "" => "300"
  health_check_type:                 "" => "EC2"
  launch_configuration:              "" => "nokia-launchconfig120220403101811848500000001"
  load_balancers.#:                  "" => "<computed>"
  max_size:                          "" => "4"
  metrics_granularity:               "" => "1Minute"
  min_size:                          "" => "2"
  name:                              "" => "nokia-autoscaling"
  protect_from_scale_in:             "" => "false"
  service_linked_role_arn:           "" => "<computed>"
  tag.#:                             "" => "1"
  tag.840587851.key:                 "" => "Name"
  tag.840587851.propagate_at_launch: "" => "true"
  tag.840587851.value:               "" => "Nokia_Web_Instance"
  target_group_arns.#:               "" => "<computed>"
  vpc_zone_identifier.#:             "" => "3"
  vpc_zone_identifier.110646682:     "" => "subnet-0b30cdaa94ac82998"
  vpc_zone_identifier.3559984855:    "" => "subnet-0933807cfaf2dd0c3"
  vpc_zone_identifier.4232674840:    "" => "subnet-0c0df991b95469b32"
  wait_for_capacity_timeout:         "" => "10m"
aws_autoscaling_group.nokia-autoscaling: Still creating... (10s elapsed)
aws_autoscaling_group.nokia-autoscaling: Still creating... (20s elapsed)
aws_autoscaling_group.nokia-autoscaling: Still creating... (30s elapsed)
aws_autoscaling_group.nokia-autoscaling: Still creating... (40s elapsed)
aws_autoscaling_group.nokia-autoscaling: Still creating... (50s elapsed)
aws_autoscaling_group.nokia-autoscaling: Still creating... (1m0s elapsed)
aws_autoscaling_group.nokia-autoscaling: Still creating... (1m10s elapsed)
aws_autoscaling_group.nokia-autoscaling: Creation complete after 1m18s (ID: nokia-autoscaling)

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
`


