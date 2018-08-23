provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

module "base_network" {
  source   = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=v0.0.1"
  vpc_name = "SG-VPC-TEST"
}

module "test_sg" {
  source        = "../../module"
  resource_name = "my_test_sg"
  vpc_id        = "${module.base_network.vpc_id}"
}

output "public_rdp_security_group_id" {
  value = "${module.test_sg.public_rdp_security_group_id}"
}

output "private_rdp_security_group_id" {
  value = "${module.test_sg.private_rdp_security_group_id}"
}

output "elastic_cache_memcache_security_group_id" {
  value = "${module.test_sg.elastic_cache_memcache_security_group_id}"
}

output "elastic_cache_redis_security_group_id" {
  value = "${module.test_sg.elastic_cache_redis_security_group_id}"
}

output "public_ssh_security_group_id" {
  value = "${module.test_sg.public_ssh_security_group_id}"
}

output "private_ssh_security_group_id" {
  value = "${module.test_sg.private_ssh_security_group_id}"
}

output "public_web_security_group_id" {
  value = "${module.test_sg.public_web_security_group_id}"
}

output "private_web_security_group_id" {
  value = "${module.test_sg.private_web_security_group_id}"
}

output "nfs_security_group_id" {
  value = "${module.test_sg.nfs_security_group_id}"
}

output "efs_security_group_id" {
  value = "${module.test_sg.efs_security_group_id}"
}

output "mssql_security_group_id" {
  value = "${module.test_sg.mssql_security_group_id}"
}

output "mysql_security_group_id" {
  value = "${module.test_sg.mysql_security_group_id}"
}

output "oracle_security_group_id" {
  value = "${module.test_sg.oracle_security_group_id}"
}

output "postgres_security_group_id" {
  value = "${module.test_sg.postgres_security_group_id}"
}

output "redshift_security_group_id" {
  value = "${module.test_sg.redshift_security_group_id}"
}

output "private_ecs_security_group_id" {
  value = "${module.test_sg.private_ecs_security_group_id}"
}

output "vpc_endpoint_security_group_id" {
  value = "${module.test_sg.vpc_endpoint_security_group_id}"
}
