output "efs_security_group_id" {
  description = "EFS Security Group ID"
  value       = aws_security_group.efs_security_group.id
}

output "eks_control_plane_security_group_id" {
  description = "EKS Control Plane Security Group ID"
  value       = aws_security_group.eks_control_plane_security_group.id
}

output "eks_worker_security_group_id" {
  description = "EKS Worker Security Group ID"
  value       = aws_security_group.eks_worker_security_group.id
}

output "elastic_cache_memcache_security_group_id" {
  description = "ElasticCache Memcache Security Group ID"
  value       = aws_security_group.elastic_cache_memcache_security_group.id
}

output "elastic_cache_redis_security_group_id" {
  description = "ElasticCache Redis Security Group ID"
  value       = aws_security_group.elastic_cache_redis_security_group.id
}

output "mssql_security_group_id" {
  description = "MS SQL DB Security Group ID"
  value       = aws_security_group.mssql_security_group.id
}

output "mysql_security_group_id" {
  description = "MySQL DB Security Group ID"
  value       = aws_security_group.mysql_security_group.id
}

output "nfs_security_group_id" {
  description = "NFS Security Group ID"
  value       = aws_security_group.nfs_security_group.id
}

output "oracle_security_group_id" {
  description = "Oracle DB Security Group ID"
  value       = aws_security_group.oracle_security_group.id
}

output "postgres_security_group_id" {
  description = "Postgres DB Security Group ID"
  value       = aws_security_group.postgres_security_group.id
}

output "private_ecs_security_group_id" {
  description = "Private ECS Security Group ID"
  value       = aws_security_group.private_ecs_security_group.id
}

output "private_rdp_security_group_id" {
  description = "Private RDP Security Group ID"
  value       = aws_security_group.private_rdp_security_group.id
}

output "private_ssh_security_group_id" {
  description = "Private SSH Security Group ID"
  value       = aws_security_group.private_ssh_security_group.id
}

output "private_web_security_group_id" {
  description = "Private Web Security Group ID"
  value       = aws_security_group.private_web_security_group.id
}

output "public_rdp_security_group_id" {
  description = "Public RDP Security Group ID"
  value       = aws_security_group.public_rdp_security_group.id
}

output "public_ssh_security_group_id" {
  description = "Public SSH Security Group ID"
  value       = aws_security_group.public_ssh_security_group.id
}

output "public_web_security_group_id" {
  description = "Public Web Security Group ID"
  value       = aws_security_group.public_web_security_group.id
}

output "redshift_security_group_id" {
  description = "Redshift Security Group ID"
  value       = aws_security_group.redshift_security_group.id
}

output "vpc_endpoint_security_group_id" {
  description = "VPC Endpoint Security Group ID"
  value       = aws_security_group.vpc_endpoint_security_group.id
}
