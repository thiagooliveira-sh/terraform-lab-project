output "instance_private_ip" {
  value = aws_instance.aws_instance[*].private_ip
}

output "instance_type" {
  value = aws_instance.aws_instance[*].instance_type
}