resource "aws_iam_role" "neptune_role" {
  provider             = aws.neptune
  name                 = "${local.stack}-neptune-${var.name}"
  path                 = local.path
  permissions_boundary = local.permissions_boundary
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "monitoring.rds.amazonaws.com",
          "rds.amazonaws.com",
          "sagemaker.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  managed_policy_arns  = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ]
  max_session_duration = 43200 # 12 hours (which is the maximum)
  tags                 = local.default_tags
}

