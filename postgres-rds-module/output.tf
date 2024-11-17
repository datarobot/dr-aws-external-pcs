output "postgres_password" {
  value = random_password.postgres.result
}

output "get_current_version_of_db" {
  description = "Postgres Current Version"
  value       = module.rds_postgres.db_instance_engine_version_actual
}

output "rds_dns" {
  description = "Postgres DNS"
  value       = aws_route53_record.rds_database.name
}


output "rds_endpoint" {
  description = "Postgres Endpoint"
  value       = module.rds_postgres.db_instance_endpoint
}
