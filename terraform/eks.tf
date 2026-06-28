resource "aws_eks_cluster" "main" {

  name = local.cluster_name


  version = "1.34"


  role_arn = aws_iam_role.eks_cluster.arn



  vpc_config {

    subnet_ids = concat(
      aws_subnet.private[*].id,
      aws_subnet.public[*].id
    )


    security_group_ids = [
      aws_security_group.eks_cluster.id
    ]


    endpoint_private_access = true


    endpoint_public_access = true
  }



  tags = local.common_tags
}