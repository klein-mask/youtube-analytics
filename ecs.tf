resource "aws_ecs_cluster" "main" {
  name               = "main"
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
}