/*
  variables.tf
  Archivo de variables para el proyecto con Terraform + AWS

  Para hacer tests en local:
  $ export TF_VAR_aws_access_key_id="xxxxxxxxxxxxxxx"
  $ export TF_VAR_aws_secret_access_key="xxxxxxxxxxxxxxx"
  $ export TF_VAR_aws_region="us-east-1" # opcional
  $ export TF_VAR_domain="www.juanje.eu" # opcional
  $ terraform plan

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
