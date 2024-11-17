resource "aws_db_subnet_group" "database_subnets" {
  name       = "${var.project_name}-postgres-rds-db"
  subnet_ids = var.database_subnets.*.id
  tags = var.tags
}

module "rds_postgres" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.9.0"

  identifier                      = var.project_name
  create_db_instance              = true
  create_db_option_group          = false
  create_db_subnet_group          = false
  create_db_parameter_group       = false
  create_monitoring_role          = false
  parameter_group_name            = var.parameter_group_name
  ca_cert_identifier              = "rds-ca-rsa2048-g1"
  db_subnet_group_name            = aws_db_subnet_group.database_subnets.name
  engine                          = "postgres"
  engine_version                  = var.postgres_engine_version
  family                          = "postgres13"
  major_engine_version            = var.postgres_engine_version
  allow_major_version_upgrade     = true
  instance_class                  = var.instance_type
  allocated_storage               = var.allocated_rds_storage
  max_allocated_storage           = var.max_allocated_rds_storage
  storage_encrypted               = true
  multi_az                        = true
  username                        = "postgres"
  db_name                         = "postgres"
  password                        = random_password.postgres.result
  port                            = "5432"
  subnet_ids                      = [var.database_subnets[0].id, var.database_subnets[1].id]
  publicly_accessible             = false
  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  backup_retention_period         = 7
  apply_immediately               = true
  deletion_protection             = var.production
  options                         = []
  tags                            = var.tags
  vpc_security_group_ids          = [aws_security_group.rds_database_group.id]
  create_random_password          = false
}

resource "random_password" "postgres" {
  length           = 20
  special          = false
  override_special = "_"
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "aws_secretsmanager_secret" "postgres_password" {
  name                    = "${var.project_name}-postgres-password"
  recovery_window_in_days = 0
  tags                    = var.tags
}

resource "aws_secretsmanager_secret_version" "postgres_password" {
  secret_id     = aws_secretsmanager_secret.postgres_password.id
  secret_string = random_password.postgres.result
}

# Security Group for Private Subnets
resource "aws_security_group" "rds_database_group" {
  name        = join("-", [var.vpcname, "-", var.project_name, "-rds-sec-group"])
  description = "Security Group for AWS RDS"
  vpc_id      = var.vpc.id

  ingress {
    description = "allow psql"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "ALLOW All Egress Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = var.tags
}

resource "aws_route53_record" "rds_database" {
  zone_id = var.zone_id
  name    = var.rds_dns_name
  type    = "CNAME"
  ttl     = "300"
  records = [module.rds_postgres.db_instance_address]
}
