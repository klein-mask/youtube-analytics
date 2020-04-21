resource "aws_ecs_cluster" "main" {
  name               = "main"
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
}

# サービスのリソース
resource "aws_ecs_service" "service" {
  name             = var.service_name
  cluster          = aws_ecs_cluster.main.arn
  desired_count    = 0
  launch_type      = "FARGATE"
  platform_version = "LATEST"
  task_definition  = aws_ecs_task_definition.task_definition.arn

  network_configuration {
    subnets          = ["${aws_subnet.public.id}"]
    security_groups  = ["${aws_security_group.ecs.id}"]
    assign_public_ip = true

  }
  deployment_controller {
    type = "ECS"
  }
}

# タスクのリソース
resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.service_name}_task_difinition"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  container_definitions    = file("task-definitions/${var.service_name}-task.json")
  execution_role_arn       = aws_iam_role.ecs_task_exec_role.arn
}