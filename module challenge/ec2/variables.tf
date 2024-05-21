variable "ec2name" {
  type = string
  default = null
}

variable "security_groups" {
  type = list(string)
  default = null
}

variable "user_data" {
  type = string
  default = null
}
