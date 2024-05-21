provider "aws" {
  region = "us-east-1"
}

variable "vpcname" {
  description = "The name of the VPC"
  type        = string
  default     = "myvpc"
}

variable "sshport" {
  description = "The port to use for SSH"
  type        = number
  default     = 22
}

variable "enabled" {
  description = "Whether to enable the resource"
  type        = bool
  default     = true
}

variable "mylist" {
  description = "A list of strings"
  type        = list(string)
  default     = ["value1", "value2", "value3"]
}

variable "mymap" {
  description = "A map of strings"
  type        = map
  default     = {
    key1 = "value1"
    key2 = "value2"
  }
}

variable "inputname" {
  type = string
  description = "set the name of the vpc"
}

  resource "aws_vpc" "myvpc" {
    cidr_block           = "10.0.0.0/16"
    tags = {
      Name = var.inputname
    }
  }

  output "vpcid" {
    value = aws_vpc.myvpc.id
  }
