terraform {

  required_version = ">=1.2.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">=3.5.1"
    }
  }
}
