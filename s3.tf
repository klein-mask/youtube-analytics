resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "pipeline-bucket-${var.maintainer}"
  acl    = "private"
}

resource "aws_s3_bucket" "common" {
  bucket = "common-bucket-${var.maintainer}"
  acl    = "private"
}