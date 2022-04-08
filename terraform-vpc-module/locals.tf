locals {
  name                     = join("-", [var.environment, var.name])
  enabled                  = true
  enabled_count            = local.enabled ? 1 : 0
  public_subnet_count      = local.enabled && var.max_subnet_count == 0 ? length(flatten(data.aws_availability_zones.available.*.names)) : var.max_subnet_count
  private_subnet_count     = local.enabled && var.max_subnet_count == 0 ? length(flatten(data.aws_availability_zones.available.*.names)) : var.max_subnet_count
  availability_zones_count = local.enabled ? length(var.availability_zones) : 0
  terraform-git-repo = var.terraform_git_repo
  date           = timestamp()
}

data "aws_availability_zones" "available" {
  count = local.enabled_count
}