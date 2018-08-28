# aws-terraform-security_group

This module creates the standard security groups for use on an account.

## Basic Usage

```
module "security_groups" {
 source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-security_group//?ref=v0.0.1"

 resource_name = "Test-SG"
 vpc_id        = "${module.vpc.vpc_id}"
 environment   = "Production"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| environment | Application environment for which this network is being created. Preferred values are Development, Integration, PreProduction, Production, QA, Staging, or Test | string | `Development` | no |
| resource_name | The name to be used for resources provisioned by this module | string | - | yes |
| vpc_id | Provide Virtual Private Cloud ID in which security groups will be deployed | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| efs_security_group_id | EFS Security Group ID |
| eks_control_plane_security_group_id | EKS Control Plane Security Group ID |
| eks_worker_security_group_id | EKS Worker Security Group ID |
| elastic_cache_memcache_security_group_id | ElasticCache Memcache Security Group ID |
| elastic_cache_redis_security_group_id | ElasticCache Redis Security Group ID |
| mssql_security_group_id | MS SQL DB Security Group ID |
| mysql_security_group_id | MySQL DB Security Group ID |
| nfs_security_group_id | NFS Security Group ID |
| oracle_security_group_id | Oracle DB Security Group ID |
| postgres_security_group_id | Postgres DB Security Group ID |
| private_ecs_security_group_id | Private ECS Security Group ID |
| private_rdp_security_group_id | Private RDP Security Group ID |
| private_ssh_security_group_id | Private SSH Security Group ID |
| private_web_security_group_id | Private Web Security Group ID |
| public_rdp_security_group_id | Public RDP Security Group ID |
| public_ssh_security_group_id | Public SSH Security Group ID |
| public_web_security_group_id | Public Web Security Group ID |
| redshift_security_group_id | Redshift Security Group ID |
| vpc_endpoint_security_group_id | VPC Endpoint Security Group ID |

