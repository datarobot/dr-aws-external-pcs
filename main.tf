#############################################
# Redis Elasticache 
#############################################

module "redis" {
  source       = "./redis-elasticache-module/"
  vpc_id       = local.vpc
  vpcname      = local.vpcname
  vpc_cidr     = local.vpc_cidr
  project_name = local.project_name
  subnet_ids   = local.subnet_ids
  node_type    = local.node_type
  tags         = local.common_tags
}

###############################################
# Mongo Atlas
###############################################

module "mongo_atlas" {
  source                         = "./mongo-atlas-module"
  env                            = local.env
  atlas_public_key               = data.aws_secretsmanager_secret_version.atlas_public_key.secret_string
  atlas_private_key              = data.aws_secretsmanager_secret_version.atlas_private_key.secret_string
  atlas_project_name             = local.atlas_project_name
  atlas_org_id                   = local.atlas_org_id
  vpc_id                         = local.vpc_id
  subnet_groups                  = local.subnet_ids
  cidr_block                     = local.vpc_cidr
  pl_sg_cidr_range               = [local.vpc_cidr]
  security_group_id_list         = [""]
  atlas_region                   = local.atlas_region
  atlas_disk_size                = local.atlas_disk_size
  atlas_instance_type            = local.atlas_instance_type
  atlas_mongodb_version          = local.atlas_mongodb_version
  atlas_cluster_type             = local.atlas_cluster_type
  atlas_num_shards               = local.atlas_num_shards
  pit_enabled                    = local.pit_enabled
  copy_protection_enabled        = local.copy_protection_enabled
  termination_protection_enabled = local.termination_protection_enabled
  atlas_dbuser                   = local.atlas_dbuser
  names                          = local.names
  length                         = 15
  special                        = false
  override_special               = "!#$&*()-_=+[]{}<>:?"
  min_lower                      = 1
  min_upper                      = 1
  min_numeric                    = 1
  min_special                    = 1
  path                           = local.secrets_manager_path
  tags                           = local.common_tags
  extended_storage_size          = local.extended_storage_size
}

#################################################
# Postgres RDS
#################################################

module "postgres_rds" {
  source                    = "./postgres-rds-module/"
  project_name              = local.project_name
  production                = local.is_production
  vpc_id                    = local.vpc
  vpcname                   = local.vpcname
  vpc_cidr                  = local.vpc_cidr
  database_subnets          = local.subnet_ids
  allocated_rds_storage     = local.allocated_rds_storage
  max_allocated_rds_storage = local.max_allocated_rds_storage
  parameter_group_name      = local.parameter_group_name
  tags                      = local.common_tags
  rds_dns_name              = "postgres-${local.project_name}.${local.HostZoneDNS}"
  zone_id                   = local.zone_id
  postgres_engine_version   = local.postgres_engine_version
  instance_type             = local.instance_type
}
