# public and private api key to authenticate and create resources in atlas
provider "mongodbatlas" {
  public_key  = var.atlas_public_key
  private_key = var.atlas_private_key
}

# Mongo atlas project to be created in Datarobot org - org id does not change
resource "mongodbatlas_project" "aws_mongo_atlas_project" {
  name   = "${var.atlas_project_name}-${var.env}"
  org_id = var.atlas_org_id
  is_extended_storage_sizes_enabled = var.extended_storage_size
}

# Mongo atlas cluster to be created
resource "mongodbatlas_advanced_cluster" "aws_mongo_atlas_cluster" {
  project_id                     = mongodbatlas_project.aws_mongo_atlas_project.id
  name                           = "${var.atlas_project_name}-${var.env}"
  cluster_type                   = var.atlas_cluster_type
  pit_enabled                    = var.pit_enabled
  termination_protection_enabled = var.termination_protection_enabled
  version_release_system         = "LTS"
  backup_enabled                 = true
  replication_specs {
    num_shards        = var.atlas_num_shards
    region_configs {
      provider_name   = "AWS"
      region_name     = upper(replace(var.atlas_region, "-", "_"))
      priority        = 7
    electable_specs {
      instance_size = var.atlas_instance_type
      node_count    = 3
    }
  auto_scaling { 
     disk_gb_enabled   = true
  }
   analytics_specs {
     instance_size = var.analytics_node_instance_type
     ebs_volume_type = "STANDARD"
     node_count      = 1
     disk_size_gb    = var.atlas_disk_size
  }
}
}
  advanced_configuration {
    javascript_enabled           = false
    minimum_enabled_tls_protocol = "TLS1_2"
  }
  mongo_db_major_version         = var.atlas_mongodb_version
  disk_size_gb                   = var.atlas_disk_size
  lifecycle {
    ignore_changes = [disk_size_gb]
  }
}

# Backup schedule for mongo atlas cluster
resource "mongodbatlas_cloud_backup_schedule" "aws_mongo_atlas_automated_cloud_backup" {
  project_id   = mongodbatlas_project.aws_mongo_atlas_project.id
  cluster_name = var.monolith_saas ? mongodbatlas_advanced_cluster.aws_mongo_atlas_cluster[0].name : mongodbatlas_cluster.aws_mongo_atlas_cluster[0].name

  policy_item_hourly {
    frequency_interval = 6 #accepted values = 1, 2, 4, 6, 8, 12 -> every n hours
    retention_unit     = "days"
    retention_value    = 7
  }
  policy_item_daily {
    frequency_interval = 1 #accepted values = 1 -> every 1 day
    retention_unit     = "days"
    retention_value    = 30
  }
  policy_item_weekly {
    frequency_interval = 6 # accepted values = 1 to 7 -> every 1=Monday,2=Tuesday,3=Wednesday,4=Thursday,5=Friday,6=Saturday,7=Sunday day of the week
    retention_unit     = "days"
    retention_value    = 30
  }
  policy_item_monthly {
    frequency_interval = 1 # accepted values = 1 to 28 -> 1 to 28 every nth day of the month  
    # accepted values = 40 -> every last day of the month
    retention_unit  = "months"
    retention_value = 1
  }
  copy_settings {
    cloud_provider = "AWS"
    frequencies = ["HOURLY",
      "DAILY",
      "WEEKLY",
      "MONTHLY",
    "ON_DEMAND"]
    region_name         = "US_WEST_2"
    replication_spec_id = var.monolith_saas ? mongodbatlas_advanced_cluster.aws_mongo_atlas_cluster[0].replication_specs.*.id[0] : mongodbatlas_cluster.aws_mongo_atlas_cluster[0].replication_specs.*.id[0]
    should_copy_oplogs  = true
  }
}


resource "mongodbatlas_database_user" "aws_mongo_atlas_db_user" {
  for_each           = { for user in var.names : user.username => user }
  username           = each.value.username
  password           = random_password.aws_atlas_mongo_password_generator[each.key].result
  auth_database_name = "admin"
  project_id         = mongodbatlas_project.aws_mongo_atlas_project.id

  dynamic "roles" {
    for_each = each.value.roles

    content {
      role_name     = roles.value.role_name
      database_name = roles.value.database_name
    }

  }
  dynamic "scopes" {
    for_each = each.value.scopes

    content {
      name = scopes.value.name
      type = scopes.value.type
    }
  }
}

# CIDR whitelist added to network access in atlas that allows access only from the vpc cidr block
resource "mongodbatlas_project_ip_access_list" "cidr_whitelist" {
  project_id = mongodbatlas_project.aws_mongo_atlas_project.id
  cidr_block = var.cidr_block
  comment    = "cidr block for AWS VPC"
}

# Private link endpoint created in atlas
resource "mongodbatlas_privatelink_endpoint" "atlas_privatelink_endpoint" {
  project_id    = mongodbatlas_project.aws_mongo_atlas_project.id
  provider_name = "AWS"
  region        = upper(replace(var.atlas_region, "-", "_"))
}

# Mongo atlas with aws interface link created 
resource "aws_vpc_endpoint" "aws_atlas_endpoint_interface_link" {
  vpc_id             = var.vpc_id
  service_name       = mongodbatlas_privatelink_endpoint.atlas_privatelink_endpoint.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.subnet_groups
  security_group_ids = concat([aws_security_group.mongo_atlas_privatelink.id], var.security_group_id_list)
}

# AWS Private link service created for atlas privatelink endpoint
resource "mongodbatlas_privatelink_endpoint_service" "aws_atlas_privatelink_endpoint_service" {
  project_id          = mongodbatlas_privatelink_endpoint.atlas_privatelink_endpoint.project_id
  endpoint_service_id = aws_vpc_endpoint.aws_atlas_endpoint_interface_link.id
  private_link_id     = mongodbatlas_privatelink_endpoint.atlas_privatelink_endpoint.id
  provider_name       = "AWS"
}

# Security group attached to privatelink in aws to allow access to atlas cluster
# Only allows acess from the vpc where the privatelink is created
resource "aws_security_group" "mongo_atlas_privatelink" {
  name        = "mongo-atlas-privatelink-${var.env}-${var.atlas_project_name}-sg"
  description = "Security group to allow access from mongo atlas private link"
  vpc_id      = var.vpc_id
  tags        = var.tags
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "mongo_atlas_pl_https_access" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.pl_sg_cidr_range
  description       = "Security group rule for mongo atlas pl https access"
  security_group_id = aws_security_group.mongo_atlas_privatelink.id
}

resource "aws_security_group_rule" "mongo_atlas_pl_db_port_access" {
  type              = "ingress"
  from_port         = 1000
  to_port           = 1800
  protocol          = "tcp"
  cidr_blocks       = var.pl_sg_cidr_range
  description       = "Security group rule for atlas db ports access"
  security_group_id = aws_security_group.mongo_atlas_privatelink.id
}

resource "aws_security_group_rule" "mongo_atlas_pl_egress_access" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Security group rule for privatelink egress access"
  security_group_id = aws_security_group.mongo_atlas_privatelink.id
}

# Random password generator for atlas db user
resource "random_password" "aws_atlas_mongo_password_generator" {
  for_each         = { for user in var.names : user.username => user }
  length           = var.length
  special          = var.special
  override_special = var.override_special
  min_lower        = var.min_lower
  min_upper        = var.min_upper
  min_numeric      = var.min_numeric
  min_special      = var.min_special
}

resource "aws_secretsmanager_secret" "mongo_atlas_user_password" {
  for_each = { for user in var.names : user.username => user }
  name     = "${var.path}/${each.value.username}"
  tags     = var.tags
}

resource "aws_secretsmanager_secret_version" "mongo_atlas_user_password" {
  for_each  = { for user in var.names : user.username => user }
  secret_id = aws_secretsmanager_secret.mongo_atlas_user_password[each.key].id
  secret_string = jsonencode({
    "password" : random_password.aws_atlas_mongo_password_generator[each.key].result
  })
}
