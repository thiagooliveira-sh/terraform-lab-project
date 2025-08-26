resource "aws_secretsmanager_secret" "rds_credentials" {
    name = "devnology/rds/credentials"
    description = "RDS database credentials for api application"
    recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "rds_credentials_version" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsondecode({
    username = "dummy"
    password = "dummy"
    engine   = "postgres"
    host     = "dummy"
    port     = "dummy"
    dbname   = "dummy"
  })
}