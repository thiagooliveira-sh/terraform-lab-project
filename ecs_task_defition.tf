resource "aws_ecs_task_definition" "devnology_api_task" {
  family                   = "devnology-api-task"
  cpu                      = 1024
  memory                   = 2048
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "devnology-api"
      image     = "416997488095.dkr.ecr.sa-east-1.amazonaws.com/devnology-api:872484a24e261e428abec1a6488d12cf300cf69e"
      essential = true
      portMappings = [
        {
          containerPort = 3001
          hostPort      = 3001
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/devnology-api"
          "awslogs-region"        = "sa-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
      secrets = [
        {
          name   = "NODE_ENV"
          valueFrom = "${aws_secretsmanager_secret.rds_credentials.arn}:node_env::"
        },
        {
          name      = "DATABASETYPE_DEV"
          valueFrom = "${aws_secretsmanager_secret.rds_credentials.arn}:engine::"
        },
        {
          name      = "HOST_DEV"
          valueFrom = "${aws_secretsmanager_secret.rds_credentials.arn}:host::"
        },
        {
          name      = "PORT_DEV"
          valueFrom = "${aws_secretsmanager_secret.rds_credentials.arn}:port::"
        },
        {
          name      = "USERNAME_DEV"
          valueFrom = "${aws_secretsmanager_secret.rds_credentials.arn}:username::"
        },
        {
          name      = "PASSWORD_DEV"
          valueFrom = "${aws_secretsmanager_secret.rds_credentials.arn}:password::"
        },
        {
          name      = "DATABASE_DEV"
          valueFrom = "${aws_secretsmanager_secret.rds_credentials.arn}:dbname::"
        },
        {
          name      = "SECRET"
          valueFrom = "${aws_secretsmanager_secret.rds_credentials.arn}:jwt::"
        }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "devnology_web_ui_task" {
  family                   = "devnologyweb-ui-task"
  cpu                      = 1024
  memory                   = 2048
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "devnologyweb-ui"
      image     = "416997488095.dkr.ecr.sa-east-1.amazonaws.com/devnologyweb-ui:3fa840d3ff0595888f3e7aa0085a468ad667e9f5"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/devnologyweb-ui"
          "awslogs-region"        = "sa-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
      environment = [
        {
          name  = "REACT_APP_API_URL"
          value = aws_lb.devnology_alb.dns_name
        }
      ]
    }
  ])
}