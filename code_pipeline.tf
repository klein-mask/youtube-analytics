resource "aws_codepipeline" "main" {
  name     = "${var.service_name}-pipeline"
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_bucket.id
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      run_order        = 1
      output_artifacts = ["source"]
      configuration = {
        BranchName : "develop",
        RepositoryName : var.service_name
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = 2
      input_artifacts  = ["source"]
      output_artifacts = ["build"]
      configuration = {
        ProjectName = "ecs-pipeline"
      }
    }
  }
}