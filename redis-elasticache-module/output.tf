output "primary_endpoint" {
  description = "Primary Endpoint"
  value       = aws_elasticache_replication_group.datarobot.primary_endpoint_address
}

output "reader_endpoint" {
  description = "Reader Endpoint"
  value       = aws_elasticache_replication_group.datarobot.reader_endpoint_address
}

output "redistoken" {
  description = "REDIS Token"
  value       = random_password.password_ecs[0].result
}
