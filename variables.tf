# terraform/variables.tf

variable "enabled" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
  default     = true
}

variable "name" {
  type        = string
  description = "Logical short name of the cluster e.g. 'staging' or 'primary'"
}

variable "org_short" {
  type        = string
  description = "Short organization name e.g. 'ekgf' or 'acme'"
  default     = "ekgf"
}

variable "project_short" {
  type        = string
  description = "Project id, a short code like 'dt' or 'ekg'"
  default     = "dt" # digital twin
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-2" # London, make sure that this region is also in the list of availability zones
}

variable "aws_availability_zones" {
  type        = list(string)
  description = "AWS Availability Zones"
  default     = ["eu-west-2", "us-east-1a", "us-east-1c"]
}

variable "aws_account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "aws_access_key_id" {
  type        = string
  description = "AWS Access Key ID, passed in via terraform environment variable TF_VAR_aws_access_key_id"
  sensitive   = true
}

variable "aws_secret_access_key" {
  type        = string
  description = "AWS Secret Access Key, passed in via terraform environment variable TF_VAR_aws_secret_access_key"
  sensitive   = true
}

variable "environment" {
  type        = string
  description = "Environment (dev / stage / prod)"
  default     = "dev"
}

variable "vpc_id" {
  type        = string
  description = "ID of existing VPC to deploy into"
}

variable "vpc_name" {
  type        = string
  description = "base of names for the deployed VPC assets (mandatory)"
  default     = "digital-twin"
}

variable "subnet_ids" {
  type        = list(string)
  description = "subnet ids to be used for neptune cluster"
  default     = null
}

variable "iam_permissions_boundary" {
  type        = string
  description = "IAM permissions boundary policy name (ie the part after '/policy/')"
  default     = null
}

variable "cluster_identifier" {
  type        = string
  description = "Optional identifier for the Neptune RDS Cluster if we need to use an existing one"
  default     = null
}

variable "engine" {
  type        = string
  description = "Neptune engine type"
  default     = "neptune"
}

variable "engine_version" {
  type        = string
  description = "Neptune engine version"
  default     = "1.3.0.0"
}

variable "load_buckets" {
  type        = list(string)
  description = "List of S3 buckets to load data from"
  default     = []
}

variable "parameter_group_family" {
  type        = string
  description = "Neptune parameter group family"
  default     = "neptune1.3"
}

variable "port" {
  type        = number
  default     = 8182
  description = "Port used to connect to the Neptune Cluster"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {
    "org_short"   = "ekgf",
    "project"     = "dt"
    "environment" = "dev"
  }
}

variable "ci_role_arn" {
  type        = string
  description = "ARN of the CI role to assume"
}

variable "security_group_ids" {
  type        = set(string)
  description = "List of security group ids to attach to the neptune cluster"
  default     = []
}