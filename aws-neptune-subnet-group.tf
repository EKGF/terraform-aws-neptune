
resource "aws_neptune_subnet_group" digital_twin {
  provider    = aws.neptune
  name_prefix = var.vpc_name
  description = "Subnet group to mount Neptune into"
  subnet_ids  = var.subnet_ids
  tags        = merge({ "Name" = var.vpc_name }, local.default_tags)
}
