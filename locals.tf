locals {

  stack                = "${var.org_short}-${var.project_short}-${var.environment}-${var.name}"
  stack_ci             = "${var.org_short}-${var.project_short}-${var.environment}-${var.name}-ci"
  path                 = "/${var.org_short}-${var.project_short}/${var.environment}/${var.name}/"
  path_ci              = "/${var.org_short}-${var.project_short}/${var.environment}/${var.name}/ci/"
  permissions_boundary = var.iam_permissions_boundary == null ? null : "arn:aws:iam::${var.aws_account_id}:policy/${var.iam_permissions_boundary}"
  cluster_identifier   = var.cluster_identifier == null ? aws_neptune_cluster.cluster[0].cluster_identifier : var.cluster_identifier
  engine               = var.cluster_identifier == null ? "neptune" : data.aws_rds_cluster.cluster[0].engine
  engine_version       = var.cluster_identifier == null ? var.engine_version : data.aws_rds_cluster.cluster[0].engine_version
  subnet_group_name    = var.cluster_identifier == null ? aws_neptune_cluster.cluster[0].neptune_subnet_group_name : data.aws_rds_cluster.cluster[0].db_subnet_group_name
  reader_endpoint      = var.cluster_identifier == null ? aws_neptune_cluster.cluster[0].reader_endpoint : data.aws_rds_cluster.cluster[0].reader_endpoint
  endpoint             = var.cluster_identifier == null ? aws_neptune_cluster.cluster[0].endpoint : data.aws_rds_cluster.cluster[0].endpoint
  port                 = var.cluster_identifier == null ? aws_neptune_cluster.cluster[0].port : data.aws_rds_cluster.cluster[0].port

  default_tags = {
    org_short   = var.org_short
    project     = var.project_short
    environment = var.environment
    vpc         = var.vpc_name
  }
}
