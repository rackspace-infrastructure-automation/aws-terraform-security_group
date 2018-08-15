/**
 * # aws-terraform-security_group
 *
 *This module creates the standard security groups for use on an account.
 *
 *## Basic Usage
 *
 *```
 *module "security_groups" {
 *  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-security_group//?ref=v0.0.1"
 *
 *  resource_name = "Test-SG"
 *  vpc_id        = "${module.vpc.vpc_id}"
 *  environment   = "Production"
 *}
 *```
 */

locals {
  tags = {
    Environment     = "${var.environment}"
    ServiceProvider = "Rackspace"
  }
}

data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}

resource "aws_security_group" "public_rdp_security_group" {
  name        = "${var.resource_name}-PublicRDPSecurityGroup"
  description = "Allow rdp traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-PublicRDPSecurityGroup"))}"
}

resource "aws_security_group" "public_ssh_security_group" {
  name        = "${var.resource_name}-PublicSSHSecurityGroup"
  description = "Allow ssh traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-PublicSSHSecurityGroup"))}"
}

resource "aws_security_group" "private_ssh_security_group" {
  name        = "${var.resource_name}-PrivateSSHSecurityGroup"
  description = "Allow ssh traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.public_ssh_security_group.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-PrivateSSHSecurityGroup"))}"
}

resource "aws_security_group" "nfs_security_group" {
  name        = "${var.resource_name}-NFSSecurityGroup"
  description = "Allow NFS traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 111
    to_port     = 111
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  }

  ingress {
    from_port   = 111
    to_port     = 111
    protocol    = "udp"
    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  }

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  }

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "udp"
    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-NFSSecurityGroup"))}"
}

resource "aws_security_group" "mssql_security_group" {
  name        = "${var.resource_name}-MSSQLSecurityGroup"
  description = "Allow MSSQL traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-MSSQLSecurityGroup"))}"
}

resource "aws_security_group" "mysql_security_group" {
  name        = "${var.resource_name}-MYSQLSecurityGroup"
  description = "Allow MYSQL traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-MYSQLSecurityGroup"))}"
}

resource "aws_security_group" "public_web_security_group" {
  name        = "${var.resource_name}-PublicWebSecurityGroup"
  description = "Allow public WEB traffic to the load balancer"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-PublicWebSecurityGroup"))}"
}

resource "aws_security_group" "private_web_security_group" {
  name        = "${var.resource_name}-PrivateWebSecurityGroup"
  description = "Allow private WEB traffic to the load balancer"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.public_web_security_group.id}"]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = ["${aws_security_group.public_web_security_group.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-PrivateWebSecurityGroup"))}"
}

resource "aws_security_group" "private_ecs_security_group" {
  name        = "${var.resource_name}-PrivateECSSecurityGroup"
  description = "Allow public WEB traffic to ephemeral ports on ECS cluster."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = 32768
    to_port         = 61000
    protocol        = "tcp"
    security_groups = ["${aws_security_group.public_web_security_group.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-PrivateECSSecurityGroup"))}"
}

resource "aws_security_group" "efs_security_group" {
  name        = "${var.resource_name}-EFSSecurityGroup"
  description = "Allow EFS traffic."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-EFSSecurityGroup"))}"
}

resource "aws_security_group" "oracle_security_group" {
  name        = "${var.resource_name}-OracleSecurityGroup"
  description = "Allow Oracle DB traffic."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 1521
    to_port     = 1521
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-OracleSecurityGroup"))}"
}

resource "aws_security_group" "postgres_security_group" {
  name        = "${var.resource_name}-PostgresSecurityGroup"
  description = "Allow Postgres DB traffic."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-PostgresSecurityGroup"))}"
}

resource "aws_security_group" "elastic_cache_memcache_security_group" {
  name        = "${var.resource_name}-ElasticCacheMemcacheSecurityGroup"
  description = "Allow ElasticCache Memcache traffic."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-ElasticCacheMemcacheSecurityGroup"))}"
}

resource "aws_security_group" "redshift_security_group" {
  name        = "${var.resource_name}-RedshiftSecurityGroup"
  description = "Allow Redshift traffic."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-RedshiftSecurityGroup"))}"
}

resource "aws_security_group" "elastic_cache_redis_security_group" {
  name        = "${var.resource_name}-ElasticCacheRedisSecurityGroup"
  description = "Allow ElasticCache Redis traffic."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-ElasticCacheRedisSecurityGroup"))}"
}

resource "aws_security_group" "private_rdp_security_group" {
  name        = "${var.resource_name}-PrivateRDPSecurityGroup"
  description = "Allow private RDP traffic from load balancer."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = 3389
    to_port         = 3389
    protocol        = "tcp"
    security_groups = ["${aws_security_group.public_rdp_security_group.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${var.resource_name}-PrivateRDPSecurityGroup"))}"
}
