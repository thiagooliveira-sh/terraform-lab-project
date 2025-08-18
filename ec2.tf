data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

locals {
  subnet_list = tolist([data.aws_subnet.priv_1.id,data.aws_subnet.priv_2.id,data.aws_subnet.priv_3.id])
}

resource "aws_instance" "aws_instance" {
  count         = length(local.subnet_list)
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t4g.micro"
  subnet_id     = local.subnet_list[count.index]
  iam_instance_profile = "ec2-ssm-role"

  user_data = file("userdata.sh")

  user_data_replace_on_change = true

  tags = {
    Name = "minha-instancia-${count.index + 1}"
    environment = "teste"
  }
}

