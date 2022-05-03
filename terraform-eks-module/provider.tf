provider "aws" {
  region = var.region
  default_tags {
    tags = {
      environment   = var.environment
      provisionedBy = var.provisioner
    }
  }
}

terraform {
  # Optional attributes and the defaults function are
  # both experimental, so we must opt in to the experiment.
  experiments = [module_variable_optional_attrs]
}


