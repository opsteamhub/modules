locals {
  name     = join("-", [var.environment, var.name])
  terraform-git-repo = var.terraform_git_repo

}


