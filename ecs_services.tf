resource "aws_ecs_service" "devnology_api_service" {
  name            = "devnology-api-service"
  cluster         = aws_ecs_cluster.devnology_cluster.name
  task_definition = aws_ecs_task_definition.devnology_api_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = tolist([data.aws_subnet.priv1, data.aws_subnet.priv2.id, data.aws_subnet.priv3.id])
    security_groups  = [aws_security_group.ecs_task_sg]
    assign_public_ip = false
  }

  depends_on = [
    aws_lb_listener.devnology_web_ui_listner
  ]
}

resource "aws_ecs_service" "devnology_web_ui_service" {
  name            = "devnology-web-ui-service"
  cluster         = aws_ecs_cluster.devnology_cluster.name
  task_definition = aws_ecs_task_definition.devnology_web_ui_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = tolist([data.aws_subnet.priv1, data.aws_subnet.priv2.id, data.aws_subnet.priv3.id])
    security_groups  = [aws_security_group.ecs_task_sg]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.devnology_web_ui_tg.arn
    container_name   = "devnologyweb-ui"
    container_port   = 80
  }
}


resource "aws_lb" "devnology_alb" {
  name                       = "devnology-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.devnology_alb_sg.id]
  subnets                    = tolist([data.aws_subnet.pub1.id, data.aws_subnet.pub2.id, data.aws_subnet.pub3.id])
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "devnology_web_ui_tg" {
  name        = "devnology-web-ui-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.vpc.id
  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "devnology_web_ui_listner" {
  load_balancer_arn = aws_lb.devnology_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "foward"
    target_group_arn = aws_lb_target_group.devnology_web_ui_tg.arn
  }

}