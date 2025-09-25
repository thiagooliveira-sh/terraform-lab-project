resource "aws_cloudwatch_log_group" "devnology_api_logs" {
  name              = "/ecs/devnology-api"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "devnology_web_ui_logs" {
  name              = "/ecs/devnologyweb-ui"
  retention_in_days = 7
}