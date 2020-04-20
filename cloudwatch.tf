resource "aws_cloudwatch_log_group" "codebuild" {
  name = "/codebuild/ecs-pipeline"
}