provider "aws" {
  region = var.region
  default_tags {
    tags = {
      environment   = var.environment
      provisionedBy = var.provisioner
    }
  }
  version = "4.67.0"
}

#terraform {
#  # Optional attributes and the defaults function are
#  # both experimental, so we must opt in to the experiment.
# experiments = [module_variable_optional_attrs]
#}


