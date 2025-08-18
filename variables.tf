variable "tags" {
  type = map(string)
  default = {
    "Name"        = "My bucket"
    "Environment" = "Prod"
    "Owner"       = "eu"
    "Conta"       = "AWS"
    "Project"     = "Aulas Terraform"
    "Custo"       = "TI"
  }
}
