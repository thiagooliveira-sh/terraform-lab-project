resource "aws_db_instance" "devnology_rds" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "15.2"
  instance_class         = "db.t4g.medium"
  db_name                = "devnology_db"
  username               = "devnologyadmin"
  password               = data.aws_ssm_parameter.db_password.value
  parameter_group_name   = "default.postgres15"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.devnology_rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.devnology_db_subnet_group.name
  publicly_accessible    = false
}

resource "aws_db_subnet_group" "devnology_db_subnet_group" {
  name       = "devnology-db-subnet-group"
  subnet_ids = tolist(data.aws_subnet.priv1.id, data.aws_subnet.priv2.id, data.aws_subnet.priv3.id)
}

resource "aws_security_group" "devnology_rds_sg" {
  name        = "devnology-rds-security-group"
  description = "Allow inbound traffic from ecs tasks to rds"
  vpc_id      = data.aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_task_sg.id]
  }
}