{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\csgray\c0;}
\paperw11900\paperh16840\margl1440\margr1440\vieww28600\viewh18000\viewkind0
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f0\fs22 \cf2 \CocoaLigature0 output "security_group_id" \{\
  description = "The ID of the security group"\
  value       = [ "$\{aws_security_group.allow-ssh.name\}" ]\
\}\
\
output "security_group_ids" \{\
  description = "The ID of the security group"\
  value       = [ "$\{aws_security_group.allow-ssh.id\}" ]\
\}}