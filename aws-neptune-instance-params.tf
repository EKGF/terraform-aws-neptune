#
# Parameter group for the instance-level settings for instances in the cluster
#
resource "aws_neptune_parameter_group" "instance" {
  provider    = aws.neptune
  family      = var.parameter_group_family
  name        = "${local.stack}-${var.name}-instance"
  description = "neptune instance parameter group (${var.name})"

  parameter {
    name  = "neptune_query_timeout"
    value = 1800000 # 30 minutes
  }

  tags = local.default_tags
}

