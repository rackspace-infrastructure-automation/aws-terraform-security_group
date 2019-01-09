output "public_rdp_security_group_id" {
  description = "Public RDP Security Group ID"
  value       = "${module.test_sg.public_rdp_security_group_id}"
}

output "private_rdp_security_group_id" {
  description = "Private RDP Security Group ID"
  value       = "${module.test_sg.private_rdp_security_group_id}"
}

output "elastic_cache_memcache_security_group_id" {
  description = "ElasticCache Memcache Security Group ID"
  value       = "${module.test_sg.elastic_cache_memcache_security_group_id}"
}

output "elastic_cache_redis_security_group_id" {
  description = "ElasticCache Redis Security Group ID"
  value       = "${module.test_sg.elastic_cache_redis_security_group_id}"
}

output "public_ssh_security_group_id" {
  description = "Public SSH Security Group ID"
  value       = "${module.test_sg.public_ssh_security_group_id}"
}

output "private_ssh_security_group_id" {
  description = "Private SSH Security Group ID"
  value       = "${module.test_sg.private_ssh_security_group_id}"
}

output "public_web_security_group_id" {
  description = "Public Web Security Group ID"
  value       = "${module.test_sg.public_web_security_group_id}"
}

output "private_web_security_group_id" {
  description = "Private Web Security Group ID"
  value       = "${module.test_sg.private_web_security_group_id}"
}

output "nfs_security_group_id" {
  description = "NFS Security Group ID"
  value       = "${module.test_sg.nfs_security_group_id}"
}

output "efs_security_group_id" {
  description = "EFS Security Group ID"
  value       = "${module.test_sg.efs_security_group_id}"
}

output "eks_control_plane_security_group_id" {
  description = "EKS Control Plane Security Group ID"
  value       = "${module.test_sg.eks_control_plane_security_group_id}"
}

output "eks_worker_security_group_id" {
  description = "EKS Worker Security Group ID"
  value       = "${module.test_sg.eks_worker_security_group_id}"
}

output "mssql_security_group_id" {
  description = "MS SQL DB Security Group ID"
  value       = "${module.test_sg.mssql_security_group_id}"
}

output "mysql_security_group_id" {
  description = "MySQL DB Security Group ID"
  value       = "${module.test_sg.mysql_security_group_id}"
}

output "oracle_security_group_id" {
  description = "Oracle DB Security Group ID"
  value       = "${module.test_sg.oracle_security_group_id}"
}

output "postgres_security_group_id" {
  description = "Postgres DB Security Group ID"
  value       = "${module.test_sg.postgres_security_group_id}"
}

output "redshift_security_group_id" {
  description = "Redshift Security Group ID"
  value       = "${module.test_sg.redshift_security_group_id}"
}

output "private_ecs_security_group_id" {
  description = "Private ECS Security Group ID"
  value       = "${module.test_sg.private_ecs_security_group_id}"
}

output "vpc_endpoint_security_group_id" {
  description = "VPC Endpoint Security Group ID"
  value       = "${module.test_sg.vpc_endpoint_security_group_id}"
}
