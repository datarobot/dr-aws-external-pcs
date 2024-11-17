output "atlasclusterstring" {
  value = mongodbatlas_advanced_cluster.aws_mongo_atlas_cluster[0].connection_strings
}

# Private link connection string in srv format
output "plstring" {
  value = mongodbatlas_advanced_cluster.aws_mongo_atlas_cluster[0].connection_strings[0].private_srv
}

output "secret_arns" {
  value       = [for names in aws_secretsmanager_secret_version.mongo_atlas_user_password : names.arn]
  description = "The ARN values of the generated secrets"
}

output "secrets" {
  sensitive   = true
  value       = { for key, secret_version in aws_secretsmanager_secret_version.mongo_atlas_user_password : key => secret_version.secret_string }
  description = "Returns all secrets generated by the secrets manager module"
}

output "names" {
  value       = var.names
  description = "Returns list of secret names to be created."
}

output "mongo_atlas_project_id" {
  value = mongodbatlas_project.aws_mongo_atlas_project.id
}

output "mongo_atlas_cluster_name" {
  value = var.monolith_saas ? mongodbatlas_advanced_cluster.aws_mongo_atlas_cluster[0].name : mongodbatlas_cluster.aws_mongo_atlas_cluster[0].name
}
