resource "aws_eks_node_group" "eks_node_group" {
  for_each = var.node_groups

  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = join("-", [var.environment, each.key, "node-group"])
  node_role_arn   = aws_iam_role.eks_node_role[each.key].arn

  launch_template {
    id      = aws_launch_template.node[each.key].id 
    version = aws_launch_template.node[each.key].latest_version
  }

  subnet_ids = data.aws_subnets.private.ids 

  dynamic "scaling_config" {
    for_each = each.value["scaling_config"] == null ? var.scaling_config : each.value["scaling_config"]
    content {
      desired_size = scaling_config.value["desired_size"]
      max_size     = scaling_config.value["max_size"]
      min_size     = scaling_config.value["min_size"]
    }
  }

  dynamic "taint" {
    for_each = each.value["taint"] == null ? [] : each.value["taint"]
    content {
      key    = taint.value["key"]
      value  = taint.value["value"]
      effect = taint.value["effect"]
    }
  }

  labels = {
    lifecycle = "OnDemand"
  }

  depends_on = [
    aws_launch_template.node,
    aws_iam_role_policy_attachment.eks_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name = join("-", [var.environment, each.key, "node-group"])
  }

}


