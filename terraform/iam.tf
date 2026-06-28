resource "aws_iam_role" "eks_cluster" {

  name = "${local.project_name}-eks-cluster-role"


  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Action = "sts:AssumeRole"

        Effect = "Allow"


        Principal = {

          Service = "eks.amazonaws.com"

        }

      }

    ]

  })


  tags = local.common_tags
}




resource "aws_iam_role_policy_attachment" "eks_cluster" {


  role = aws_iam_role.eks_cluster.name


  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

}




resource "aws_iam_role" "eks_nodes" {


  name = "${local.project_name}-eks-node-role"



  assume_role_policy = jsonencode({

    Version = "2012-10-17"


    Statement = [

      {

        Action = "sts:AssumeRole"


        Effect = "Allow"


        Principal = {

          Service = "ec2.amazonaws.com"

        }

      }

    ]

  })


  tags = local.common_tags
}





resource "aws_iam_role_policy_attachment" "eks_nodes_worker" {


  role = aws_iam_role.eks_nodes.name


  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

}




resource "aws_iam_role_policy_attachment" "eks_nodes_cni" {


  role = aws_iam_role.eks_nodes.name


  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

}




resource "aws_iam_role_policy_attachment" "eks_nodes_registry" {


  role = aws_iam_role.eks_nodes.name


  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}