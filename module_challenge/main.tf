provider "aws" {
  region = "us-east-1"
}

module "securitygroupmodule" {
  source = "./securitygroup"
}

module "dbservermodule" {
  source = "./ec2"
  ec2name = "DB Server"
}

output "db_server_ip" {
  value = module.dbservermodule.instance_ip
}

module "webservermodule" {
  source = "./ec2"
  ec2name = "Web Server"
  security_groups = [module.securitygroupmodule.security_group_name]
  user_data = "server-script.sh"
}

module "eipmodule" {
  source = "./eip"
  instance_id = module.webservermodule.instance_id
}

output "web_server_ip" {
  value = module.eipmodule.eip
}


