provider "aws" {
  region = var.region
  default_tags {
    tags = merge(
      var.tags,
      {
        Environment   = var.environment
        Owner         = var.owner
        ProvisionedBy = var.provisioner
        CreatedAt     = formatdate("YYYY-MM-DD", timestamp())

      },
    )
  }
}
  