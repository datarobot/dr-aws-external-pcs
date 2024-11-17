## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >=3.2.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >=3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds_postgres"></a> [rds\_postgres](#module\_rds\_postgres) | terraform-aws-modules/rds/aws | 5.9.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.database_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_route53_record.rds_database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_secretsmanager_secret.postgres_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.postgres_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.rds_database_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_password.postgres](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_rds_storage"></a> [allocated\_rds\_storage](#input\_allocated\_rds\_storage) | Disk size to allocate to Postgres RDS | `string` | n/a | yes |
| <a name="input_database_subnets"></a> [database\_subnets](#input\_database\_subnets) | Database Subnet IDs | `any` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance Type to use | `string` | n/a | yes |
| <a name="input_max_allocated_rds_storage"></a> [max\_allocated\_rds\_storage](#input\_max\_allocated\_rds\_storage) | Max disk size to allocate to Postgres RDS | `number` | n/a | yes |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of RDS custom parameter group name | `string` | n/a | yes |
| <a name="input_postgres_engine_version"></a> [postgres\_engine\_version](#input\_postgres\_engine\_version) | Variable to set postgres major version to support individual customer upgrades | `string` | n/a | yes |
| <a name="input_production"></a> [production](#input\_production) | Set Production Grade Environment | `bool` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project / Company Name for the deployment | `string` | n/a | yes |
| <a name="input_rds_dns_name"></a> [rds\_dns\_name](#input\_rds\_dns\_name) | Name of RDS route 53 record to be created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to use on objects | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR for the VPC | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC object | `any` | n/a | yes |
| <a name="input_vpcname"></a> [vpcname](#input\_vpcname) | Name of the VPC | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | zone id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_get_current_version_of_db"></a> [get\_current\_version\_of\_db](#output\_get\_current\_version\_of\_db) | Postgres Current Version |
| <a name="output_postgres_password"></a> [postgres\_password](#output\_postgres\_password) | n/a |
| <a name="output_rds_dns"></a> [rds\_dns](#output\_rds\_dns) | Postgres DNS |
| <a name="output_rds_endpoint"></a> [rds\_endpoint](#output\_rds\_endpoint) | Postgres Endpoint |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.0 |
| <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) | ~> 1.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=5.0 |
| <a name="provider_mongodbatlas"></a> [mongodbatlas](#provider\_mongodbatlas) | ~> 1.11 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.mongo_atlas_user_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.mongo_atlas_user_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.mongo_atlas_privatelink](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.mongo_atlas_pl_db_port_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.mongo_atlas_pl_egress_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.mongo_atlas_pl_https_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_vpc_endpoint.aws_atlas_endpoint_interface_link](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [mongodbatlas_advanced_cluster.aws_mongo_atlas_cluster](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/advanced_cluster) | resource |
| [mongodbatlas_cloud_backup_schedule.aws_mongo_atlas_automated_cloud_backup](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/cloud_backup_schedule) | resource |
| [mongodbatlas_database_user.aws_mongo_atlas_db_user](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/database_user) | resource |
| [mongodbatlas_privatelink_endpoint.atlas_privatelink_endpoint](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/privatelink_endpoint) | resource |
| [mongodbatlas_privatelink_endpoint_service.aws_atlas_privatelink_endpoint_service](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/privatelink_endpoint_service) | resource |
| [mongodbatlas_project.aws_mongo_atlas_project](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project) | resource |
| [mongodbatlas_project_ip_access_list.cidr_whitelist](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project_ip_access_list) | resource |
| [random_password.aws_atlas_mongo_password_generator](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_atlas_cluster_type"></a> [atlas\_cluster\_type](#input\_atlas\_cluster\_type) | cluster type can be either replicaset or sharded | `string` | n/a | yes |
| <a name="input_atlas_dbuser"></a> [atlas\_dbuser](#input\_atlas\_dbuser) | atlas datarobot user | `list(string)` | n/a | yes |
| <a name="input_atlas_disk_size"></a> [atlas\_disk\_size](#input\_atlas\_disk\_size) | atlas disk size | `string` | `"20"` | no |
| <a name="input_atlas_instance_type"></a> [atlas\_instance\_type](#input\_atlas\_instance\_type) | atlas instance type | `string` | `"M30"` | no |
| <a name="input_atlas_mongodb_version"></a> [atlas\_mongodb\_version](#input\_atlas\_mongodb\_version) | major mongodb version | `string` | n/a | yes |
| <a name="input_atlas_num_shards"></a> [atlas\_num\_shards](#input\_atlas\_num\_shards) | number of shards needed for either replicaset or sharded cluster | `number` | n/a | yes |
| <a name="input_atlas_org_id"></a> [atlas\_org\_id](#input\_atlas\_org\_id) | your org id in atlas to create mongodb deployment for datarobot | `any` | n/a | yes |
| <a name="input_atlas_private_key"></a> [atlas\_private\_key](#input\_atlas\_private\_key) | private key of atlas | `any` | n/a | yes |
| <a name="input_atlas_project_name"></a> [atlas\_project\_name](#input\_atlas\_project\_name) | atlas project name | `string` | n/a | yes |
| <a name="input_atlas_public_key"></a> [atlas\_public\_key](#input\_atlas\_public\_key) | public key of atlas | `any` | n/a | yes |
| <a name="input_atlas_region"></a> [atlas\_region](#input\_atlas\_region) | atlas region | `any` | n/a | yes |
| <a name="input_change_stream_options_pre_and_post_images_expire_after_seconds"></a> [change\_stream\_options\_pre\_and\_post\_images\_expire\_after\_seconds](#input\_change\_stream\_options\_pre\_and\_post\_images\_expire\_after\_seconds) | Set this value to either -1 or 0 | `number` | `0` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | VPC CIDR | `string` | n/a | yes |
| <a name="input_copy_protection_enabled"></a> [copy\_protection\_enabled](#input\_copy\_protection\_enabled) | Enable snapshot to be copied to additional regions if an entire region goes down | `bool` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Name of the environment | `any` | n/a | yes |
| <a name="input_extended_storage_size"></a> [extended\_storage\_size](#input\_extended\_storage\_size) | Enable extended storage size beyond the default values | `bool` | n/a | yes |
| <a name="input_javascript_enabled"></a> [javascript\_enabled](#input\_javascript\_enabled) | Enable javascript if needed | `bool` | `false` | no |
| <a name="input_length"></a> [length](#input\_length) | The length of the password to be generated | `number` | n/a | yes |
| <a name="input_min_lower"></a> [min\_lower](#input\_min\_lower) | Minimum number of lower case characters | `number` | n/a | yes |
| <a name="input_min_numeric"></a> [min\_numeric](#input\_min\_numeric) | Minimum number of numeric characters | `number` | n/a | yes |
| <a name="input_min_special"></a> [min\_special](#input\_min\_special) | Minimum number of special characters | `number` | n/a | yes |
| <a name="input_min_upper"></a> [min\_upper](#input\_min\_upper) | Minimum number of upper case characters | `number` | n/a | yes |
| <a name="input_names"></a> [names](#input\_names) | A list of database users to create for the project | <pre>list(object({<br>    username : string,<br>    roles : list(object({<br>      role_name : string,<br>      database_name : string,<br>    })),<br>    scopes : list(object({<br>      type : string,<br>      name : string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_override_special"></a> [override\_special](#input\_override\_special) | Provide your own list of special characters | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path to store password in Secrets Manager | `string` | `""` | no |
| <a name="input_pit_enabled"></a> [pit\_enabled](#input\_pit\_enabled) | Enable Continuous Cloud Backup for point in time restore and RPO of 1 min | `bool` | n/a | yes |
| <a name="input_pl_sg_cidr_range"></a> [pl\_sg\_cidr\_range](#input\_pl\_sg\_cidr\_range) | VPC ID | `list(string)` | n/a | yes |
| <a name="input_security_group_id_list"></a> [security\_group\_id\_list](#input\_security\_group\_id\_list) | Additional sgs if needed to be attached | `list(string)` | n/a | yes |
| <a name="input_special"></a> [special](#input\_special) | Include special characters in random password string | `bool` | n/a | yes |
| <a name="input_subnet_groups"></a> [subnet\_groups](#input\_subnet\_groups) | VPC CIDR | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | default tags | `map(string)` | n/a | yes |
| <a name="input_termination_protection_enabled"></a> [termination\_protection\_enabled](#input\_termination\_protection\_enabled) | Enable termination protection for accidental deletions | `bool` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_atlasclusterstring"></a> [atlasclusterstring](#output\_atlasclusterstring) | n/a |
| <a name="output_mongo_atlas_cluster_name"></a> [mongo\_atlas\_cluster\_name](#output\_mongo\_atlas\_cluster\_name) | n/a |
| <a name="output_mongo_atlas_project_id"></a> [mongo\_atlas\_project\_id](#output\_mongo\_atlas\_project\_id) | n/a |
| <a name="output_names"></a> [names](#output\_names) | Returns list of secret names to be created. |
| <a name="output_plstring"></a> [plstring](#output\_plstring) | Private link connection string in srv format |
| <a name="output_secret_arns"></a> [secret\_arns](#output\_secret\_arns) | The ARN values of the generated secrets |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | Returns all secrets generated by the secrets manager module |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=5.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >=3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_replication_group.datarobot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.datarobot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_secretsmanager_secret.redis_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.redis_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.elasticache_redis_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_password.password_ecs](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | Node Size | `string` | n/a | yes |
| <a name="input_num_node_groups"></a> [num\_node\_groups](#input\_num\_node\_groups) | Number of Node Groups | `number` | `1` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Parameter Group Size | `string` | `"default.redis7"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The customer name | `string` | n/a | yes |
| <a name="input_replicas_per_node_group"></a> [replicas\_per\_node\_group](#input\_replicas\_per\_node\_group) | Number of Replicas | `number` | `2` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet IDs | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for Objects | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR for the VPC | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC object | `any` | n/a | yes |
| <a name="input_vpcname"></a> [vpcname](#input\_vpcname) | Name of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_endpoint"></a> [primary\_endpoint](#output\_primary\_endpoint) | Primary Endpoint |
| <a name="output_reader_endpoint"></a> [reader\_endpoint](#output\_reader\_endpoint) | Reader Endpoint |
| <a name="output_redistoken"></a> [redistoken](#output\_redistoken) | REDIS Token |
