resource "aws_neptune_cluster_instance" "neptune_instance" {
  count                        = 1
  provider                     = aws.neptune
  cluster_identifier           = local.cluster_identifier
  identifier                   = "${aws_neptune_cluster.cluster[0].cluster_identifier}-${count.index}"
  port                         = var.port
  neptune_parameter_group_name = aws_neptune_parameter_group.instance.name
  engine                       = local.engine
  engine_version               = local.engine_version
  instance_class               = "db.serverless"
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  publicly_accessible          = false
  neptune_subnet_group_name    = local.subnet_group_name
  tags                         = local.default_tags
}
