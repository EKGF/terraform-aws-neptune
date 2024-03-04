resource "aws_sagemaker_notebook_instance" "ni" {

  provider               = aws.neptune
  name                   = "aws-neptune-notebook-for-${local.cluster_identifier}"
  role_arn               = aws_iam_role.neptune_role.arn
  instance_type          = "ml.t2.medium"
  #  default_code_repository       = aws_sagemaker_code_repository.digital_twin.code_repository_name
  subnet_id              = tolist(aws_neptune_subnet_group.digital_twin.subnet_ids)[0]
  security_groups        = var.security_group_ids
  lifecycle_config_name  = aws_sagemaker_notebook_instance_lifecycle_configuration.digital_twin.name
  direct_internet_access = "Enabled"

  accelerator_types            = [] # added here to avoid terraform seeing this resource as "tainted"
  additional_code_repositories = [] # added here to avoid terraform seeing this resource as "tainted"

  instance_metadata_service_configuration {
    minimum_instance_metadata_service_version = "2" # added here to avoid terraform seeing this resource as "tainted"
  }

  depends_on = [
    #    aws_sagemaker_code_repository.digital_twin,
    #    module.neptune.aws_neptune_subnet_group.digital_twin,
    aws_sagemaker_notebook_instance_lifecycle_configuration.digital_twin
  ]

  tags = local.default_tags
}

resource "aws_sagemaker_studio_lifecycle_config" "digital_twin" {
  provider                         = aws.neptune
  studio_lifecycle_config_name     = "${local.stack}-lifecycle-config"
  studio_lifecycle_config_app_type = "JupyterServer"
  studio_lifecycle_config_content  = filebase64("${path.module}/files/sagemaker_neptune.sh")

  tags = local.default_tags
}

resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "digital_twin" {
  provider  = aws.neptune
  name      = local.stack # has to be a short name, shorter than 64 characters
  on_create = base64encode("echo foo")
  on_start  = base64encode(templatefile("${path.module}/files/graph_notebook_start_script.tftpl", {
    neptune_cluster_endpoint = local.endpoint,
    neptune_cluster_port     = local.port,
    neptune_role_arn         = aws_iam_role.neptune_role.arn
    neptune_region           = var.aws_region
  }))
}

resource "aws_sagemaker_user_profile" "digital_twin" {
  provider          = aws.neptune
  domain_id         = aws_sagemaker_domain.digital_twin.id
  user_profile_name = "${local.stack}-profile"

  user_settings {
    execution_role  = aws_iam_role.sagemaker.arn
    security_groups = []

    jupyter_server_app_settings {
      lifecycle_config_arns = []

      default_resource_spec {
        instance_type = "system"
      }
    }
  }

  tags = local.default_tags
}

#output "sagemaker_notebook_url" {
#  value = toset([
#    for ni in aws_sagemaker_notebook_instance.ni : ni.url
#  ])
#}
