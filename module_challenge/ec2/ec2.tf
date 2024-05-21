resource "aws_instance" "ec2" {
  ami = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  tags = {
    Name = var.ec2name
  }
  security_groups = var.security_groups != null ? var.security_groups : []
  user_data = var.user_data != null ? file(var.user_data): null
}

output "instance_id" {
  value = aws_instance.ec2.id
}

output "instance_ip" {
  value = aws_instance.ec2.public_ip
}
