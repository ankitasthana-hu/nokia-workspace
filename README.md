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




