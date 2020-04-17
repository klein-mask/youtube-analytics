terraform {
  required_version = ">= 0.12.0"
  backend "s3" {
    bucket = "tfstate-klein"
    region = "ap-northeast-1"
    key = "youtube-analytics/terraform.tfstate"
    encrypt = true
    dynamodb_table = "terraform_state_lock"
  }
}

provider "aws" {
  version = "~> 2.57"
  region = "ap-northeast-1"
}