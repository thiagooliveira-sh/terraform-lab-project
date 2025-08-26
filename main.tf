provider "aws" {
  region = "sa-east-1"
}

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "thiago-aula-terraform-backend-s3"
    key            = "terraform-initial/terraform.tfstate"
    region         = "sa-east-1"
  }
}