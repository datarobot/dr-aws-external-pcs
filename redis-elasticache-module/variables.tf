variable "project_name" {
  description = "The customer name"
  type        = string
}

variable "parameter_group_name" {
  description = "Parameter Group Size"
  default     = "default.redis7"
  type        = string
}

variable "node_type" {
  description = "Node Size"
  type        = string
}

# Tags for Objects
variable "tags" {
  description = "Tags for Objects"
  type        = any
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = any
}

variable "replicas_per_node_group" {
  description = "Number of Replicas"
  default     = 2
  type        = number
}

variable "num_node_groups" {
  description = "Number of Node Groups"
  default     = 1
  type        = number
}

variable "vpc_id" {
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
