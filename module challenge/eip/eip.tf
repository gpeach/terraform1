resource "aws_eip" "web_server_ip" {
  instance = var.instance_id
}

output "eip" {
  value = aws_eip.web_server_ip.public_ip
}
