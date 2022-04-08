provider "aws" {
  region = var.region
  default_tags {
    tags = {
      environment   = var.environment
      owner         = var.owner
      provisionedBy = var.provisioner
      createdAt     = formatdate("YYYY-MM-DD", timestamp())
    }
  }
}




