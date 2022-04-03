# nokia-workspace


Jenkins URL:
=================
http://44.203.91.63:8080/

As per requirement, expose to required IP ranges.

<img width="527" alt="Screenshot 2022-04-03 at 0 53 18" src="https://user-images.githubusercontent.com/59736927/161403986-4a8eb296-e733-48ec-87eb-6d20db50a3fe.png">

Under Deployment Server ( For Jenkins Installation ). Please refer jenkins.tf for terraform code and .rtf for terraform output log.

{code}
-rwxrwxrwx 1 root     root       416 Apr  2 22:36 jenkinskey.pub
-rwxrwxrwx 1 root     root      1679 Apr  2 22:36 jenkinskey
-rw-rw-r-- 1 ec2-user ec2-user  2067 Apr  2 22:43 jenkins.tf
drwxrwxr-x 3 ec2-user ec2-user    21 Apr  2 22:43 .terraform
-rw-rw-r-- 1 ec2-user ec2-user 11001 Apr  2 22:46 terraform.tfstate
drwx------ 5 ec2-user ec2-user   164 Apr  2 22:49 ..
drwxrwxr-x 3 ec2-user ec2-user   107 Apr  2 22:49 .
{code}


After Jenkins Installation, couple of plugins installed like 
####### terraform, git 
####### created GIThub token in secret text etc.
####### AWS secret key and access key stored as credential

Flask python web application is accessible as below 
=================

<img width="521" alt="Screenshot 2022-04-02 at 23 12 40" src="https://user-images.githubusercontent.com/59736927/161406706-f1874131-58b7-46fe-b605-d2aa8d4f8914.png">

<img width="528" alt="Screenshot 2022-04-02 at 23 11 55" src="https://user-images.githubusercontent.com/59736927/161406713-11db19b4-41fc-4361-af95-771712cff78c.png">


