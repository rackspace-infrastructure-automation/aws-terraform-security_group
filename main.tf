/*
 * # aws-terraform-security_group
 *
 * This module creates the standard security groups for use on an account.
 *
 * ## Basic Usage
 *
 * ```HCL
 * module "security_groups" {
 *   source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-security_group//?ref=v0.12.1"
 *
 *   name = "Test-SG"
 *   tags   = {
 *     App = "Test"
 *   }
 *   vpc_id        = "${module.vpc.vpc_id}"
 *   environment   = "Production"
 * }
 * ```
 *
 * ## Terraform 0.12 upgrade
 *
 * Several changes were required while adding terraform 0.12 compatibility.  The following changes should be
 * made when upgrading from a previous release to version 0.12.0 or higher.
 *
 * ### Module variables
 *
 * The following module variables were updated to better meet current Rackspace style guides:
 *
 * - `resource_name` -> `name`
 */

terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 2.7.0"
  }
}

locals {
  tags = {
    Environment     = var.environment
    ServiceProvider = "Rackspace"
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_security_group" "public_rdp_security_group" {
  description = "Public RDP Security Group"
  name_prefix = "${var.name}-PublicRDPSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 3389
    protocol    = "tcp"
    to_port     = 3389
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-PublicRDPSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "public_ssh_security_group" {
  description = "Public SSH Security Group"
  name_prefix = "${var.name}-PublicSSHSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-PublicSSHSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "private_ssh_security_group" {
  description = "Private SSH Security Group"
  name_prefix = "${var.name}-PrivateSSHSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    from_port       = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_ssh_security_group.id]
    to_port         = 22
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-PrivateSSHSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "nfs_security_group" {
  description = "NFS Security Group"
  name_prefix = "${var.name}-NFSSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = 111
    protocol    = "tcp"
    to_port     = 111
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = 111
    protocol    = "udp"
    to_port     = 111
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = 2049
    protocol    = "tcp"
    to_port     = 2049
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = 2049
    protocol    = "udp"
    to_port     = 2049
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-NFSSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "mssql_security_group" {
  description = "MSSQL Security Group"
  name_prefix = "${var.name}-MSSQLSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = 1433
    protocol    = "tcp"
    to_port     = 1433
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-MSSQLSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "mysql_security_group" {
  description = "MySQL Security Group"
  name_prefix = "${var.name}-MYSQLSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = 3306
    protocol    = "tcp"
    to_port     = 3306
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-MYSQLSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "public_web_security_group" {
  description = "Public Web Security Group"
  name_prefix = "${var.name}-PublicWebSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-PublicWebSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "private_web_security_group" {
  description = "Private Web Security Group"
  name_prefix = "${var.name}-PrivateWebSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    from_port       = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_web_security_group.id]
    to_port         = 80
  }

  ingress {
    from_port       = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.public_web_security_group.id]
    to_port         = 443
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-PrivateWebSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "private_ecs_security_group" {
  description = "Private ECS Security Group"
  name_prefix = "${var.name}-PrivateECSSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    from_port       = 32768
    protocol        = "tcp"
    security_groups = [aws_security_group.public_web_security_group.id]
    to_port         = 61000
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-PrivateECSSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "efs_security_group" {
  description = "EFS Security Group"
  name_prefix = "${var.name}-EFSSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = 2049
    protocol    = "tcp"
    to_port     = 2049
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-EFSSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "oracle_security_group" {
  description = "Oracle Security Group"
  name_prefix = "${var.name}-OracleSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = 1521
    protocol    = "tcp"
    to_port     = 1521
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-OracleSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "postgres_security_group" {
  description = "PostgreSQL Security Group"
  name_prefix = "${var.name}-PostgresSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-PostgresSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "elastic_cache_memcache_security_group" {
  description = "ElastiCache Memcache Security Group"
  name_prefix = "${var.name}-ElasticCacheMemcacheSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = 11211
    protocol    = "tcp"
    to_port     = 11211
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-ElasticCacheMemcacheSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "redshift_security_group" {
  description = "Redshift Security Group"
  name_prefix = "${var.name}-RedshiftSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = 5439
    protocol    = "tcp"
    to_port     = 5439
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-RedshiftSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "elastic_cache_redis_security_group" {
  description = "ElastiCache Redis Security Group"
  name_prefix = "${var.name}-ElasticCacheRedisSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
    from_port   = 6379
    protocol    = "tcp"
    to_port     = 6379
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-ElasticCacheRedisSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "private_rdp_security_group" {
  description = "Private RDP Security Group"
  name_prefix = "${var.name}-PrivateRDPSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    from_port       = 3389
    protocol        = "tcp"
    security_groups = [aws_security_group.public_rdp_security_group.id]
    to_port         = 3389
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-PrivateRDPSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "vpc_endpoint_security_group" {
  description = "VPC Endpoint Security Group"
  name_prefix = "${var.name}-VpcEndpointSecurityGroup"
  vpc_id      = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-VpcEndpointSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "eks_control_plane_security_group" {
  description            = "EKS Control Plane Security Group"
  name_prefix            = "${var.name}-EksControlPlaneSecurityGroup"
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-EksControlPlaneSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "eks_control_plane_ingress" {
  description              = "Allow ingress HTTPS traffic from worker"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_control_plane_security_group.id
  source_security_group_id = aws_security_group.eks_worker_security_group.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks_control_plane_egress" {
  description              = "Allow all egress traffic to EKS worker nodes"
  from_port                = 0
  protocol                 = "all"
  security_group_id        = aws_security_group.eks_control_plane_security_group.id
  source_security_group_id = aws_security_group.eks_worker_security_group.id
  to_port                  = 65535
  type                     = "egress"

}

resource "aws_security_group" "eks_worker_security_group" {
  description            = "EKS Worker Security Group"
  name_prefix            = "${var.name}-EksWorkerSecurityGroup"
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all egress traffic"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    description     = "Allow ingress traffic from public web server security group"
    from_port       = 1025
    protocol        = "tcp"
    security_groups = [aws_security_group.public_web_security_group.id]
    to_port         = 65535
  }

  ingress {
    description     = "Allow ingress traffic from EKS control plane security group"
    from_port       = 1025
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_control_plane_security_group.id]
    to_port         = 65535
  }

  ingress {
    description = "Allow all ingress traffic from other members of this security group"
    from_port   = 0
    protocol    = "-1"
    self        = true
    to_port     = 0
  }

  tags = merge(
    var.tags,
    local.tags,
    {
      "Name" = "${var.name}-EksWorkerSecurityGroup"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}
