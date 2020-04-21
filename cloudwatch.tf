resource "aws_cloudwatch_log_group" "codebuild" {
  name = "/codebuild/ecs-pipeline"
}

resource "aws_cloudwatch_log_group" "youtube_analytics" {
  name = "/ecs/youtube_analytics"
}
