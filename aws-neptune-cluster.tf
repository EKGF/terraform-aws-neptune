#
# See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster
#
resource "aws_neptune_cluster" "cluster" {
  # We don't create this RDS/Neptune cluster if we have to use an existing one
  count    = var.cluster_identifier == null ? 1 : 0
  provider = aws.neptune

  #
  # The name of the cluster cannot be longer than 20 characters, see aws-sagemaker-notebook.tf
  #
  cluster_identifier                   = local.stack
  availability_zones                   = var.aws_availability_zones
  engine                               = var.engine
  engine_version                       = var.engine_version
  backup_retention_period              = 1
  preferred_backup_window              = "07:00-09:00"
  skip_final_snapshot                  = true
  iam_database_authentication_enabled  = false # setting this to true requires signing of all requests to Neptune
  apply_immediately                    = true
  allow_major_version_upgrade          = true
  copy_tags_to_snapshot                = true
  enable_cloudwatch_logs_exports       = ["audit", "slowquery"]
  neptune_cluster_parameter_group_name = aws_neptune_cluster_parameter_group.cluster.name
  iam_roles                            = [aws_iam_role.neptune_role.arn]
  neptune_subnet_group_name            = aws_neptune_subnet_group.digital_twin.name
  vpc_security_group_ids               = var.security_group_ids
  deletion_protection                  = false
  storage_encrypted                    = true
  kms_key_arn                          = aws_kms_key.cluster_key.arn

  serverless_v2_scaling_configuration {
    max_capacity = 20.0
    min_capacity = 16.0
  }

  timeouts {
    create = "60m"
    delete = "2h"
  }

  depends_on = [
    aws_neptune_cluster_parameter_group.cluster,
  ]

  tags = local.default_tags
}

data "aws_rds_cluster" "cluster" {
  # We don't create this RDS/Neptune cluster if we have to use an existing one
  count    = var.cluster_identifier == null ? 0 : 1
  provider = aws.neptune

  cluster_identifier = var.cluster_identifier
}

