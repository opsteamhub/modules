resource "aws_eks_cluster" "eks_cluster" {

  name     = local.name
  role_arn = aws_iam_role.eks_master_role.arn
  version  = var.kubernetes_version

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access

    subnet_ids = data.aws_subnet_ids.private.ids 
  }

  timeouts {
    delete = "30m"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_cluster,
    aws_iam_role_policy_attachment.eks_cluster_service
  ]

}

data "aws_vpc" "vpc" {
  filter {
    name = "tag:environment"
    values = [var.environment]
  }
}

data "aws_subnets" "public" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    tier = var.tag_public_subnet
  }
}

data "aws_subnets" "private" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    tier = var.tag_private_subnet
  }
}
