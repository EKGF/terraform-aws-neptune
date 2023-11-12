resource "aws_neptune_cluster_parameter_group" "cluster" {
  provider    = aws.neptune
  family      = var.parameter_group_family
  name        = "${local.stack}-${var.name}-cluster"
  description = "neptune cluster parameter group (${var.name})"

  parameter {
    name         = "neptune_enable_audit_log"
    value        = 1
    apply_method = "pending-reboot"
  }
  #  parameter {
  #    name          = "neptune_lookup_cache" # seems to not be supported for serverless
  #    value         = 0
  #    apply_method  = "pending-reboot"
  #  }
  parameter {
    name         = "neptune_query_timeout"
    value        = 1800000 # 30 minutes
    apply_method = "pending-reboot"
  }

  tags = local.default_tags
}

