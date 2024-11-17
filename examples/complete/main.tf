# Provider config

provider "aws" {
  region = "us-east-1"
}

# Local variables to be updated by customer according to their cloud env setup

locals {

  # AWS Account, VPC, Subnet and HostedZone configuration values
  aws_region     = data.aws_region.current.name
  aws_account_id = data.aws_caller_identity.current.account_id
  vpc            = "vpc-047f6f00000000789"
  vpc_id         = "vpc-047f6f00000000789"
  vpcname        = "test-vpc-name"
  vpc_cidr       = "10.0.0.0/16"
  subnet_ids     = ["subnet-093200000000000", "subnet-0ded00000000000", "subnet-0ca400000000000"]
  HostZoneDNS    = "aws.test.org.com"
  zone_id        = "Z03874402B000000000"


  # Local values for Mongo Atlas
  secrets_manager_path           = "/path/to/datarobot-mongo/user/mongo_atlas"
  atlas_project_name             = "external-datarobot-mongo"
  atlas_region                   = upper(replace(data.aws_region.current.name, "-", "_"))
  atlas_instance_type            = "M30"
  atlas_disk_size                = "50"
  atlas_mongodb_version          = "6.0"
  atlas_cluster_type             = "REPLICASET"
  atlas_num_shards               = 1
  atlas_org_id                   = "6247263f00000abcdefgh0000c"
  pit_enabled                    = true
  copy_protection_enabled        = false
  termination_protection_enabled = true
  extended_storage_size          = true
  atlas_dbuser                   = ["pcs-mongodb"]
  names = [
    {
      username = "pcs-mongodb",
      roles = [
        {
          database_name = "admin"
          role_name     = "readWrite"
        },
        {
          database_name = "admin"
          role_name     = "atlasAdmin"
        },
      ],
      scopes = []
    }
  ]


  # Local values for Postgres RDS and Redis Elasticache
  project_name              = "external-datarobot"
  allocated_rds_storage     = 50
  parameter_group_name      = "external-datarobot"
  postgres_engine_version   = 13
  max_allocated_rds_storage = 200
  instance_type             = "db.m6g.large" # Instance type for Postgres RDS
  node_type                 = "db.m6g.large" # Instance type for Redis Elasticache
  is_production             = false

  # Tags for resource and cost tracking
  common_tags = {
    customer    = "datarobot"
    user        = "datarobot"
    cost-center = "org-cost-center"
    cluster_id  = "datarobot-k8s-cluster-association"
    environment = "development"
    expiration  = "never"
  }
}
