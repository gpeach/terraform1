provider "aws" {
  region = "us-east-1"
}

variable "ingressrules" {
  type = list(number)
  default = [80,443]
}

variable "egressrules" {
  type = list(number)
  default = [80,443]
}

resource "aws_instance" "db_server" {
  ami = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  tags = {
    Name = "DBServer"
  }
}

output "db_server_ip" {
  value = aws_instance.db_server.public_ip
}

resource "aws_instance" "web_server" {
  ami = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  tags = {
    Name = "WebServer"
  }
  security_groups = [aws_security_group.allow_web_traffic.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello from Terraform</h1>" | sudo tee /var/www/html/index.html
              EOF
}

resource "aws_eip" "web_server_ip" {
  instance = aws_instance.web_server.id
}

output "web_server_ip" {
  value = aws_eip.web_server_ip.public_ip
}

resource "aws_security_group" "allow_web_traffic" {
  name="Allow HTTPS and HTTP"

  dynamic ingress {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic egress {
    iterator = port
    for_each = var.egressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
