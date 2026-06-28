resource "aws_eks_node_group" "main" {

  cluster_name = aws_eks_cluster.main.name


  node_group_name = "${local.project_name}-nodes"


  node_role_arn = aws_iam_role.eks_nodes.arn


  subnet_ids = aws_subnet.private[*].id



  scaling_config {

    desired_size = 1

    max_size     = 2

    min_size     = 1
  }



  instance_types = [
    "t3.medium"
  ]



  capacity_type = "ON_DEMAND"



  tags = local.common_tags
}