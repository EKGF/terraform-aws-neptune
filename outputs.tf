output "endpoint" {
  value = local.endpoint
}

output "port" {
  value = local.port
}

output "endpoint_url" {
  value = "https://${local.endpoint}:${local.port}"
}

output "reader_endpoint" {
  value = local.reader_endpoint
}

output "reader_endpoint_url" {
  value = "https://${local.reader_endpoint}:${local.port}"
}

output "cluster_identifier" {
  value = var.cluster_identifier == null ? aws_neptune_cluster.cluster[0].cluster_identifier : var.cluster_identifier
}
output "cluster_id" {
  value = var.cluster_identifier == null ? aws_neptune_cluster.cluster[0].id : data.aws_rds_cluster.cluster[0].id
}

output "cluster_subnet_ids" {
  value = aws_neptune_subnet_group.digital_twin.subnet_ids
}

output "role_arn" {
  value = aws_iam_role.neptune_role.arn
}
