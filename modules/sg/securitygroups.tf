output "security_group_id" {
  description = "The ID of the security group"
  value       = [ "${aws_security_group.allow-ssh.name}" ]
}

output "security_group_ids" {
  description = "The ID of the security group"
  value       = [ "${aws_security_group.allow-ssh.id}" ]
}
