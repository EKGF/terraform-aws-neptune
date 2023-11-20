resource "aws_sagemaker_domain" "digital_twin" {
  provider    = aws.neptune
  domain_name = local.stack
  auth_mode   = "IAM"
  vpc_id      = var.vpc_id
  subnet_ids  = aws_neptune_subnet_group.digital_twin.subnet_ids

  default_space_settings {
    execution_role = aws_iam_role.sagemaker.arn
  }

  default_user_settings {
    execution_role = aws_iam_role.sagemaker.arn
  }

  retention_policy {
    home_efs_file_system = "Delete"
  }
}
