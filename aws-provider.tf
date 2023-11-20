# Configure the AWS Provider
provider "aws" {
  alias      = "neptune"
  region     = var.aws_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key

  # Assume the IAM Role "${local.stack}-ci-neptune" which gives the current user
  # permission to build all the infrastructure defined in this directory.
  # This only works if the current user has the sts:AssumeRole permission.
  assume_role {
    role_arn = var.ci_role_arn
  }
}

