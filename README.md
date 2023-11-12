# Terraform AWS Neptune

Set up AWS Neptune with Terraform.

## Current state

This is just a first draft. Feel free to contribute via pull requests.

## Usage

For instance, in your own project, you can add Neptune support by adding the following to your `main.tf`:

```hcl
module "neptune_staging" {
  source                   = "EKGF/terraform-aws-neptune"
  version                  = "0.0.1"
  name                     = "staging"
  org_short                = var.org_short
  project_short            = var.project_short
  aws_region               = var.aws_region
  aws_availability_zones   = var.aws_availability_zones
  aws_account_id           = var.aws_account_id
  aws_access_key_id        = var.aws_access_key_id
  aws_secret_access_key    = var.aws_secret_access_key
  environment              = var.environment
  vpc_name                 = var.vpc_name
  iam_permissions_boundary = var.iam_permissions_boundary
  security_group_ids       = module.dt_vpc.private_security_group_ids
  subnet_ids               = module.dt_vpc.private_subnet_id
  port                     = var.neptune_port
}
```