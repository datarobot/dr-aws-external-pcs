resource "aws_elasticache_subnet_group" "datarobot" {
  name        = "${var.project_name}-redis"
  description = "redis subnet for ${var.project_name}"
  subnet_ids  = var.subnet_ids
}


resource "random_password" "password_ecs" {
  count            = 1
  length           = 20
  special          = false
  override_special = "_"
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "aws_secretsmanager_secret" "redis_password" {
  name                    = "${var.project_name}-redis-password"
  recovery_window_in_days = 0
  tags                    = var.tags
}

resource "aws_secretsmanager_secret_version" "redis_password" {
  secret_id     = aws_secretsmanager_secret.redis_password.id
  secret_string = random_password.password_ecs[0].result
}

resource "aws_elasticache_replication_group" "datarobot" {
  description                = "redis for ${var.project_name}"
  auth_token                 = random_password.password_ecs[0].result
  automatic_failover_enabled = true
  replication_group_id       = var.project_name
  node_type                  = var.node_type
  parameter_group_name       = var.parameter_group_name
  port                       = 6379
  multi_az_enabled           = true
  subnet_group_name          = aws_elasticache_subnet_group.datarobot.name
  security_group_ids         = [aws_security_group.elasticache_redis_group.id]
  replicas_per_node_group    = var.replicas_per_node_group
  num_node_groups            = var.num_node_groups
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  engine                     = "redis"
  engine_version             = "7.0"
  apply_immediately          = true
}

# resource "aws_elasticache_cluster" "datarobot" {
#   cluster_id           = "${var.project_name}-redis"
#   replication_group_id = aws_elasticache_replication_group.datarobot.id
#   tags                 = var.tags
# }


# Security Group for Private Subnets (ElasticCache)
resource "aws_security_group" "elasticache_redis_group" {
  name        = join("-", [var.vpcname, "elasticache_redis_group"])
  description = "Security Group for AWS elasticache"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 6379
    to_port     = 6379
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
