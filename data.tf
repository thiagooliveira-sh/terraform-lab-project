data "aws_subnet" "priv_1" {
  filter {
    name   = "tag:Name"
    values = ["home-lab-subnet-private1-sa-east-1a"]
  }
}

data "aws_subnet" "priv_2" {
  filter {
    name   = "tag:Name"
    values = ["home-lab-subnet-private2-sa-east-1b"]
  }
}

data "aws_subnet" "priv_3" {
  filter {
    name   = "tag:Name"
    values = ["home-lab-subnet-private3-sa-east-1c"]
  }
}