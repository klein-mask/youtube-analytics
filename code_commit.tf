resource "aws_codecommit_repository" "youtube" {
  repository_name = var.service_name
}