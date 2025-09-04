resource "aws_ecs_task_definition" "devnology_api_task" {
  family                   = "devnology-api-task"
  cpu                      = "200"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role
  task_role_arn            = aws_iam_role.ecs_task_role

  container_definitions = jsondecode([
    {
      name      = "devnology-api"
      image     = "416997488095.dkr.ecr.sa-east-1.amazonaws.com/devnology-api:6af36880f840271484dcd3165668dd6870f170d0"
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
      environment = [
        {
          name   = "NODE_ENV"
          values = "development"
        },
        {
          name   = "DATABASETYPE_DEV"
          values = "postgres"
        }
      ]
      secrets = [
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
  cpu                      = "200"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role
  task_role_arn            = aws_iam_role.ecs_task_role

  container_definitions = jsondecode([
    {
      name      = "devnologyweb-ui"
      image     = "416997488095.dkr.ecr.sa-east-1.amazonaws.com/devnologyweb-ui:b118b672b9d2aa79e2b46e64784f9354b93b2438"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 3000
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
    }
  ])
}