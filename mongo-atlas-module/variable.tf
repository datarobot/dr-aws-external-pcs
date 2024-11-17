variable "env" {
  description = "Name of the environment"
}

variable "atlas_public_key" {
  description = "public key of atlas"
}

variable "atlas_org_id" {
  description = "your org id in atlas to create mongodb deployment for datarobot"
}

variable "atlas_private_key" {
  description = "private key of atlas"
}

variable "atlas_project_name" {
  description = "atlas project name"
  type        = string
}

variable "atlas_region" {
  description = "atlas region"
}

variable "atlas_disk_size" {
  description = "atlas disk size"
  default     = "20"
}

variable "atlas_instance_type" {
  description = "atlas instance type"
  type        = string
  default     = "M30"
}

variable "atlas_mongodb_version" {
  description = "major mongodb version"
  type        = string
}

variable "atlas_cluster_type" {
  description = "cluster type can be either replicaset or sharded"
  type        = string
}

variable "atlas_num_shards" {
  description = "number of shards needed for either replicaset or sharded cluster"
  type        = number
}

variable "atlas_dbuser" {
  description = "atlas datarobot user"
  type        = list(string)
}

variable "cidr_block" {
  description = "VPC CIDR"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "pl_sg_cidr_range" {
  description = "VPC ID"
  type        = list(string)
}

variable "tags" {
  description = "default tags"
  type        = map(string)
}

variable "subnet_groups" {
  description = "VPC CIDR"
  type        = list(string)
}

variable "path" {
  type        = string
  description = "Path to store password in Secrets Manager"
  default     = ""
}

variable "min_lower" {
  type        = number
  description = "Minimum number of lower case characters"
}

variable "min_upper" {
  type        = number
  description = "Minimum number of upper case characters"
}

variable "min_numeric" {
  type        = number
  description = "Minimum number of numeric characters"
}

variable "min_special" {
  type        = number
  description = "Minimum number of special characters"
}

variable "names" {
  type = list(object({
    username : string,
    roles : list(object({
      role_name : string,
      database_name : string,
    })),
    scopes : list(object({
      type : string,
      name : string
    }))
  }))
  description = "A list of database users to create for the project"
  default     = []
}

variable "length" {
  type        = number
  description = "The length of the password to be generated"
}

variable "special" {
  type        = bool
  description = "Include special characters in random password string"
}

variable "override_special" {
  type        = string
  description = "Provide your own list of special characters"
}

variable "security_group_id_list" {
  type        = list(string)
  description = "Additional sgs if needed to be attached"
}

variable "pit_enabled" {
  type        = bool
  description = "Enable Continuous Cloud Backup for point in time restore and RPO of 1 min"
}

variable "termination_protection_enabled" {
  type        = bool
  description = "Enable termination protection for accidental deletions"
}

variable "copy_protection_enabled" {
  type        = bool
  description = "Enable snapshot to be copied to additional regions if an entire region goes down"
}

variable "extended_storage_size" {
  type        = bool
  description = "Enable extended storage size beyond the default values"
}

variable "change_stream_options_pre_and_post_images_expire_after_seconds" {
  type        = number
  description = "Set this value to either -1 or 0"
  default     = 0
}

variable "javascript_enabled" {
  type        = bool
  description = "Enable javascript if needed"
  default     = false
}
