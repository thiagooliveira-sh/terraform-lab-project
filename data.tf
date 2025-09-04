data "aws_subnet" "priv1" {
  filter {
    name   = "tag:Name"
    values = ["home-lab-subnet-private1-sa-east-1a"]
  }
}

data "aws_subnet" "priv2" {
  filter {
    name   = "tag:Name"
    values = ["home-lab-subnet-private2-sa-east-1b"]
  }
}

data "aws_subnet" "priv3" {
  filter {
    name   = "tag:Name"
    values = ["home-lab-subnet-private3-sa-east-1c"]
  }
}

data "aws_subnet" "pub1" {
  filter {
    name   = "tag:Name"
    values = ["home-lab-subnet-public1-sa-east-1a"]
  }
}

data "aws_subnet" "pub2" {
  filter {
    name   = "tag:Name"
    values = ["home-lab-subnet-public2-sa-east-1b"]
  }
}

data "aws_subnet" "pub3" {
  filter {
    name   = "tag:Name"
    values = ["home-lab-subnet-public3-sa-east-1c"]
  }
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["home-lab-vpc"]
  }
}