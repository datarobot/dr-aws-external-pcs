data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_secretsmanager_secret_version" "atlas_public_key" {
  secret_id = "mongo_atlas_public_key"
}

data "aws_secretsmanager_secret_version" "atlas_private_key" {
  secret_id = "mongo_atlas_private_key"
}
