# aws-terraform-security\_group

*This module creates the standard security groups for use on an account.

*## Basic Usage

*```
*module "security_groups" {
 source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-security_group//?ref=v0.0.1"

 resource_name = "Test-SG"
 vpc_id        = "${module.vpc.vpc_id}"
 environment   = "Production"
*}
*
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) |
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Application environment for which this network is being created. Preferred values are Development, Integration, PreProduction, Production, QA, Staging, or Test | `string` | `"Development"` | no |
| resource\_name | The name to be used for resources provisioned by this module | `string` | n/a | yes |
| vpc\_id | Provide Virtual Private Cloud ID in which security groups will be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| efs\_security\_group\_id | EFS Security Group ID |
| eks\_control\_plane\_security\_group\_id | EKS Control Plane Security Group ID |
| eks\_worker\_security\_group\_id | EKS Worker Security Group ID |
| elastic\_cache\_memcache\_security\_group\_id | ElasticCache Memcache Security Group ID |
| elastic\_cache\_redis\_security\_group\_id | ElasticCache Redis Security Group ID |
| mssql\_security\_group\_id | MS SQL DB Security Group ID |
| mysql\_security\_group\_id | MySQL DB Security Group ID |
| nfs\_security\_group\_id | NFS Security Group ID |
| oracle\_security\_group\_id | Oracle DB Security Group ID |
| postgres\_security\_group\_id | Postgres DB Security Group ID |
| private\_ecs\_security\_group\_id | Private ECS Security Group ID |
| private\_rdp\_security\_group\_id | Private RDP Security Group ID |
| private\_ssh\_security\_group\_id | Private SSH Security Group ID |
| private\_web\_security\_group\_id | Private Web Security Group ID |
| public\_rdp\_security\_group\_id | Public RDP Security Group ID |
| public\_ssh\_security\_group\_id | Public SSH Security Group ID |
| public\_web\_security\_group\_id | Public Web Security Group ID |
| redshift\_security\_group\_id | Redshift Security Group ID |
| vpc\_endpoint\_security\_group\_id | VPC Endpoint Security Group ID |
