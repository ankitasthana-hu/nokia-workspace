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
   \
resource "aws_security_group" "allow-ssh" \{\
  vpc_id      = "vpc-010b7601e4689379b"\
  name        = "$\{var.sg_name\}"\
  description = "security group that allows ssh and all egress traffic"\
  egress \{\
    from_port   = 0\
    to_port     = 0\
    protocol    = "-1"\
    cidr_blocks = ["0.0.0.0/0"]\
  \}\
\
  ingress \{\
    from_port   = 22\
    to_port     = 22\
    protocol    = "tcp"\
    cidr_blocks = ["0.0.0.0/0"]\
  \}\
  ingress \{\
    from_port   = "$\{var.customport\}"  \
    to_port     = "$\{var.customport\}"\
    protocol    = "tcp"\
    cidr_blocks = ["176.63.8.173/32"] # MyIP\
  \}\
  ingress \{\
    from_port   = "$\{var.customport\}"\
    to_port     = "$\{var.customport\}"\
    protocol    = "tcp"\
    cidr_blocks = ["131.228.2.0/27"]\
  \}\
  ingress \{\
    from_port   = "$\{var.customport\}"\
    to_port     = "$\{var.customport\}"\
    protocol    = "tcp"\
    cidr_blocks = ["131.228.32.160/27"]\
  \}\
\
  tags = \{\
    Name = "$\{var.sg_name\}"\
  \}\
\}}