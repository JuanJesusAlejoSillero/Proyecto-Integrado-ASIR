/*
  variables.tf
  Archivo de variables para el proyecto con Terraform + AWS

  Variables en uso en los ficheros:
    - providers.tf
    - bucket-s3.tf
    - cloudfront.tf
*/

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "domain" {
  type = string
  default = "www.juanje.eu"
}

variable "aws_arn_certificado" {
  type = string
  default = "arn:aws:acm:us-east-1:540012000352:certificate/958c20ac-8c69-4809-adfc-c75812e3587f"
}
