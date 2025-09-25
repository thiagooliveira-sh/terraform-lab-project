resource "aws_secretsmanager_secret" "rds_credentials" {
  name                    = "devnology/rds/credentials"
  description             = "RDS database credentials for api application"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "rds_credentials_version" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = aws_db_instance.devnology_rds.username
    password = data.aws_ssm_parameter.db_password.value
    engine   = "postgres"
    host     = aws_db_instance.devnology_rds.address
    port     = aws_db_instance.devnology_rds.port
    dbname   = aws_db_instance.devnology_rds.db_name
    jwt      = data.aws_ssm_parameter.jwt_secret.value
    node_env = "development"
    tls      = 0
  })
}