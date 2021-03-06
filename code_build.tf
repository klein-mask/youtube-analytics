resource "aws_codebuild_project" "main" {
  name          = "ecs-pipeline"
  description   = "ecs pipeline"
  build_timeout = 60
  service_role  = aws_iam_role.codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
  }
  cache {
    type  = "LOCAL"
    modes = ["LOCAL_CUSTOM_CACHE"]
  }

  logs_config {
    cloudwatch_logs {
      status     = "ENABLED"
      group_name = aws_cloudwatch_log_group.codebuild.name
    }
    s3_logs {
      status = "DISABLED"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "ECR_ID"
      value = data.aws_caller_identity.self.account_id
    }

    environment_variable {
      name  = "ECR_NAME"
      value = aws_ecr_repository.youtube.name
    }

    environment_variable {
      name  = "ECR_VERSION"
      value = "latest"
    }
  }
}

