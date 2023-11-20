
#resource "aws_sagemaker_code_repository" "digital_twin" {
#  code_repository_name = "ekgf-digital-twin"
#
#  git_config {
##   repository_url = "https://github.com/hashicorp/terraform-provider-aws.git"
#    repository_url = "${data.github_repository.ekgf_digital_twin.html_url}.git"
#    branch         = "main"
#  }
#}
