variable "project_name" {
  description = "Project / Company Name for the deployment"
  type        = string
}

variable "database_subnets" {
  description = "Database Subnet IDs"
  type        = any
}

variable "tags" {
  description = "Tags to use on objects"
  type        = any
}

variable "instance_type" {
  description = "Instance Type to use"
  type        = string
}

variable "vpc" {
  description = "VPC object"
  type        = any
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
}

variable "vpcname" {
  description = "Name of the VPC"
  type        = string
}

variable "production" {
  type        = bool
  description = "Set Production Grade Environment"
}

variable "zone_id" {
  type        = string
  description = "zone id"
}

variable "rds_dns_name" {
  type        = string
  description = "Name of RDS route 53 record to be created"
}

variable "parameter_group_name" {
  type        = string
  description = "Name of RDS custom parameter group name"
}

variable "allocated_rds_storage" {
  description = "Disk size to allocate to Postgres RDS"
  type        = string
}

variable "max_allocated_rds_storage" {
  description = "Max disk size to allocate to Postgres RDS"
  type        = number
}

variable "postgres_engine_version" {
  type        = string
  description = "Variable to set postgres major version to support individual customer upgrades"
}
