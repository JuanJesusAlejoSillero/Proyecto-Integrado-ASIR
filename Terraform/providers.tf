/*
  providers.tf
  Archivo de providers para el proyecto con Terraform + AWS
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
