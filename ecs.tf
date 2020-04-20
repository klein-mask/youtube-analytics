resource "aws_ecs_cluster" "main" {
  name               = "main"
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
}

# サービスのリソース
resource "aws_ecs_service" "service" {
    name                               = var.service_name
    cluster                            = aws_ecs_cluster.main.arn
    desired_count                      = 1
    launch_type                        = "FARGATE"
    platform_version                   = "LATEST"
    task_definition                    = aws_ecs_task_definition.task_definition.arn

    deployment_controller {
        type = "ECS"
    }
}

# タスクのリソース
resource "aws_ecs_task_definition" "task_definition" {
  family = "sample_task_difinition"
  container_definitions = file("task-definitions/${var.service_name}-task.json")
}