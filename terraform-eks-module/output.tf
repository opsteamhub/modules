output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.id
}

output "launch_template_name" {
  value = aws_launch_template.node.name
}

output "launch_template_version" {
  value = aws_launch_template.node.latest_version
}

