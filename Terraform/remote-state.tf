/*
  remote-state.tf
  Archivo de configuración de remote state para el proyecto con Terraform + AWS
*/

terraform {
  backend "s3" {
    bucket = "juanje-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
