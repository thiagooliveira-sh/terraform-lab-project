provider "aws" {
  region = "sa-east-1"
}
provider "random" {
}
resource "random_string" "hash" {
  length           = 4
  special          = false
  lower            = true
}

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "thiago-aula-terraform-backend-s3"
    key            = "terraform-initial/terraform.tfstate"
    region         = "sa-east-1"
  }
}