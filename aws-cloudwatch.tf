
resource "aws_cloudwatch_log_group" "log_group_neptune_audit" {
  # We don't create this log group if we have to use an existing one
  count = var.cluster_identifier == null ? 1 : 0
  provider = aws.neptune
  name  = "/aws/neptune/${local.cluster_identifier}/audit"

  skip_destroy      = true
  retention_in_days = 3

  tags = local.default_tags
}

data "aws_cloudwatch_log_group" "log_group_neptune_audit" {
  # We don't create this log group if we have to use an existing one
  count = var.cluster_identifier == null ? 0 : 1
  provider = aws.neptune
  name  = "/aws/neptune/${local.cluster_identifier}/audit"
}
