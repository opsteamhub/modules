resource "aws_eks_node_group" "eks_node_group" {
  for_each = var.node_groups

  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = each.key == "key" ? format("%s-node-group", local.name) : format("%s-node-group", each.key)
  node_role_arn   = aws_iam_role.eks_node_role_dynamic[each.key].arn

  launch_template {
    id      = aws_launch_template.node[each.key].id 
    version = aws_launch_template.node[each.key].latest_version
  }

  subnet_ids = data.aws_subnet_ids.private.ids 

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
    Name = each.key == "key" ? format("%s-node-group", local.name) : format("%s-node-group", each.key)
  }

}

#####

resource "aws_eks_node_group" "default_eks_node_group" {

  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = format("%s-node-group", local.name)
  node_role_arn   = aws_iam_role.eks_node_role.arn

  launch_template {
    id      = aws_launch_template.default_node.id
    version = aws_launch_template.default_node.latest_version
  }

  subnet_ids = data.aws_subnet_ids.private.ids 

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  dynamic "taint" {
    for_each = var.taints
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
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
    Name = format("%s-node-group", local.name)
  }

}